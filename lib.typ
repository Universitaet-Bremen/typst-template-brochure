#import "src/themes.typ" as theme
#import "src/modules.typ" as uni
#import "@preview/glossarium:0.5.9": make-glossary, register-glossary

// Re-export
#let anlesertext = uni.anlesertext
#let box = uni.box

#let _roman-page = state("moin-uni-brochure-roman-page", 0)

#let brochure(
  colortheme: "red",
  author: (
    name: "Vorname Nachname",
    matrikelnummer: "0000000",
    email: "vorname.nachname@uni-bremen.de",
    fachsemester: 1,
  ),
  doc: (
    title: "{TITLE}",
    identifier: "{unique_identifier}",
    preheading: "Hausarbeit zum Thema",
    forschungsfrage: "{FORSCHUNGSFRAGE}",
    summary: "Hausarbeit",
    dateOfCreation: datetime.today(),
    description: "",
    keywords: (),
    font: "Palatino Linotype",
    fontSize: 12pt,
    lineSpacing: 1.1,
    citationStyle: "institute-of-electrical-and-electronics-engineers",
  ),
  study: (
    studiengang: "Bachelor of Science - Informatik Vollfach",
    semester: "WSxx/xx",
    modul: "MODULNAME",
    dozenten: "DOZENT1, DOZENT2",
    fachbereich: "Fachbereich: FB03",
  ),
  acronym-list: (),
  abstract: [],
  sources: none,
  anhaenge: [],
  body,
) = context {
  theme.color.update({
    if (colortheme == "red") { theme.uniCorporateThemes.red } else if (
      colortheme == "blue"
    ) { theme.uniCorporateThemes.blue } else if (colortheme == "violet") {
      theme.uniCorporateThemes.violet
    } else if (colortheme == "coral") {
      theme.uniCorporateThemes.coral
    } else if (colortheme == "yellow") {
      theme.uniCorporateThemes.yellow
    } else if (colortheme == "green") {
      theme.uniCorporateThemes.green
    } else if (colortheme == "lime") { theme.uniCorporateThemes.lime } else {
      theme.uniCorporateThemes.grey
    }
  })

  show: make-glossary
  register-glossary(acronym-list)

  set document(
    author: author.name,
    date: doc.dateOfCreation,
    description: doc.description,
    keywords: doc.keywords,
    title: doc.identifier,
  )

  set page(
    paper: "a4",
    margin: (top: 3cm, x: 2cm, bottom: 2cm),
    supplement: "Seite",
  )

  set text(
    font: doc.font,
    lang: "de",
    size: doc.fontSize,
    top-edge: doc.lineSpacing * 1em,
  )

  set heading(numbering: "1.")
  set par(linebreaks: "optimized", justify: true)

  show heading.where(level: 1): it => uni.h1(it)
  show heading.where(level: 2): it => uni.h2(it)
  show heading.where(level: 3): it => uni.h3(it)
  show heading.where(level: 4): it => uni.h4(it)

  // ── Deckblatt ──────────────────────────────────────────────────────────────
  uni.coverSheet(
    title: doc.title,
    forschungsfrage: doc.forschungsfrage,
    preheading: doc.preheading,
    study,
    author,
  )
  counter(page).update(1)
  set page(
    header: uni.pageHeader(doc, study),
    footer: uni.pageFooter(caption: doc.identifier),
    numbering: "I",
  )
  uni.abstract(abstract)

  pagebreak()

  uni.acronyms(acronym-list)

  uni.tableOfContents
  pagebreak()

  context { _roman-page.update(counter(page).get().at(0)) }
  counter(page).update(1)
  set page(
    footer: uni.pageFooter(caption: doc.identifier, numbers: true),
    numbering: "1",
  )

  body

  pagebreak()

  uni.bib(sources, doc.citationStyle)
  pagebreak()
  set page(numbering: "I")
  context { counter(page).update(_roman-page.get()) }

  anhaenge

  set page(footer: none, header: none, margin: 0pt)

  uni.lastPage(doc, study, author)
}
