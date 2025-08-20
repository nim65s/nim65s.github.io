#import "@preview/laas-cnrs-slides:0.1.0": *

#let my-slides(
  doc,
  presentation_title: "",
  presentation_subtitle: "",
  author: "Guilhem Saurel",
  date: "",
  beamer_format: (16, 9),
  // Arial / Helvetica are recommended but non free
  font: "Hack Nerd Font",
  font-size: 25pt,
) = laas-slides(
  doc,
  presentation_title: presentation_title,
  presentation_subtitle: presentation_subtitle,
  author: author,
  date: date,
  beamer_format: beamer_format,
  font: font,
  font-size: font-size,
)
}

#let about-this-presentation(file) = {
  let url = "https://homepages.laas.fr/gsaurel/" + file + ".pdf"
  laas-slide(title: "About this presentation", alignment: horizon + center)[

    *Available at*

    #link(url)[ #url ]

    *Under license*

    #box(image("media/cc.png", width: 3cm))
    #box(image("media/by.png", width: 3cm))
    #box(image("media/sa.png", width: 3cm))

    https://creativecommons.org/licenses/by-sa/4.0/

    *Powered by* #box(image("media/typst.svg", width: 2cm))
    #box(image("media/nix-snowflake-colours.png", width: 1cm))

  ]
}

#let about-me = laas-slide(
  title: "About me",
  alignment: horizon + center,
  display-footer: false,
)[
  #figure(
    image("media/robots.jpg", width: 70%),
    caption: [IR en robotique humanoïde],
    numbering: none,
  )
]

#let rainbow(content) = {
  set text(
    fill: gradient.linear(..(
      rgb("#770088"),
      rgb("#004CFF"),
      rgb("#028121"),
      rgb("#FFEE00"),
      rgb("#FF8D00"),
      rgb("#E50000"),
    )),
  )
  box(content)
}

#let section-slide(title) = laas-slide(
  alignment: horizon + center,
  display-header: false,
  display-footer: false,
)[
  *#text(60pt)[#upper[#underline[#title]]]*
]
