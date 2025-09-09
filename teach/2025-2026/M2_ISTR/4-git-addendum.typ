#import "../../../my-slides.typ": *

#set text(lang: "fr")

#show: doc => my-slides(
  doc,
  presentation_title: "Git (addendendum)",
  presentation_subtitle: "Université Toulouse Paul Sabatier - KEAT9AA1",
  date: "2025-09-09",
)

#laas-slide(title: "squash")[
  Remplace plusieurs commits par un seul
  ```
  $ git commit -a -m "add controller.py"
  $ ruff format controller.py
  $ git commit -a -m "fix controller.py format"
  $ git squash HEAD~2 "add controller.py"
  ```
]

#laas-slide(title: "squash in rebase -i")[
  #columns(2)[
    ```
    pick 5447539 # a
    pick 954b4fa # b
    pick 301c744 # c
    pick e35a809 # d
    ```
    #colbreak()
    ```
    pick 5447539 # a
    squash 954b4fa # b
    squash 301c744 # c
    pick e35a809 # d
    ```
  ]
]

#laas-slide(title: "amend")[
  Modifie le dernier commit
  ```
  $ git commit -a -m "add controller.py"
  $ ruff format controller.py
  $ git commit -a --amend
  ```
]

#laas-slide(title: "fixup")[
  Modifie n'importe quel commit
  ```
  $ git add controller.py
  $ git commit -m "add controller.py"
  $ git add logo.svg
  $ git commit -m "add logo.svg"
  $ ruff format controller.py
  $ git commit -a --fixup "add controller.py"
  $ git rebase -i --autosquash
  ```
]


#laas-slide(title: "reflog")[
  ```
  035b15c (HEAD -> main) HEAD@{0}: rebase (finish): returning to refs/heads/main
  035b15c (HEAD -> main) HEAD@{1}: rebase (pick): d
  80096c4 HEAD@{2}: rebase (squash): final
  ec8efcb HEAD@{3}: rebase (squash): # Ceci est la combinaison de 2 commits.
  5447539 HEAD@{4}: rebase (start): checkout HEAD~4
  e35a809 HEAD@{5}: commit: d
  301c744 HEAD@{6}: commit: c
  954b4fa HEAD@{7}: commit: b
  5447539 HEAD@{8}: commit: a
  10188f8 HEAD@{9}: commit (initial): init
  ```
]
