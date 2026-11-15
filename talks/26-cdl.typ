#import "../my-slides.typ": *

#set text(lang: "fr")

#show: doc => my-slides(
  doc,
  presentation_title: "Packaging circulaire",
  presentation_subtitle: "les bienfaits innatendus du retour aux sources",
  presentation_logos: box(height: 3cm, stack(
    dir: rtl,
    spacing: 9%,
    "",
    image(
      height: 2cm,
      fit: "contain",
      "../media/logo-capitoledulibre-horizontal.svg",
    ),
    "",
  )),
  date: "2026-11-15",
)

#about-me

#laas-slide(title: "$WORK")[
  - Responsable de 100+ logiciels C++ et/ou Python:
    - Maintenance
    - Packaging
    - Conseil
    - Pérennisation
    - Diffusion
  - Développement d’exemples
  - Formations techniques
  - Web
]

#section-slide("Source & Distribution")

#laas-slide(title: "Objectif")[
  - maintenir 100+ dépôts de code source
  - faciliter leur utilisation
]

#laas-slide(title: "Objectif")[
  - maintenir 100+ dépôts de code source
  - faciliter leur utilisation
    - => `apt install`
]

#laas-slide(title: "Objectif")[
  - maintenir 100+ dépôts de code source
  - faciliter leur utilisation
    - => `apt install`
    - => distribution
]

#laas-slide(title: "Objectif")[
  - maintenir 100+ dépôts de code source
  - faciliter leur utilisation
    - => `apt install`
    - => distribution

  robotpkg, apt, aur, homebrew, docker, pypi, conda, nix, ros, ...
]

#laas-slide(title: "Packaging circulaire")[
  - réutiliser la distribution dans la source
  - faciliter les maintenances source & distribution
]

#laas-slide(title: "Packaging circulaire")[
  - réutiliser la distribution dans la source
  - faciliter les maintenances source & distribution
  - => CI/CD & UX/DX en cadeau !
]

#section-slide("Nix")

#laas-slide(title: "Distribution: nixpkgs / NixOS")[
  - 150_000 paquets
  - 600_000 issues/PR
  - 11_000 contributeur•ices

  #link("https://repology.org/repositories/graphs")
]

#laas-slide(title: "Distribution: nixpkgs / NixOS")[
  - 150_000 paquets
  - 600_000 issues/PR
  - 11_000 contributeur•ices

  #link("https://repology.org/repositories/graphs")

  - nix-ros-overlay: 10_000 paquets
  - NUR: 10_000 paquets (500 repos)
  - gazebros2nix: 500 paquets
]

#laas-slide(title: "Packaging circulaire")[
  - source: `https://github.com/stack-of-tasks/pinocchio`
  - distribution: `https://github.com/NixOS/nixpkgs`
  - source: `flake.nix`
  ```nix
  {
    inputs.nixpkgs.url = "github:NixOS/nixpkgs";
    outputs.packages.pinocchio =
      inputs.nixpkgs.pinocchio.overrideAttrs {
        src = ./.;
      };
  }
  ```
]

#section-slide("Flakoboros")

#laas-slide(title: "API")[
  ```nix
  {
    inputs.flakoboros.url = "github:gepetto/flakoboros";
    outputs = inputs: inputs.flakoboros.lib.mkFlakoboros inputs (
      { lib, ... }: {
        overrideAttrs.pinocchio = {
          src = lib.cleanSource ./.;
        };
      }
    );
  }
  ```
]

#laas-slide(title: "Overlays")[
  ```nix
  {
    inputs = {
      flakoboros.url = "github:gepetto/flakoboros";
      jrl-cmake.url = "github:jrl-umi3218/jrl-cmakemodules";
    };
    outputs = inputs: inputs.flakoboros.lib.mkFlakoboros inputs (
      { lib, ... }: {
        overlays = [ inputs.jrl-cmake.overlays.flakoboros ];
        overrideAttrs.pinocchio = { src = lib.cleanSource ./.; };
      }
    );
  }
  ```
]

#laas-slide(title: "ROS / Gazebo distros")[
  #columns(2)[
    - humble
    - jazzy
    - kilted
    - lyrical
    - rolling
    #colbreak()
    - fortress
    - harmonic
    - ionic
    - jetty
    - kura
    - rotary
  ]
]

#laas-slide(title: "ROS Meta-packages: example use")[
  ```bash
  nix shell github:agimus-project/agimus-demos/main#ros-jazzy \
    --command ros2 launch \
                   agimus_demo_03_mpc_dummy_traj \
                   bringup.launch.py \
                   use_gazebo:=true \
                   use_rviz:=true
  ```

  (#link("https://gepetto.github.io/flakoboros/howto/setup-nix"))
]

#laas-slide(title: "ROS Workspaces")[
  - `git clone` / `vcs import`
  - `flakoboros`
  - `colcon build`
]

#laas-slide(title: "un logo et de la doc !", alignment: horizon + center)[
  #image("../media/flakoboros.svg")
  #link("https://gepetto.github.io/flakoboros/")
]

#section-slide("La killer feature")

#laas-slide(title: "Cadeau !")[
  - CI: ✅ `nix build`
  - UX: ✅ `nix run`
  - DX: ✅ `nix develop` / direnv
  - CD: ✅ `github:stack-of-tasks/pinocchio/v4.0.0`
]

#section-slide("Remerciements")

#laas-slide(title: "Tests & Use Cases")[
  - Maximilien Naveau (PAL Robotics)
  - Arnaud Tanguy (LIRMM, UM)
  - Olivier Stasse (LAAS, CNRS)
  - Sébastien Kleff (AUCTUS, INRIA)
]

#laas-slide(title: "Vous :)")[
  Liens:
  - #link("https://github.com/NixOS/nixpkgs")
  - #link("https://github.com/lopsided98/nix-ros-overlay")
  - #link("https://github.com/gepetto/flakoboros")
  - #link("https://github.com/gepetto/gazebros2nix")
  - Matrix: `#flakoboros:laas.fr`
]
