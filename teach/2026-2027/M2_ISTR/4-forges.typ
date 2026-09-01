#import "../../../my-slides.typ": *

#set text(lang: "fr")


#show: doc => my-slides(
  doc,
  presentation_title: "Forges",
  presentation_subtitle: "Université Toulouse Paul Sabatier - KEAT9AA1",
  date: "2026-09-01",
)


#section-slide("Introduction")

#laas-slide(title: "What are software forges")[
  - Software management
    - git repository (web, HTTPS, SSH)
    - authorizations
    - issue tracker

  - Project management
    - milestones
    - assignees
    - boards
]

#laas-slide(title: "Hierarchy")[
  1. domain
  2. username *OR* group (organization)
  3. project

  - `https:// gitlab.laas.fr / gsaurel / talks`
  - `https:// github.com / gepetto / example-adder`
]

#laas-slide(title: "Issues (software management)")[
  - bug fix / feature request
  - Github / Gitlab: `#4`
  - referencable from git:
    - `git commit -m "add user input test, ref #4"`
    - `git commit -m "sanitize user input, fix #4"`
]

#laas-slide(title: "Tasks (project management)")[
  - labels
  - discussions
  - boards (or table / roadmap)
  - open / close
]

#section-slide("Branches")

#laas-slide(title: "Goal")[
  #image("../../../media/nvie.png")
]

#laas-slide(title: "Usual branches")[
  - default: `master` or `main`
  - `devel`, `stable`
  - `issue/5`
  - `topic/something`
]

#section-slide("Forks")

#laas-slide(title: "2 types of fork")[
  - scission (software development)
    - document motivations
    - rename
    - change logo / website etc.
    - ensure compatibility
  - collaboration (git forges)
    - try to keep synchronized
]

#laas-slide(title: "Work locally with multiple forks")[
  ```
  git clone git@github.com:gsaurel/project.git
  cd project
  git remote add upstream \
          git@github.com:team/project.git
  ```

  ```
  git pull upstream main
  git push origin main
  ```
]

#laas-slide(title: "SSH shortcut")[
  ```ini
  # ~/.ssh/config
  Host gl
      HostName gitlab.laas.fr
      User git
  Host gh
      HostName github.com
      User git
  ```

  ```
  git clone gl:gsaurel/project
  git remote add team gh:team/project
  ```
]

#section-slide("Requests")

#laas-slide(title: "Gitlab")[
  #image("../../../media/mr.png")
]

#laas-slide(title: "Gitlab from command line")[
  ```
  git push -o merge_request.create \
           -o merge_request.target=devel \
           origin topic/something
  ```
]

#laas-slide(title: "Github")[
  #image("../../../media/pr.png")
]

#laas-slide(title: "Github from command line")[
  Required: https://cli.github.com/

  ```
  gh pr create
  ```
]

#section-slide("CI")

#laas-slide(title: "Gitlab")[
  ```yml
  # .gitlab-ci.yml
  image: gitlab.laas.fr:4567/gsaurel/talks

  build:
    script:
      - make

  test:
    script:
      - make test
  ```
]

#laas-slide(title: "Github")[
  ```yml
  # .github/workflows/build.yml
  name: Build
  on: [push, pull_request]

  jobs:
    build:
      name: Transpile markdown sources into PDF
      runs-on: nim65s/dockgen
      steps:
        - uses: actions/checkout@v6
        - run: make
  ```
]

#section-slide("Workflows")

#laas-slide(title: "Example")[
  #image("../../../media/nvie.png")
]

#section-slide("Automation")

#laas-slide(title: "Automation")[
  - open pull requests
  - update pull requests (commits, labels, reviews)
  - merge pull requests
]

#section-slide("End notes")

#laas-slide(title: "References")[
  #link("https://learngitbranching.js.org/")

  #link("https://nvie.com/posts/a-successful-git-branching-model/")

  #link("https://docs.github.com/fr/get-started/quickstart/github-flow")
]
