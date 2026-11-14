#import "../my-slides.typ": *

#set text(lang: "fr")

#show: doc => my-slides(
  doc,
  presentation_title: "Pousser nix à $WORK",
  presentation_subtitle: "Retour d’expériences",
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
  date: "2026-11-14",
)

#section-slide("Le quotidien, les collègues")

#laas-slide(title: "Le Contexte: LAAS")[
  #columns(2)[
    #image(width: 14cm, fit: "contain", "../media/laas.jpg")
    #colbreak()
    - Laboratoire du CNRS, Toulouse
    - Automatique, Informatique, Micro & Nano Systèmes, Robotique
    - 24 équipes, 10 services, 700+ personnes
  ]
]

#laas-slide(title: "L’expérience: homes")[
  - home-manager, system-manager, nix-system-graphics, blueprint
  - auto updates

  #align(right)[
    #link("https://gitlab.laas.fr/pi2/homes")
  ]
]

#laas-slide(title: "Le résultat")[
  - 9 users, 15+ hosts, 5 modules (2 home + 3 system)
  - 1 essaimage à Montpellier
  - parfait pour les gens pas au courant
  - limite pour les power users
  - ça prend pas mal
]

#section-slide("L’enseignement")

#laas-slide(title: "Le Contexte: MFJA")[
  #columns(2)[
    #image(width: 14cm, fit: "contain", "../media/mfja.jpg")
    #colbreak()
    - 1500 étudiants de 15 formations
    - Bons desktops windows
    - une petite flotte de laptops linux pour les robots
  ]
]

#laas-slide(title: "L’expérience: mfja-config")[
  - NixOS: laptop / virtualbox
  - blueprint, disko
  - auto updates
  - conf par enseignant

  #align(right)[
    #link("https://github.com/aip-primeca-occitanie/mfja-config")
  ]
]

#laas-slide(title: "Le résultat")[
  - 1 ingé support
  - 2 enseignants
  - ça démarre doucement
]

#section-slide("Le développement")

#laas-slide(title: "Le Contexte: 2RM")[
  #columns(2)[
    #image(width: 14cm, fit: "contain", "../media/logo-cnrs-2rm.png")
    #colbreak()
    - Réseau Métier des Roboticiens et Mécatroniciens
    - quelques ingés par labo (CNRS, INRIA, INRAE, CEA)
  ]
]

#laas-slide(title: "L’expérience: flakoboros")[
  - Packager les logiciels de nos labos
  - Faciliter la maintenance des softs et de la distro
  - Refermer la boucle -> CI/CD & UX/DX
  - Intégration de ROS (CLI)
]

#laas-slide(title: "Le résultat")[
  - Top
  - Encore des trucs à polir, potentiellement breaking
]
