// -------------------------------------------------------------------------------
//
// Inhalte des Dokuments werden in content.typ geschrieben!!!
//
// -------------------------------------------------------------------------------



#import "src/conf.typ": *
#import "src/modules.typ" as uni
#import "src/acronyms.typ" as acronyms
#import "@preview/glossarium:0.5.9": make-glossary, register-glossary

#show: make-glossary

#register-glossary(acronyms.entry-list)

#set document(
  author: author.name,
  date: doc.dateOfCreation,
  description: doc.description,
  keywords: doc.keywords,
  title: doc.identifier
)

#set page(
  paper: "a4",
  margin: (top:3cm, x:2cm, bottom: 2cm),
  supplement: "Seite"
)

#set text(
  font: doc.font,
  lang: "de",
  size: doc.font-size,
  top-edge: doc.line-spacing * 1em,
)

#set heading(
  numbering: "1.",
)

#set par(linebreaks: "optimized", justify: true)
// Kapitel-Headline
#show heading.where(level: 1): it => [
  #uni.h1(it)
]
// Headline und Einführung
#show heading.where(level: 2): it => [
  #uni.h2(it)
]
#show heading.where(level: 3): it => [
   #uni.h3(it)
]
#show heading.where(level: 4): it => [
   #uni.h4(it)
]
#uni.coverSheet(title: doc.title, forschungsfrage: doc.forschungsfrage, preheading: doc.preheading)
#counter(page).update(1)
#set page(header: uni.pageHeader(),footer: uni.pageFooter(), numbering: "I")
#uni.abstract[
  #lorem(100)
]

#pagebreak()

#uni.acronyms

#uni.tableOfContents

#pagebreak()

<roman-number-interrupt>

#counter(page).update(1)
#set page(footer: uni.pageFooter(numbers: true), numbering: "1")
#include "content.typ"

#pagebreak()
#uni.bib

#pagebreak()
#set page(numbering: "I")
#context [
  #let number = counter(page).at(<roman-number-interrupt>).at(0)
  #counter(page).update(number)
]
#include "anhaenge.typ"

#set page(footer: none, header: none, margin: 0pt)

// Declarations

#uni.lastPage