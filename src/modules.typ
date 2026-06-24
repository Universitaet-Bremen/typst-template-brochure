#import "themes.typ" as theme
#import "@preview/glossarium:0.5.9": print-glossary

#let months_short = (
  "Jan",
  "Feb",
  "Mrz",
  "Apr",
  "Mai",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Okt",
  "Nov",
  "Dez",
)
#let months_long = (
  "Januar",
  "Februar",
  "März",
  "April",
  "Mai",
  "Juni",
  "Juli",
  "August",
  "September",
  "Oktober",
  "November",
  "Dezember",
)

#let translated-month(long: false, dt) = {
  if long {
    months_long.at(dt.month() - 1)
  } else {
    months_short.at(dt.month() - 1)
  }
}

/*
  Verschiende Schriftstile im Dokument

  @author Jannis Wiehart
*/

#let einfuehrungstext(content) = [
  #text(18pt, weight: "regular")[#content]
]

#let h1(content) = [
  #text(30pt, weight: "regular")[#content]
]

#let h2(content) = [
  #einfuehrungstext(content)
]

#let h3(content) = context [
  #text(9pt, fill: theme.color.get().regular, weight: "bold")[#content]
]

#let h4(content) = [
  #text(9pt, weight: "bold")[#content]
]

#let anlesertext(content) = [
  #text(9pt, weight: "bold")[#content]
]

/*
  Erzeugt ein Deckblatt im Theme, welches in der conf.typ eingestellt wurde

  @author Jannis Wiehart
*/
#let coverSheet(
  title: "{TITLE}",
  preheading: "Hausarbeit zum Thema",
  forschungsfrage: "{FORSCHUNGSFRAGE}",
  abgabedatum: [Heute],
  study,
  author,
) = context {
  set page(
    margin: 0cm,
    fill: theme.color.get().dark,
  )
  set par(first-line-indent: 0pt, justify: false)
  set align(center)
  set text(
    font: "Sharp Sans",
    lang: "de",
    size: 8.5pt,
  )

  grid(
    columns: (2fr, 10fr, 10fr),
    rows: (1fr, 30fr, 14fr),
    gutter: 0pt,
    inset: 0pt,
    grid.cell(colspan: 3, fill: theme.color.get().dark)[],
    grid.cell(fill: theme.color.get().dark)[],
    grid.cell(colspan: 2, fill: white, inset: (y: 0pt, x: 24pt))[
      #set align(center + horizon)
      #grid(
        columns: 1,
        rows: 1fr,
        [
          Universität Bremen\
          Studiengang: #study.studiengang\
          Modul: #study.modul\
          Dozent: #study.dozenten
          #line(stroke: theme.color.get().dark)
        ],
        [
          #image("images/unibremen_logo.png", height: 60%)
        ],
        [
          #text(15pt)[
            #preheading
          ]

          #text(
            24pt,
            weight: "bold",
            theme.color.get().dark.darken(50%),
            hyphenate: false,
          )[
            #title
          ]
          #line(length: 100%, stroke: theme.color.get().dark)
        ],
        grid.cell(align: center + top)[
          #text(13pt)[
            #forschungsfrage
          ]
        ],
      )
    ],
    grid.cell(fill: theme.color.get().dark)[],
    grid.cell(fill: theme.color.get().dark, inset: (y: 1.5cm))[
      #set align(left + bottom)
      #set text(theme.color.get().light.lighten(50%))
      #image("images/unibremen_logo_white.png", width: 50%)\
      Vorgelegt von:\
      \

      *#author.name* \
      #link("mailto:" + author.email)\

      Matr.-Nr.: #author.matrikelnummer \
      Fachsemester: #author.fachsemester\

      Abgabedatum: #abgabedatum
    ],
    grid.cell(fill: theme.color.get().regular)[
      #set align(right + horizon)
      #pad(y: 20pt)[#line(stroke: theme.color.get().light + 20pt, length: 50%)]
      #pad(y: 20pt)[#line(stroke: theme.color.get().dark + 20pt, length: 50%)]
      #pad(y: 20pt)[#line(stroke: theme.color.get().light + 20pt, length: 50%)]
      #pad(y: 20pt)[#line(stroke: theme.color.get().light + 20pt, length: 50%)]
    ],
  )

  pagebreak()
}


/*
  Inhalt für die repetative Seitenkopfzeile

  @author Jannis Wiehart
*/
#let pageHeader(doc, study) = context {
  set text(
    font: "Sharp Sans",
    lang: "de",
    size: 8.5pt,
  )
  set par(justify: false)
  text(8pt)[
    #grid(
      columns: (2fr, 3fr, 2fr),
      align(left + top)[
        #image("images/unibremen_logo.png", width: 60%)
      ],
      align(center + top)[
        #smallcaps[
          #study.modul\
          #study.dozenten\
          #doc.summary
        ]
      ],
      align(right + top)[
        #smallcaps[#text(
          [#doc.dateOfCreation.day(). #translated-month(long: true, doc.dateOfCreation) #doc.dateOfCreation.year()],
        )]
      ],
    )
  ]
  line(length: 100%, stroke: 0.5pt + theme.color.get().dark)
}


/*
  Inhalt für die repetative Seitenfußzeile

  @author Jannis Wiehart
*/
#let pageFooter(caption: none, numbers: false) = context {
  set text(
    font: "Sharp Sans",
    lang: "de",
    size: 8.5pt,
  )

  line(length: 100%, stroke: 0.5pt + theme.color.get().dark)
  text(8pt)[
    #grid(
      columns: (7fr, 1fr),
      align(left + top)[
        #caption
      ],
      align(right + top)[
        #if (numbers) [
          #counter(page).display()
        ]
      ],
    )
  ]
}


#let tableOfContents = [
  #set text(top-edge: 1em)
  #outline(title: "Inhalt", depth: 4)
]

#let acronyms(entry-list) = [
  #if entry-list.len() > 0 {
    set heading(numbering: none)
    [= Abkürzungen]

    print-glossary(entry-list, deduplicate-back-references: true)
    pagebreak()
  }
]

#let bib(sources, citationStyle) = [
  = Bibliographie
  #set par(justify: false)
  #bibliography(title: none, full: true, sources, style: citationStyle)
]

#let lastPage(doc, study, author) = [
  #pagebreak()
  #set text(
    font: "Sharp Sans",
    lang: "de",
    size: 8.5pt,
  )
  #set page(footer: none, header: none, margin: 0pt)
  #grid(
    rows: (50fr, 1fr, 1fr),
    columns: (3fr, 2fr),
    grid.cell(colspan: 2, fill: white, align: right + bottom, inset: (
      x: 2cm,
      bottom: 3cm,
    ))[
      #image("images/unibremen_logo.png", height: 18.5mm)
      \
      \
      \
      #doc.summary\
      Abgabedatum: #doc.dateOfCreation.day(). #translated-month(long: true, doc.dateOfCreation) #doc.dateOfCreation.year()\
      \
      \
      \
      #study.modul\
      #study.semester\
      #study.dozenten\
      #study.studiengang\
      #study.fachbereich\
      \
      \
      \
      *#author.name*\
      #author.email\

      Matr.Nr.: #author.matrikelnummer\
      Fachsemester: #author.fachsemester\
      \
      \
      \
      \
      \
      Dokumentenvorlage: #sym.copyright 2025 Jannis L. Wiehart
    ],
    grid.cell(colspan: 2, fill: theme.color.get().light)[],
    grid.cell(fill: theme.color.get().dark)[],
    grid.cell(fill: theme.color.get().regular)[],
  )
]


/*
  Generische Box, um Inhalte farblich hervorzuheben

  @author Jannis Wiehart
*/
#let box(content) = context [
  #set par(first-line-indent: 0pt)
  #grid(
    columns: (5fr, 1fr, 2fr),
    grid.cell(colspan: 3, fill: theme.color.get().light, inset: 8pt)[
      #set text(fill: theme.color.get().dark)
      #content
    ],
    grid.cell(fill: theme.color.get().dark, inset: 2pt)[],
    grid.cell(fill: theme.color.get().light, inset: 2pt)[],
    grid.cell(fill: theme.color.get().regular, inset: 2pt)[],
  )
]

#let abstract(content) = [
  #pad(top: 50pt, bottom: 50pt, [
    #align(center)[
      #set par(justify: false)
      #h2("Abstract") \
      #content
    ]
  ])
]
