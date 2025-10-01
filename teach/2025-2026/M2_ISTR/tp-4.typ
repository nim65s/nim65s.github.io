#import "../../../my-slides.typ": *

#set text(lang: "fr")

#show: doc => my-slides(
  doc,
  presentation_title: "TP 4",
  presentation_subtitle: "Université Toulouse Paul Sabatier - KEAT9AA1",
  date: "2025-10-01",
)

#laas-slide(title: "Configuration du projet")[
```bash
$ mkdir low_level
$ cd low_level
$ wget https://gitlab.laas.fr/gsaurel/homepage\
       /-/raw/main/teach/CMakeLists.txt
$ uv add cmake meson
```
]

#laas-slide(title: "Début du projet")[
Créez de fichier `low_level.cpp`:

- Créez une `class Localisation` avec les mêmes attributs que le modèle
- Donnez-lui un constructeur prenant directement les attributs
- Implémentez-lui une méthode d’affichage
- Créez une fonction principale, qui construit une instance et l’affiche
]

#laas-slide(title: "Compilation du projet")[
```
$ cmake -B build -S .
$ cmake --build build
$ ./build/low_level
$ echo build >> .gitignore
```
]

#laas-slide(title: "Récupération des données")[
- Incluez `<cpr/cpr.h>`
- Faites une requette HTTP vers votre route pour une Localisation

ref. #link("https://github.com/libcpr/cpr")
]

#laas-slide(title: "Conversion des données")[
- Incluez `<nlohmann/json.hpp>`
- Parsez le texte JSON fourni dans la réponse HTTP

ref. #link("https://github.com/nlohmann/json/")
]

#laas-slide(title: "Plus de constructeurs")[
- Ajoutez un constructeur prenant un paramètre `json data`
- Ajoutez un constructeur prenant un paramètre `int id`
]

#laas-slide(title: "Plus de modèles")[
- Implémentez les autres modèles
- Utilisez `std::unique_ptr<>` pour les relations
- Utilisez `std::optional<>` pour les attributs non requis
]
