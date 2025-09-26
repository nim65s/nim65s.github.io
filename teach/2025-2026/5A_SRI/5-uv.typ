#import "../../../my-slides.typ": *

#set text(lang: "en")

#show: doc => my-slides(
  doc,
  presentation_title: "",
  presentation_subtitle: "UPSSITECH - KUPR9BC3",
  date: "2025-09-26",
)

#section-slide("intro")

#laas-slide(title: "Ruff")[
  - A Python linter & formatter
  - replace all the others (black, isort, flake8, …)
  - very fast (rust)
  - can (un)safely fix your code (further)
  - integrations (pre-commit, lsp, CI)
  - good defaults & lot of configuration options
  - 42 k⭐
]

#laas-slide(title: "Astral")[
  - A company to advance the python tooling ecosystem
  - Support ruff development
    - open source, permissive, built in the open
  - Create other tools:
    - rye
    - uv
    - ty
]

#laas-slide(title: "uv", alignment: horizon + left)[
  #columns(2)[
    - extends pip
      - don't lock you out of it
    - follows standard PEPs
    - will use your python
      - unless you need another
    - will isolate your env
      - unless you need system things
    - very fast (rust)
    #colbreak()
  ]
]

#laas-slide(title: "uv", alignment: horizon + left)[
  #columns(2)[
    - extends pip
      - don't lock you out of it
    - follows standard PEPs
    - will use your python
      - unless you need another
    - will isolate your env
      - unless you need system things
    - very fast (rust)
    #colbreak()
    - great dependency resolver
      - with clear messages
    - global cache
      - with deduplication
    - workspaces
    - uvx
    - 68 k⭐
    - listen to its community
  ]
]

#section-slide("standards")

#laas-slide(title: "pyproject.toml")[
  ```toml
  [project]
  name = "Your Project Name"
  version = "0.1.0"
  description = "Your Project Description"
  readme = "README.md"
  requires-python = ">=3.12"
  dependencies = []

  [build-system]
  requires = ["uv_build>=0.8.14,<0.9.0"]
  build-backend = "uv_build"
  ```
]

#laas-slide(title: "venv")[
  ```bash
  $ python -m venv .venv
  $ source .venv/bin/activate
  $ # Profit !
  ```
]

#laas-slide(title: "venv")[
  #columns(2)[
    ```bash
    $ python -m venv .venv
    $ source .venv/bin/activate
    $ # Profit !
    ```
    #colbreak()
    ```bash
    $ tree .venv
    .venv
    ├── bin
    │   ├── activate
    │   ├── pip
    │   └── python -> /…/bin/python
    ├── include/python3.12
    ├── lib/python3.12/site-packages
    └── pyvenv.cfg
    ```
  ]
]

#laas-slide(title: "pipx")[
  ```bash
  $ pipx install uv
  ```
]

#section-slide("Dependency management")

#laas-slide(title: "Add a dependency")[
  ```bash
  $ uv add httpx
  $ uv add --dev ruff
  $ uv add --optional view meshcat
  ```
]

#laas-slide(title: "Add a dependency")[
  #columns(2)[
    ```bash
    $ uv add httpx
    $ uv add --dev ruff
    $ uv add --optional view meshcat
    ```
    #colbreak()
    ```toml
    [project]
    dependencies = [
        "httpx>=0.28.1",
    ]
    [project.optional-dependencies]
    view = [
        "meshcat>=0.3.2",
    ]
    [dependency-groups]
    dev = [
        "ruff>=0.11.13",
    ]
    ```
  ]
]

#laas-slide(title: "uv.lock")[
  ```toml
  [[package]]
  name = "anyio"
  version = "4.9.0"
  source = { registry = "https://pypi.org/simple" }
  dependencies = [ { name = "idna" }, { name = "sniffio" }, ]
  sdist = { url = "https://files.pythonhosted.org/packages/95/7d/4c1bd541d4…97a106fc97a7313b105f840/anyio-4.9.0.tar.gz", hash = "sha256:673c0c244e157886…5eda409e0c9840a028", size = 190949, upload-time = "2025-03-17T00:02:54.77Z" }
  wheels = [ { url = "https://files.pythonhosted.org/packages/a1/ee/48ca1a7c89ffe…94acf8b8c408575bb/anyio-4.9.0-py3-none-any.whl", hash = "sha2560a9c…4d93c", size = 100916, upload-time = "2025-03-17T00:02:52.713Z" }, ]
  ]
  ```
]
