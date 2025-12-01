#import "../../../my-slides.typ": *

#set text(lang: "en")

#show: doc => my-slides(
  doc,
  presentation_title: "TP 2",
  presentation_subtitle: "UPSSITECH - KUPR9BC3",
  date: "2025-12-01",
)

#laas-slide(title: "Python: Multiprocessing", alignment: horizon + center)[
  #link("https://docs.python.org/3/library/multiprocessing.html")
]

#laas-slide(title: "Architecture", alignment: horizon + center)[
  #image("../../../media/architecture.png")
]
