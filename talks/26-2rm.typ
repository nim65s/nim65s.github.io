#import "../my-slides.typ": *

#set text(lang: "fr")

#show: doc => my-slides(
  doc,
  presentation_title: "Refermer la boucle",
  presentation_subtitle: "une solution complète CI/CD & UX/DX",
  date: "2026-06-09",
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

#section-slide("Robotpkg")

#laas-slide(title: "Concept")[
  - meta-"`Makefile`"
  - génération `.deb`
]

#laas-slide(title: "Features")[
  - C/C++, Python, Qt, ROS
  - UX: `apt install` ✅
  - CI: ❓
]

#laas-slide(title: "Rainboard")[
  - 6_000 lignes de python / django
  - 1_000 lignes de bash
  - 15_000 lignes de Dockerfile
  - génère `.gitlab-ci.yaml`
  - (3 ubuntu + 2 debian) x 100 projets
  - synchro github / gitlab
]

#laas-slide(title: "Limitations")[
  - CI: 🤷
  - CD: ❌
  - DX: ❌
]

#section-slide("CMeel")

#laas-slide(title: "Concept")[
  - "Build backend" pour pip qui lance CMake
  - dépendances & LD possible
]

#laas-slide(title: "Features")[
  - Python, CMake
  - UX: `pip install` ✅✅✅
  - CI: ✅
  - CD: ✅
  - DX: 🤷
]

#laas-slide(title: "Limitations")[
  - Distribution: ❌
  - Qt, ROS: ❌
]

#section-slide("ROS")

#laas-slide(title: "Features")[
  - C/C++, Python, Qt, ROS
  - UX: `apt install` / `rosdep` ✅
  - CI: 🤷
  - DX: 🤷
]

#laas-slide(title: "Limitations")[
  - CD: ❌
  - Dépendance à l’OS
]

#section-slide("Docker")

#laas-slide(title: "Features")[
  - UX: ✅
  - CI: ✅
  - DX: ✅
  - CD: ❌
]

#laas-slide(title: "Limitations")[
  - Distribution: ❌
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

#laas-slide(title: "Extends")[
  ```nix
  {
    inputs.flakoboros.url = "github:gepetto/flakoboros";
    outputs = inputs: inputs.flakoboros.lib.mkFlakoboros inputs (
      { lib, ... }: {
        extends.eigen5 = final: prev: { eigen = final.eigen_5; };
        pyOverrideAttrs.eigenpy = { src = lib.cleanSource ./.; };
      }
    );
  }
  ```
]

#laas-slide(title: "ROS / Gazebo")[
  #columns(2)[
    - humble
    - jazzy
    - kilted
    - (lyrical)
    - rolling
    #colbreak()
    - fortress
    - harmonic
    - ionic
    - jetty
  ]
]
#laas-slide(title: "Multi-projects")[
  - workspaces
  - meta-packages
  - vcstool / vcstools / wstool / vcs2l
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
  - Arnaud Tanguy (LIRMM)
  - Olivier Stasse (LAAS)
]
