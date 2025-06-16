{
  description = "My Homepages";

  inputs = {
    # laas-cnrs-typst-templates.url = "https://gitlab.laas.fr/gsaurel/laas-cnrs-typst-templates/-/archive/main/laas-cnrs-typst-templates-main.tar.gz";
    laas-cnrs-typst-templates.url = "/home/nim/local/pi2/laas-cnrs-typst-templates";
    flake-parts.follows = "laas-cnrs-typst-templates/flake-parts";
    nixpkgs.follows = "laas-cnrs-typst-templates/nixpkgs";
    treefmt-nix.follows = "laas-cnrs-typst-templates/treefmt-nix";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      imports = [ inputs.treefmt-nix.flakeModule ];
      perSystem =
        {
          inputs',
          lib,
          pkgs,
          self',
          ...
        }:
        {
          checks = pkgs.lib.mapAttrs' (n: pkgs.lib.nameValuePair "package-${n}") self'.packages;
          packages = {
            typst = pkgs.typst.withPackages (p: [
              inputs'.laas-cnrs-typst-templates.packages.laas-cnrs-slides
            ]);
          };
          devShells.default = pkgs.mkShellNoCC {
            packages = [ self'.packages.typst ];
            env.TYPST_FONT_PATHS = pkgs.noto-fonts;
          };
          treefmt.programs = {
            nixfmt.enable = true;
            oxipng.enable = true;
            typstyle.enable = true;
            yamlfmt.enable = true;
          };
        };
    };
}
