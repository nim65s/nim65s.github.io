#import "../../../my-slides.typ": *

#set text(lang: "fr")


#show: doc => my-slides(
  doc,
  presentation_title: "TP 2",
  presentation_subtitle: "Université Toulouse Paul Sabatier - KEAT9AA1",
  date: "2025-09-25",
)


#laas-slide(title: "On vérifie que tout est dans git")[
  Dans un nouveau dossier:
  ```
  git clone git@github.com:votre-nom/votre-dépôt.git
  ```
]


#laas-slide(title: "Ligne de commande: requêtes sur un modèle")[
  ```
  $ uv add --dev ipython
  $ ./manage.py shell
  ```

  ```python
  In [1]: from high_level.models import Localisation

  In [2]: l = Localisation.objects.first()

  In [3]: l.nom
  Out[3]: 31444

  In [5]: l.local_set.get(nom="TLS-01").surface
  Out[5]: 209
  ```
]
