#import "../../../my-slides.typ": *

#set text(lang: "en")

#show: doc => my-slides(
  doc,
  presentation_title: "TP 4",
  presentation_subtitle: "UPSSITECH - KUPR9BC3",
  date: "2025-12-05",
)

#laas-slide(title: "Proxy HTTP")[
  #link("https://github.com/nim65s/nim65s.github.io/blob/main/src/proxy.py")
]

#laas-slide(title: "Client C++")[
  - #link("https://github.com/libcpr/cpr")
  - #link("https://github.com/nlohmann/json")
  - #link("https://eigen.tuxfamily.org")
]

#laas-slide(title: "CMake")[
  #link(
    "https://github.com/nim65s/nim65s.github.io/blob/main/src/CMakeLists.txt",
  )

  ```bash
  # configure
  cmake -B build -S .
  # compile
  cmake --build build
  # run
  ./build/low_level
  ```
]
