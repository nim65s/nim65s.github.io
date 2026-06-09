#import "../my-slides.typ": *

#set text(lang: "fr")

#show: doc => my-slides(
  doc,
  presentation_title: "ROS Software with Nix",
  presentation_subtitle: "Gazebros2nix & Flakoboros",
  date: "2026-05-28",
)

#section-slide("ROS: Source & Distribution")

#laas-slide(title: "ROS Package source")[
  - 1 repo (git)
  - 1+ `package.xml`:
  ```xml
  <?xml version="1.0"?>
  <package format="3">
    <name>tsid</name>
    <version>1.10.0</version>
    <description>Efficient Task Space Inverse Dynamics (TSID) based on Pinocchio</description>
    <license>BSD-2-Clause</license>
    <url>https://github.com/stack-of-tasks/tsid</url>
    …
  ```
]

#laas-slide(title: "ROS distribution")[
  - #link("https://github.com/ros/rosdistro/")
  `lyrical/distribution.yaml`:
  ```yaml
  linear_feedback_controller_msgs:
    release:
      tags:
        release: release/lyrical/{package}/{version}
      url: https://github.com/ros2-gbp/tsid-release.git
      version: 1.10.0-1
  ```
  => `sudo apt install ros-lyrical-tsid`
]

#section-slide("Nix & ROS")

#laas-slide(title: "nix-ros-overlay")[
  #link("https://github.com/lopsided98/nix-ros-overlay"):
  - import rosdistro => 9k packages, 10% build failures
  - nix => reproducible, lockable, cachable, etc.
  - no sudo setup of apt repositories required
  - any linux
  - jump between humble, jazzy, kilted, lyrical, rolling
  ```bash
  nix develop .#example-ros2-desktop-jazzy
  ros2 launch demo_nodes_cpp talker_listener_launch.xml
  ```
]

#laas-slide(title: "gazebros2nix")[
  - Gazebo (fortress, harmonic, ionic, jetty)
  - ROS packages not in rosdistro
  => #link("https://github.com/Gepetto/gazebros2nix")
  - Tell me what you need !
]

#section-slide("Circular Packaging")

#laas-slide(title: "Circular Packaging")[
  - plug the distro back in the source
  - ease source & distribution maintenance
  - provide trivial CI/CD for free
  - enhance UX/DX
]

#laas-slide(title: "flakoboros")[
  #link("https://github.com/Gepetto/flakoboros")
  Docs: #link("https://gepetto.github.io/flakoboros/")
  ```nix
  {
    inputs.flakoboros.url = "github:gepetto/flakoboros";
    outputs = inputs: inputs.flakoboros.lib.mkFlakoboros inputs (
      { lib, ... }:
      {
        rosOverrideAttrs.tsid = {
          src = lib.fileset.toSource { root = ./.; };
        };
      }
    );
  }
  ```
]

#laas-slide(title: "use")[
  - CI:
    - `nix build .`
    - `nix build .#ros-lyrical`
  - CD:
    - `nix run github:stack-of-tasks/tsid`
  - DX:
    - `nix develop .#ros-rolling`
    - `echo 'use flake .#ros-humble' > .envrc`
  - UX:
    - ```
      nix shell github:agimus-project/agimus-demos#ros-humble --command \
        ros2 launch agimus_demo_03_mpc_dummy_traj bringup.launch.py
      ```
]

#section-slide("Multi-repo")

#laas-slide(title: "vcstool / vcstools / wstool / vcs2l")[
  ```yaml
  repositories:
    agimus-demos:
      type: git
      url: git@github.com:agimus-project/agimus-demos
      version: 105f9d51f9c94a0cf5879d6f4c4673aca39f3ba5
    agimus-franka-description:
      type: git
      url: git@github.com:agimus-project/franka_description
      version: fb4f03582d2492384a69f77e3e85fbc006119a2d
    agimus-franka-ros2:
      type: git
      url: gh:agimus-project/agimus-franka-ros2
      version: 2719804b4ed7b2d4ef12d8ae4be34e0a5e1ac5cc
  ```
]

#laas-slide(title: "flake.nix")[
  ```nix
  {
    inputs.gepetto.url = "github:gepetto/nix";
    outputs = inputs: inputs.gepetto.lib.mkFlakoboros inputs (
      { lib, ... }:
      {
        extraDevRosPackages = [
          "agimus-controller"
          "agimus-demo-03-mpc-dummy-traj"
          "agimus-franka-description"
          "agimus-franka-ros2"
          …
  ```
  `fd package.xml src -x xq .package.name | tr _ - | sort -u`
]

#laas-slide(title: "example use case: agimus franka")[
  - reproduced docker setup humble / fortress
  - renamed fork
  - checked on the robot
  - ported to jazzy / harmonic
]
