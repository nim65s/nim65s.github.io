#import "../my-slides.typ": *

#set text(lang: "en")

#show: doc => my-slides(
  doc,
  presentation_title: "uv",
  presentation_subtitle: "2RM - EcoleTechno2025",
  date: "2025-06-17",
)


#about-me

#section-slide(rainbow[intro])

#laas-slide(title: "Ruff")[
  - A Python linter & formatter
  - replace all the others (black, isort, flake8, …)
  - very fast (rust)
  - can (un)safely fix your code (further)
  - integrations (pre-commit, lsp, CI)
  - good defaults & lot of configuration options
  - 40 k⭐
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

#laas-slide(title: "uv")[
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
    - 60 k⭐
    - listen to its community
  ]
]


#section-slide(rainbow[standards])

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
  requires = ["setuptools"]
  build-backend = "setuptools.build_meta"
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

#laas-slide(title: "pipx")[
  #columns(2)[
    ```bash
    $ pipx install uv
    ```
    #colbreak()
    ```bash
    ~/.local/share/pipx/venvs/uv
    ~/.local/bin/uv
    $ pipx ensurepath
    ```
  ]
]

#section-slide(rainbow[examples])

#laas-slide(title: "Python library")[
  ```bash
  $ uv init --lib
  $ tree
  pyproject.toml
  README.md
  src/
  └── jt_2rm_lib/
      ├── __init__.py
      └── py.typed
  ```
]

#laas-slide(title: "Python library")[
  #columns(2)[
    ```bash
    $ uv init --lib
    $ tree
    pyproject.toml
    README.md
    src/
    └── jt_2rm_lib/
        ├── __init__.py
        └── py.typed
    ```
    #colbreak()
    ```toml
    [project]
    name = "jt-2rm-lib"
    version = "0.1.0"
    description = "Some description"
    readme = "README.md"
    authors = [{
      name = "Guilhem Saurel",
      email = "gsaurel@laas.fr"
    }]
    requires-python = ">=3.13"
    dependencies = []
    ```
  ]
]

#laas-slide(title: "Python program")[
  ```bash
  $ uv init
  $ ls
  main.py  pyproject.toml  README.md
  ```
]

#laas-slide(title: "Ajouter une dépendance")[
  ```bash
  $ uv add httpx
  $ uv add --dev ruff
  $ uv add --optional view meshcat
  ```
]

#laas-slide(title: "Ajouter une dépendance")[
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

#laas-slide(title: "torch")[
  #text(20pt)[
    ```toml
    [project.optional-dependencies]
    cpu = [ "torch>=2.5.1" ]
    cu124 = [ "torch>=2.5.1" ]
    [[tool.uv.index]]
    explicit = true
    name = "pytorch-cpu"
    url = "https://download.pytorch.org/whl/cpu"
    [[tool.uv.index]]
    explicit = true
    name = "pytorch-cu124"
    url = "https://download.pytorch.org/whl/cu124"
    [tool.uv.sources]
    torch = [
      {extra = "cpu", index = "pytorch-cpu", marker = "platform_system != 'Darwin'"},
      {extra = "cu124", index = "pytorch-cu124"}
    ]
    ```
  ]
]

#laas-slide(title: "Python script")[
  ```python
  #!/usr/bin/env -S uv run --script
  # /// script
  # dependencies = ["beautifulsoup4", "httpx"]
  # ///

  import httpx
  from bs4 import BeautifulSoup

  r = httpx.get("https://example.org")
  soup = BeautifulSoup(r.text, "html.parser")
  print(soup.h1)
  ```
]

#laas-slide(title: "Extend system")[
  ```Dockerfile
  FROM ros:jazzy
  RUN apt update \
   && apt install -qy \
      pipx ros-jazzy-rclpy \
   && pipx install uv
  ENV PATH=/root/.local/bin:$PATH
  WORKDIR /ws
  RUN uv init \
   && uv venv \
        --system-site-packages \
   && uv add torch
  ```
]

#laas-slide(title: "Extend system")[
  #columns(2)[
    ```Dockerfile
    FROM ros:jazzy
    RUN apt update \
     && apt install -qy \
        pipx ros-jazzy-rclpy \
     && pipx install uv
    ENV PATH=/root/.local/bin:$PATH
    WORKDIR /ws
    RUN uv init \
     && uv venv \
          --system-site-packages \
     && uv add torch
    ```
    #colbreak()
    ```bash
    $ uv run python
    ```
    ```python
    >>> import rclpy
    >>> rclpy.__file__
    '/opt/ros/jazzy/lib/python3.12/site-packages/rclpy/__init__.py'
    >>> import torch
    >>> torch.__file__
    '/ws/.venv/lib/python3.12/site-packages/torch/__init__.py
    ```
  ]
]

#laas-slide(title: "Nix", alignment: horizon + center)[
  uv2nix
]

#section-slide(rainbow[questions])

#about-this-presentation("25-uv-2rm")
