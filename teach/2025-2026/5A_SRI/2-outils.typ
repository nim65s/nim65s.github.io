#import "../../../my-slides.typ": *

#set text(lang: "fr")

#show: doc => my-slides(
  doc,
  presentation_title: "Outils Python & C++",
  presentation_subtitle: "UPSSITECH - KUPR9BC3",
  date: "2025-09-25",
)

#section-slide("Vous")

#laas-slide(title: "Ergonomie")[
  - hauteurs
  - position
  - distances

  Adaptez votre environement
]

#laas-slide(title: "Clavier", alignment: center)[
  #image("../../../media/bepo.png")

  #link("https://bepo.fr")[`bépo.fr`]

  #link("https://ergol.org/")[`ergol.org`]
]

#section-slide("Style")

#laas-slide(title: "Écrire du code lisible")[
  > Code is read much more often than it is written

  #set align(right)

  --- Guido Van Rossum
]

#laas-slide(title: "PEP 8")[
  #link(
    "https://peps.python.org/pep-0008/",
  )[`https://peps.python.org/pep-0008/`]

  ```python
  print ( "hello" )
  ```

  ```
  ╰─>$ flake8 hello-spaces.py
  hello-spaces.py:1:6: E211 whitespace before '('
  hello-spaces.py:1:8: E201 whitespace after '('
  hello-spaces.py:1:16: E202 whitespace before ')'
  ```
]

#laas-slide(title: "black")[
  #link("https://github.com/psf/black")[`https://github.com/psf/black`]

  ```
  ╰─>$ black hello-spaces.py
  reformatted hello-spaces.py

  All done!
  1 file reformatted.
  ```

  ```diff
  -print ( "hello" )
  +print("hello")
  ```
]

#laas-slide(title: "clang-format")[

  #link(
    "https://clang.llvm.org/docs/ClangFormat.html",
  )[https://clang.llvm.org/docs/ClangFormat.html]

  ```bash
  ╰─>$ clang-format -i QGVScene.cpp
  ```

  ```diff
  -for( auto node : _nodes ) {
  -  node->update_layout();
  -}
  +for (auto *node : _nodes) node->update_layout();
  ```
]

#section-slide("Analyse Statique")

#laas-slide(title: "Mypy: motivation")[

  ```python
  def add(a: int, b: int) -> int:
      """Performs addition on integers.

      >>> add(3, 4)
      7
      """
      return a + b


  if __name__ == "__main__":
      import sys
      print(add(sys.argv[1], sys.argv[2]))
  ```
]

#laas-slide(title: "Mypy")[

  ```
  ╰─>$ python add.py 3 4
  34
  ```


  ```
  ╰─>$ mypy add.py
  add.py:13: error: Argument 1 to "add" has incompatible
                    type "str"; expected "int"
  add.py:13: error: Argument 2 to "add" has incompatible
                    type "str"; expected "int"
  Found 2 errors in 1 file (checked 1 source file)
  ```

]

#laas-slide(title: "pyupgrade")[

  #link(
    "https://github.com/asottile/pyupgrade",
  )[https://github.com/asottile/pyupgrade]

  ```diff
   class C(Base):
       def f(self):
  -        super(C, self).f()
  +        super().f()
  ```

  En C++: `clang-tidy`

]

#section-slide("Méta")

#laas-slide(title: "Éditeur de texte / IDE")[

  Bring your own ;)

]

#laas-slide(title: "pre-commit")[

  #link(
    "https://github.com/pre-commit/pre-commit",
  )[https://github.com/pre-commit/pre-commit]

  ```bash
  ╰─>$ cat .pre-commit-config.yaml
  ```

  ```yaml
  repos:
    - repo: https://github.com/psf/black
      rev: 22.8.0
      hooks:
        - id: black
    - repo: https://github.com/pre-commit/mirrors-clang-format
      rev: v14.0.6
      hooks:
        - id: clang-format
  ```

]

#laas-slide(title: "pre-commit: utilisation")[

  #link(
    "https://github.com/pre-commit/pre-commit",
  )[https://github.com/pre-commit/pre-commit]

  ```
  ╰─>$ pre-commit run -a
  ```

  ```
  ╰─>$ pre-commit install
  ```

]

#laas-slide(title: "pre-commit CI")[

  #link("https://pre-commit.ci/")[https://pre-commit.ci/]


]

#section-slide("Rust")

#laas-slide(title: "Ruff")[

  - black + isort → ruff format
  - flake8 + pyupgrade → ruff check

]

#laas-slide(title: "uv")[

  - pip → uv
]

#section-slide("Git")

#laas-slide(title: "Git")[
  #link(
    "https://homepages.laas.fr/matthieu/talks/git.pdf",
  )[https://homepages.laas.fr/matthieu/talks/git.pdf]

  #link("https://learngitbranching.js.org/")[https://learngitbranching.js.org]

  #link("https://jj-vcs.github.io/")[https://jj-vcs.github.io]
]
