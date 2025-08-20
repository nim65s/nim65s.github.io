{
  description = "My Homepage";

  inputs = {
    laas-cnrs-typst-templates = {
      url = "https://gitlab.laas.fr/gsaurel/laas-cnrs-typst-templates/-/archive/main/laas-cnrs-typst-templates-main.tar.gz";
      inputs.flake-parts.follows = "flake-parts";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.treefmt-nix.follows = "treefmt-nix";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    pyproject-build-systems = {
      url = "github:pyproject-nix/build-system-pkgs";
      inputs.pyproject-nix.follows = "pyproject-nix";
      inputs.uv2nix.follows = "uv2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pyproject-nix = {
      url = "github:pyproject-nix/pyproject.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    uv2nix = {
      url = "github:pyproject-nix/uv2nix";
      inputs.pyproject-nix.follows = "pyproject-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ inputs.treefmt-nix.flakeModule ];
      systems = [ "x86_64-linux" ];
      perSystem =
        {
          config,
          inputs',
          lib,
          pkgs,
          self',
          system,
          ...
        }:
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [
              (
                _final: prev:
                {
                  inherit (inputs) uv2nix pyproject-nix pyproject-build-systems;
                  inherit (inputs'.laas-cnrs-typst-templates.packages) typst-laas;
                }
                // lib.filesystem.packagesFromDirectoryRecursive {
                  inherit (pkgs) callPackage;
                  directory = ./pkgs;
                }
              )
            ];
          };
          checks = pkgs.lib.mapAttrs' (n: pkgs.lib.nameValuePair "package-${n}") self'.packages;
          devShells = {
            default = pkgs.mkShellNoCC {
              nativeBuildInputs = [ config.treefmt.build.wrapper ];
              inputsFrom = [
                self'.packages.homepage
              ];
              env = {
                TYPST_FONT_PATHS = pkgs.nerd-fonts.hack;
                UV_NO_SYNC = "1";
                UV_PYTHON = lib.getExe' self'.packages.editableVirtualenv "python";
                UV_PYTHON_DOWNLOADS = "never";
              };
              packages = [
                pkgs.pdfpc
                pkgs.typst-laas
                pkgs.watchexec
                pkgs.yarn-berry_4.yarn-berry-fetcher
                self'.packages.editableVirtualenv
              ];
              shellHook = ''
                unset PYTHONPATH
                export REPO_ROOT=$(git rev-parse --show-toplevel)
              '';
            };
          };
          packages = {
            inherit (pkgs)
              homepage
              homepage-venv
              nim65s-talks
              ;
            inherit (pkgs.homepage-venv.passthru) editableVirtualenv virtualenv;
            default = pkgs.homepage;
          };
          treefmt.programs = {
            biome = {
              enable = true;
              excludes = [ "pkgs/missing-hashes.json" ];
            };
            deadnix.enable = true;
            nixfmt.enable = true;
            oxipng.enable = true;
            ruff = {
              check = true;
              format = true;
            };
            typstyle.enable = true;
            yamlfmt.enable = true;
          };
        };
    };
}
