#import "../my-slides.typ": *

#set text(lang: "fr")

#show: doc => my-slides(
  doc,
  presentation_title: "flakoboros",
  presentation_subtitle: "l’introduction au packaging circulaire pour ROS",
  date: "2026-06-27",
)

#section-slide("Source & Distribution")

#laas-slide(title: "Objectif")[
  - maintenir un dépôt de code source
  - faciliter son utilisation
]

#laas-slide(title: "Objectif")[
  - maintenir un dépôt de code source
  - faciliter son utilisation
    - => `apt install`
]

#laas-slide(title: "Objectif")[
  - maintenir un dépôt de code source
  - faciliter son utilisation
    - => `apt install`
    - => distribution
]

#laas-slide(title: "Objectif")[
  - maintenir un dépôt de code source
  - faciliter son utilisation
    - => `apt install`
    - => distribution
]

#laas-slide(title: "Packaging circulaire")[
  - réutiliser les informations de la distribution dans la source
  - maintenance de la source et de la distriubtion facilitées
  - => CI/CD & UX/DX en cadeau !
]

#section-slide("Nix")

#laas-slide(title: "Features")[
  - CI: ✅ `nix build`
  - UX: ✅ `nix run`
  - DX: ✅ `nix develop` / direnv
  - CD: ✅ `github:stack-of-tasks/pinocchio/v4.0.0`
]

#laas-slide(title: "Distribution: nixpkgs / NixOS")[
  - 100_000+ paquets
  - 500_000+ issues/PR
  - 10_000+ contributeur•ices

  #link("https://repology.org/repositories/graphs")
]

#laas-slide(title: "Distribution: nixpkgs / NixOS")[
  - 100_000+ paquets
  - 500_000+ issues/PR
  - 10_000+ contributeur•ices

  #link("https://repology.org/repositories/graphs")

  - nix-ros-overlay: 8_000+ paquets
  - NUR: 6_000+ paquets
]

#laas-slide(title: "Packaging circulaire")[
  - source: `https://github.com/stack-of-tasks/pinocchio`
  - distribution: `https://github.com/NixOS/nixpkgs`
  - source: `flake.nix`
  ```nix
  {
    inputs.pkgs.url = "github:NixOS/nixpkgs";
    outputs.packages.pinocchio =
      inputs.pkgs.pinocchio.overrideAttrs {
        src = ./.;
      };
  }
  ```
]

#laas-slide(title: "Maintenance")[
  - Impacts des mises à jour de nixpkgs dans pinochhio
  - Impacts des mises à jour de pinocchio dans nixpkgs
]

#section-slide("Flakoboros")

#laas-slide(title: "API")[
  ```nix
  {
    description = "Bindings between Numpy and Eigen";
    inputs.flakoboros.url = "github:gepetto/flakoboros";
    outputs = inputs: inputs.flakoboros.lib.mkFlakoboros inputs (
      { lib, ... }: {
        pyOverrideAttrs.eigenpy = { src = lib.cleanSource ./.; };
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
        pyOverrideAttrs.eigenpy = { src = lib.cleanSource ./.; };
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
  ]
]

#laas-slide(title: "Gazebros2nix")[
  - nix-ros-overlay for gazebodistro
  - community ROS packages
]

#laas-slide(title: "ROS Meta-packages")[
  ```nix
  {
    inputs.gazebros2nix.url = "github:gepetto/gazebros2nix";
    outputs = inputs: inputs.flakoboros.lib.mkFlakoboros inputs (
      { lib, ... }: {
        pyOverrideAttrs.eigenpy = { src = lib.cleanSource ./.; };
      }
    );
  }
  ```

]

#laas-slide(title: "ROS Workspaces")[
  - `git clone` / `vcs import`
  - `flakoboros` (New !)
  - `colcon build`
]

#laas-slide(title: "Bring your own distribution(s)")[
  - nixpkgs
  - nix-ros-overlay
  - gazebros2nix
  - gepetto
]

#laas-slide(title: "un logo et de la doc !", alignment: horizon + center)[
  #image("../media/flakoboros.svg")
  #link("https://gepetto.github.io/flakoboros/")
]

#section-slide(rainbow[Remerciements])

#laas-slide(title: "Tests & Use Cases")[
  - Maximilien Naveau (PAL Robotics)
  - Arnaud Tanguy (LIRMM, UM)
  - Olivier Stasse (LAAS, CNRS)
  - Sébastien Kleff (AUCTUS, INRIA)
]

#laas-slide(title: "Vous")[
  Liens:
  - #link("https://github.com/NixOS/nixpkgs")
  - #link("https://github.com/lopsided98/nix-ros-overlay")
  - #link("https://github.com/gepetto/flakoboros")
  - #link("https://github.com/gepetto/gazebros2nix")
]
