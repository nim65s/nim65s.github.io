#import "../../../my-slides.typ": *

#set text(lang: "fr")

#show: doc => my-slides(
  doc,
  presentation_title: "TP 2",
  presentation_subtitle: "Université Toulouse Paul Sabatier - KEAT9AA1",
  date: "2025-09-29",
)

#laas-slide(title: "On vérifie que tout est dans git")[
  Dans un nouveau dossier:
  ```
  git clone git@github.com:votre-nom/votre-dépôt.git
  ```
]

#laas-slide(title: "Interface interactive python")[
  ```
  $ uv add --dev ipython
  $ ./manage.py shell
  ```

  ```python
  In [1]: from high_level.models import Ville

  In [2]: l = Ville.objects.first()

  In [3]: l.nom
  Out[3]: "Toulouse"

  In [4]: l.lieu_set.get(nom="TLS-01").superficie
  Out[4]: 209
  ```
]

#laas-slide(title: "Example de fichier de test")[
  ```python
  # high_level/tests.py
  from django.test import TestCase

  from .models import Machine


  class MachineModelTests(TestCase):
      def test_machine_creation(self):
          self.assertEqual(Machine.objects.count(), 0)
          Machine.objects.create(nom="CNC", prix=28_000, ...)
          self.assertEqual(Machine.objects.count(), 1)
  ```

  `$ ./manage.py test`
]

#laas-slide(title: "Calcul des coûts")[
  Implémentez une méthode "`def costs(self):`" dans chaque modèle où ça a un sens:

  - `Produit`
  - `Operation`
  - `QuatiteProduit`
  - `Stock`
  - `Lieu`
  - `Ville`
  - `Transport`
  - `PointDeVente`
  - `Machine`
  - `QuantiteMachine`
]

#laas-slide(title: "Écrire un test unitaire", display-footer: false)[
  #text(18pt)[
    Implémentez un scenario de test qui valide le calcul des coûts dans un cas connu.
    Par exemple:
  ]

  - #text(18pt)[un `Lieu` de 50 m² qui consomme 5 000 kWh]
  - #text(18pt)[dans la `Ville` Labège à 2 000 €/m²]
  - #text(18pt)[dans le `Pays` France où]
    - #text(16pt)[l’electricité vaut 0.2 € / kWh]
    - #text(16pt)[le salaire minimum vaut 12 € / h]
  - #text(18pt)[avec une `Machine` à 10 000 €, et une autre à 5 000 €]
  - #text(18pt)[et en stock]
    - #text(16pt)[2 palette de tubes d’acier à 1 000 €]
    - #text(16pt)[1 palette de câbles à 3 000 €]

  #text(18pt)[
    On s’attend à ce que `Local.objects.first().costs()` vaille 111 000 €
  ]
]
