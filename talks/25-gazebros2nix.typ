#import "../my-slides.typ": *

#set text(lang: "fr")

#show: doc => my-slides(
  doc,
  presentation_title: "gazebros2nix",
  presentation_subtitle: "ROSConFr 2025",
  date: "2025-11-20",
)

#about-me

#section-slide("Prior Work")

#laas-slide(title: "ROSCon 2022, Kyoto")[
  #columns(2)[
    #image("../media/roscon22-nix.png")
    Better ROS Builds with Nix
    #colbreak()
    #set quote(block: true)
    #quote(attribution: [Mike Purvis & Ivor Wanders, Clearpath Robotics])[
      "cheaper, faster, smaller, more accurate, and more declarative builds of our large autonomy and fleet management codebase"
    ]
  ]
]

#laas-slide(title: "nix-ros-overlay")[
  - #link("https://github.com/lopsided98/nix-ros-overlay")
  - Thanks Ben Wolsieffer (`@lopsided98`)
]

#section-slide("Nix")

#laas-slide(title: "Elevator pitch")[
  #columns(2)[
    - Nix: JSON + fonctions
    - NixOS: Linux / systemd / bootloader / etc.
    - nixpkgs: Github repo
      - \~120 000 packets
      - \~10 000 contributors
      - \~50 000 PR/mois
      - linux/macos x86/arm, countless others
    #colbreak()
    - declarative
    - reproducible
    - atomic changes / upgrades
    - packages / OS / containers / devShells / homeConfiguration / …
  ]
]



#section-slide("State of the art")

#laas-slide(title: "Nix & ROS")[
  - RIP Clearpath Nix
  - `nix-ros-overlay`
    - Ben Wolsieffer lost interest in ROS
    - Michal Sojka (`@wentasah`)
      - set up hydra at CTU
      - got commit access
      - open sourced tooling, like:
        - ros2nix
        - ros-direnv
    - added kilted, dropped noetic (`ros1-25.05` branch)
]

#laas-slide(title: "Nix & Gazebo")[
  - #link("https://github.com/muellerbernd/gazebo-sim-overlay")
  - Des tentatives de PR dans nixpkgs:
    - `@pandapip1` #link("https://github.com/NixOS/nixpkgs/pull/355629")[\#355629]
    - `@ShamrockLee` #link("https://github.com/NixOS/nixpkgs/pull/394757")[\#394757]
    - `@Guelakais` #link("https://github.com/NixOS/nixpkgs/pulls?q=is%3Apr+gz+author%3AGuelakais")[10 PRs]
  - f*ck freeimage
]

#section-slide("gazebros2nix")

#laas-slide(title: "gazebros2nix")[
  - generate `.nix` packages for git repos with `package.xml`
  - generate `.nix` packages for everything in #link("https://github.com/gazebo-tooling/gazebodistro")
  - maintain overrides
  - reproduce ROS Workspaces
]

#laas-slide(title: "PoC")[
  #image("../media/poc.png")
]

#laas-slide(title: "WiP")[
  - Maintain stuff
  - CMake 4 / py3.14 / Qt6
  - Noetic -> Kilted
  - Fortress -> Jetty
  - replace colcon
  - take over the world
  - ???
  - profit
]

#section-slide("Community")

#laas-slide(title: "Let's talk !")[
  - Discourse ROS ?
  - Discourse Nix ?
  - Matrix ?
  - Discord ?
  - GitHub ?
]

#section-slide("Questions")

#about-this-presentation

#section-slide("Bonus")

#laas-slide(title: "`docker debug`")[

  - #link("https://docs.docker.com/reference/cli/docker/debug/")

  - Get a shell into any container or image. An alternative to debugging with `docker exec`.

  - `install [tool1] [tool2]`: Add Nix packages from #link("https://search.nixos.org/packages")
]

#laas-slide(title: "Secrets management")[
  - #link("https://github.com/Mic92/sops-nix")
]

#laas-slide(title: "arm64")[
  - #link("https://github.com/nim65s/nixos-deploiements/")
]
