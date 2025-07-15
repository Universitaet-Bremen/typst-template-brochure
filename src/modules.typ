#import "conf.typ": *
#import "themes.typ" as theme
#import "acronyms.typ" as acronyms
#import "@preview/glossarium:0.5.7": print-glossary

#let color = {
  if (colortheme == "red") {theme.uniCorporateThemes.red}
  else if (colortheme == "blue") {theme.uniCorporateThemes.blue}
  else if (colortheme == "violet") {theme.uniCorporateThemes.violet}
  else if (colortheme == "coral") {theme.uniCorporateThemes.coral}
  else if (colortheme == "yellow") {theme.uniCorporateThemes.yellow}
  else if (colortheme == "green") {theme.uniCorporateThemes.green}
  else if (colortheme == "lime") {theme.uniCorporateThemes.lime}
  else {theme.uniCorporateThemes.grey}
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

#let h3(content) = [
  #text(9pt, fill: color.regular, weight: "bold")[#content]
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
#let coverSheet(title: "{TITLE}", preheading: "Hausarbeit zum Thema", forschungsfrage: "{FORSCHUNGSFRAGE}", abgabedatum: [#doc.dateOfCreation.day(). #translated-month(long: true, doc.dateOfCreation) #doc.dateOfCreation.year()]) = {
  set page(
    margin: 0cm,
    fill: color.dark
  )
  set par(first-line-indent: 0pt)
  set align(center)

  grid(
    columns: (2fr, 10fr, 10fr),
    rows: (1fr, 30fr, 14fr),
    gutter: 0pt,
    inset: 0pt,
    grid.cell(colspan: 3, fill: color.dark)[],
    grid.cell(fill: color.dark)[],
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
          #line(stroke: color.dark)
        ],
        [
          #image("images/unibremen_logo.png", height: 60%)
        ],
        [
          #text(15pt)[
            #preheading
          ]
          
          #text(24pt, weight: "bold", color.dark.darken(50%))[
            #title
          ]
          #line(length: 100%, stroke: color.dark)
        ],
        grid.cell(align: center + top)[
          #text(13pt)[
            #forschungsfrage
          ]
        ]
      )
    ],
    grid.cell(fill: color.dark)[],
    grid.cell(fill: color.dark, inset: (y: 1.5cm))[
      #set align(left + bottom)
      #set text(color.light.lighten(50%))
      #image("images/unibremen_logo_white.png", width: 50%)\
      Vorgelegt von:\
      \
      
      *#author.name* \
      #link("mailto:"+author.email)\
  
      Matr.-Nr.: #author.matrikelnummer \
      Fachsemester: #author.fachsemester\
  
      Abgabedatum: #abgabedatum
    ],
    grid.cell(fill: color.regular)[
      #set align(right + horizon)
      #pad(y: 20pt)[#line(stroke: color.light + 20pt, length: 50%)]
      #pad(y: 20pt)[#line(stroke: color.dark + 20pt, length: 50%)]
      #pad(y: 20pt)[#line(stroke: color.light + 20pt, length: 50%)]
      #pad(y: 20pt)[#line(stroke: color.light + 20pt, length: 50%)]
    ],
  )
  
  pagebreak()
}


/*
  Inhalt für die repetative Seitenkopfzeile
  
  @author Jannis Wiehart
*/
#let pageHeader(title: doc.title) = context {
  set text(lang: "de")
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
          #smallcaps[#text([#doc.dateOfCreation.day(). #translated-month(long: true, doc.dateOfCreation) #doc.dateOfCreation.year()])]
        ]
      )
    ]
  line(length: 100%, stroke: 0.5pt + color.dark)
}


/*
  Inhalt für die repetative Seitenfußzeile
  
  @author Jannis Wiehart
*/
#let pageFooter(caption: doc.identifier, numbers: false) = context {
  line(length: 100%, stroke: 0.5pt + color.dark)
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
      ]
    )
  ]
}


#let tableOfContents = [
  #pagebreak()
  #set text(top-edge: 1em)
  #outline(title: "Inhalt", depth: 4)
  #pagebreak()
]

#let acronyms = [
  #if acronyms.entry-list.len() > 0 {
    [= Abkürzungen]

    print-glossary(acronyms.entry-list)
    pagebreak()
  }
]

#let bib = [
  #set par(justify: false)
  #show bibliography: set heading(outlined: true);
  #bibliography(title: [Bibliographie],full: true,"sources.bib", style: doc.citation-style)
]

#let lastPage = [
  #pagebreak()
  #set page(footer: none, header: none, margin: 0pt)
  #grid(
    rows: (50fr,1fr, 1fr),
    columns: (3fr,2fr),
    grid.cell(colspan: 2, fill: white, align: right + bottom, inset: (x: 2cm, bottom: 3cm))[
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
    grid.cell(colspan: 2, fill: color.light)[],
    grid.cell(fill: color.dark)[],
    grid.cell(fill: color.regular)[],
  )
]


/*
  Generische Box, um Inhalte farblich hervorzuheben
  
  @author Jannis Wiehart
*/
#let box(content) = [
  #set par(first-line-indent: 0pt)
  #grid(
    columns: (5fr, 1fr, 2fr),
    grid.cell(colspan: 3, fill: color.light, inset: 8pt)[
      #set text(fill: color.dark)
      #content
    ],
    grid.cell(fill: color.dark, inset: 2pt)[],
    grid.cell(fill: color.light, inset: 2pt)[],
    grid.cell(fill: color.regular, inset: 2pt)[],
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