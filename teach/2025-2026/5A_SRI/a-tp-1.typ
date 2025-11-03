#import "../../../my-slides.typ": *

#set text(lang: "en")

#show: doc => my-slides(
  doc,
  presentation_title: "TP 1",
  presentation_subtitle: "UPSSITECH - KUPR9BC3",
  date: "2025-11-03",
)

#laas-slide(title: "Pre-requis")[

- curl: `curl --version`
- Git: `git --version`
- uv: `curl -LsSf \ https://astral.sh/uv/install.sh | sh`

]

#laas-slide(title: "Création d’un projet")[

```bash
$ uv init tp-multithreading
$ cd tp-multithreading
```

]

#laas-slide(title: "Configuration d’un dépôt distant")[

- Sur #link("https://github.com"), créer un compte puis un dépôt:
    - sans fichier README.md
    - sans license
    - sans .gitignore

]

#laas-slide(title: "Génération d’une paire de clefs SSH")[

```bash
$ ssh-keygen -t ed25519
$ cat ~/.ssh/id_ed25519.pub
```

#link("https://github.com/settings/ssh/new")
]

#laas-slide(title: "Configuration de git")[
```bash
$ git config --global user.name "John Doe"
$ git config --global user.email johndoe@example.fr
```

]

#laas-slide(title: "Publication du projet")[

```bash
$ git remote add origin \
    git@github.com:votre-nom/votre-dépôt.git
$ git add .
$ git commit -m "start uv project"
$ git branch -M main
$ git push -u origin main
```

]

#laas-slide(title: "Configuration des outils")[

```bash
$ curl https://gitlab.laas.fr/gsaurel/homepage\
       /-/raw/main/.pre-commit-config.yaml \
       -o .pre-commit-config.yaml
$ uv add --dev pre-commit
$ uv run pre-commit install
$ uv run pre-commit run -a
```
]

#laas-slide(title: "Configuration des outils (suite)")[

```bash
$ uv run pre-commit run -a  # encore
$ git add .
$ git commit -m "setup tooling"
$ git push
```

]

#laas-slide(title: "License")[

Depuis l’UI github:

- Ajoutez un fichier appelé `LICENSE` et choisissez un template

puis `git pull`

]

#laas-slide(title: "Task")[

```bash
$ uv add numpy
$ curl https://gitlab.laas.fr/gsaurel/homepage\
       /-/raw/main/src/task.py \
       -o task.py
```

Ce fichier contient une classe `Task` qui permet de résoudre $A x = B$ en mesurant le temps nécessaire à cette résolution.

]

#laas-slide(title: "Test")[

Ajoutez un fichier `test_task.py` en suivant l’example basique `unittest`.

Vérifiez avec `numpy.testing.assert_allclose` que $A x$ est égal à $B$

]

#laas-slide(title: "Échec")[
#set text(size: 18pt)
```python
AssertionError:
Not equal to tolerance rtol=1e-07, atol=0

Mismatched elements: 552 / 552 (100%)
Max absolute difference among violations: 0.99605365
Max relative difference among violations: 1.
 ACTUAL: array([0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0.,
       0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0.,
       0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0.,...
 DESIRED: array([4.986837e-01, 5.483427e-01, 4.227059e-01, 4.571329e-01,
       4.451978e-01, 5.737015e-03, 1.497679e-01, 8.135376e-01,
       6.948812e-01, 6.933447e-01, 2.165097e-01, 8.155400e-01,...

----------------------------------------------------------------------
Ran 1 test in 0.020s

FAILED (failures=1)
```

]

#laas-slide(title: "Intégration continue")[

Ajoutez un fichier `.github/workflows/ci.yml`, qui vérifie:

- les outils: `uv run pre-commit run -a`
- les tests: `uv run python -m unittest`

et qui s’execute `on: [push]`

ref. #link("https://docs.astral.sh/uv/guides/integration/github")

En python 3.10, 3.11, 3.12, 3.13, et 3.14
]
