#import "@preview/laas-cnrs-slides:0.1.0": *

#let my-slides(
  doc,
  presentation_title: "",
  presentation_subtitle: "",
  author: "Guilhem Saurel",
  date: "",
  beamer_format: (16, 9),
  // Arial / Helvetica are recommended but non free
  font: "Noto Sans",
  file: "",
) = {
  show: doc => laas-slides(
    doc,
    presentation_title: presentation_title,
    presentation_subtitle: presentation_subtitle,
    author: author,
    date: date,
    beamer_format: beamer_format,
    font: font,
  )


  laas-slide(title: "This presentation")[
    Available at

    https://homepages.laas.fr/gsaurel/talks/{file}.pdf

  ]

}
