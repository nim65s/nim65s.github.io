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
  Out[3]: "Toulouse"

  In [5]: l.local_set.get(nom="TLS-01").surface
  Out[5]: 209
  ```
]

#laas-slide(title: "Example de fichier de test")[
Éditez `high_level/tests.py`:
```python
from django.test import TestCase

from .models import Machine


class MachineModelTests(TestCase):
    def test_machine_creation(self):
        self.assertEqual(Machine.objects.count(), 0)
        Machine.objects.create(nom="Mélangeur",
                               prix=28_000,
                               cout_maintenance=900,
                               ...)
        self.assertEqual(Machine.objects.count(), 1)
```

`$ ./manage.py test`
]

#laas-slide(title: "Calcul des coûts")[
Implémentez une méthode "`def costs(self):`" dans chaque modèle où ça a un sens:

- `DebitEnergie`
- `ApprovisionnementMatierePremiere`
- `Local`
- `RessourceHumaine`
- `Machine`
]

#laas-slide(title: "Écrire un test unitaire")[
Implémentez un scenario de test qui valide le calcul des coûts dans un cas connu.
Par exemple:

- un `Local` de 50 m²
- dans la `Localisation` Labège à 2 000 €/m²
- avec une `Machine` à 1 000 €, et une autre à 2 000 €
- et en stock
    - 1000 kg de sucre à 10 €/kg
    - 50 m3 d'eau à 15 €/m3

On s’attend à ce que `Usine.objects.first().costs()` vaille 110 750 €
]
