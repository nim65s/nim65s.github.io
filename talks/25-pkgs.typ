#import "../my-slides.typ": *

#set text(lang: "en")

#show: doc => my-slides(
  doc,
  presentation_title: "Software Distributions",
  presentation_subtitle: "Journée Thématique 2025: Logiciels pour la Robotique",
  date: "2025-09-16",
)

#let pkg(title, logo, height) = laas-slide(
  title: title,
  alignment: horizon + center,
)[
  #image(logo, height: height),
]

#about-me

#pkg("AUR", "../media/aurlogo.png", 30%)
#pkg("ROS", "../media/ros_logo.png", 50%)
#pkg("robotpkg", "../media/robotpkg.png", 80%)
#pkg("Docker", "../media/docker-logo-blue.png", 50%)
#pkg("PyPI", "../media/pypi.svg", 80%)
#pkg("Nix", "../media/nix-snowflake-colours.png", 90%)
#pkg("Guix", "../media/Guix_logo.svg", 90%)
#pkg("repology", "../media/repology-25-09.png", 100%)
