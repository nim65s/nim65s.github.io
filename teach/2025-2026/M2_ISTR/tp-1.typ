#import "../../../my-slides.typ": *

#set text(lang: "fr")


#show: doc => my-slides(
  doc,
  presentation_title: "TP 1",
  presentation_subtitle: "Université Toulouse Paul Sabatier - KEAT9AA1",
  date: "2025-09-19",
)

#about-this-presentation

#laas-slide(title: "Pre-requis", alignment: top + left)[
- Git: `git --version`
- uv: `uv --version`
]

#laas-slide(title: "Pre-requis", alignment: top + left)[
- Git: `git --version`
- uv: `uv --version`

```
$ git config --global user.name "John Doe"
$ git config --global user.email johndoe@example.com
```
#link("https://homepages.laas.fr/gsaurel/teach/2025-2026/M2_ISTR/6-python-api.pdf")
]

#laas-slide(title: "Création d’un projet", alignment: top + left)[
```bash
$ uv init tp_coo
$ cd tp_coo
$ git add .
$ git commit -m "uv init tp_coo"
```
]

#laas-slide(title: "Création d’un projet", alignment: top + left)[
```bash
$ uv init tp_coo
$ cd tp_coo
$ git add .
$ git commit -m "uv init tp_coo"
$ uv add django
$ git add .
$ git commit -m "uv add django"
$ source .venv/bin/activate
```
]

#laas-slide(title: "Création d’un projet", alignment: top + left)[
```bash
$ uv init tp_coo
$ cd tp_coo
$ git add .
$ git commit -m "uv init tp_coo"
$ uv add django
$ git add .
$ git commit -m "uv add django"
$ source .venv/bin/activate
$ django-admin startproject boissons
$ git add .
$ git commit -m "django-admin startproject boissons"
```
]

#laas-slide(title: "Configuration d’un dépôt distant", alignment: top + left)[
- Créer un compte puis un dépôt sur github:
    - sans fichier README.md
    - sans license
    - sans .gitignore
]

#laas-slide(title: "Configuration d’un dépôt distant", alignment: top + left)[
- Créer un compte puis un dépôt sur github:
    - sans fichier README.md
    - sans license
    - sans .gitignore

```bash
$ ssh-keygen -t ed25519
$ cat ~/.ssh/id_ed25519.pub
```

#link("https://github.com/settings/ssh/new")
]

#laas-slide(title: "Publication du projet")[
```bash
$ git branch -M main
$ git remote add origin \
    git@github.com:votre-nom/votre-dépôt.git
$ git push -u origin main
```
]

#laas-slide(title: "Configuration des outils", alignment: top + left)[
```bash
$ wget https://gitlab.laas.fr/gsaurel/homepage\
       /-/raw/main/.pre-commit-config.yaml
$ uv add --dev pre-commit
$ git add .
$ git commit -m "setup tooling"
$ pre-commit install
$ pre-commit run -a
```
]

#laas-slide(title: "Configuration des outils", alignment: top + left)[
```bash
$ wget https://gitlab.laas.fr/gsaurel/homepage\
       /-/raw/main/.pre-commit-config.yaml
$ uv add --dev pre-commit
$ git add .
$ git commit -m "setup tooling"
$ pre-commit install
$ pre-commit run -a
```
```bash
$ pre-commit run -a
$ git add .
$ git commit -m "pre-commit run -a"
$ git push
```
]

#laas-slide(title: "License & gitignore")[
Depuis l’UI github:

- Ajoutez un fichier `LICENSE` et choisissez un template
- Éditez `.gitignore` et choisissez le template python

puis `git pull`
]

#laas-slide(title: "Création d’une application")[
```bash
$ cd boissons
$ ./manage.py startapp high_level
# éditez boissons/settings.py:
# ajoutez `high_level` dans `INSTALLED_APPS`
$ git add .
$ git commit -m "start app high_level"
$ git push
```
]

#laas-slide(title: "Modèles")[
#image("../../../media/boissons.png")
#link("https://gitlab.laas.fr/gsaurel/homepage/-/raw/main/media/boissons.svg")
]

#laas-slide(title: "Création des modèles")[
Éditez `high_level/models.py`:
- nombres: `models.IntegerField()`
- texte: `models.CharField(max_length=100)`
- relation vers plusieurs objets:
```python
models.ManyToManyField(Machine)
```
- relation vers un objet:
```python
models.ForeignKey(
    Local, on_delete=models.PROTECT,
    # blank=True, null=True, related_name="+",
)
```
]

#laas-slide(title: "Création des modèles: class Abstraite")[
```python
class QuantiteMatierePremiere(models.Model):
    quantite = models.IntegerField()
    matiere_premiere = models.ForeignKey(
        MatierePremiere,
        on_delete=models.PROTECT,
    )

    class Meta:
        abstract = True
```
]

#laas-slide(title: "Création de l’interface d’administration")[
Éditez `high_level/admin.py`

```bash
$ ./manage.py makemigrations
$ ./manage.py migrate
$ ./manage.py createsuperuser
$ git add .
$ git commit -m "add high_level models & admin"
$ git push
$ ./manage.py runserver
```
]

#laas-slide(title: "Utilisation de l’interface d’administration")[
#link("http://localhost:8000/admin")

- Ajoutez une méthode "`__str__(self):`" dans chaque modèle
- Créez au moins un objet de chaque modèle
]
