#import "../../../my-slides.typ": *

#set text(lang: "en")

#show: doc => my-slides(
  doc,
  presentation_title: "TP 3",
  presentation_subtitle: "UPSSITECH - KUPR9BC3",
  date: "2025-12-05",
)

#laas-slide(title: "Interopérabilité C++ / Python: JSON")[
  #link("https://docs.python.org/3/library/json.html")
]

#laas-slide(title: "Sérialisation Python")[
  Ajouter une méthode dans la class `Task`:

  ```python
  def to_json(self) -> str:
  ```
]

#laas-slide(title: "Désérialisation Python")[
  Ajouter une méthode dans la class `Task`:

  ```python
  @staticmethod
  def from_json(text: str) -> "Task":
  ```
]

#laas-slide(title: "Définir l’égalité")[
  Ajouter une méthode dans la class `Task`:

  ```python
  def __eq__(self, other: "Task") -> bool:
  ```
]

#laas-slide(title: "Tester l’égalité")[
  Écrire un test unitaire qui:

  - instancie une première

    ```python
    a = Task()
    ```

  - une seconde à partir de la sérialisation de la première

    ```python
    txt = a.to_json()
    b = Task.from_json(txt)
    ```

  - puis s’assure que `a == b`
]
