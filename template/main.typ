#import "@preview/moin-uni-brochure:0.1.0": anlesertext, box, brochure

#import "acronyms.typ": entry-list

#show: brochure.with(
  colortheme: "red",
  // Weitere Themes: "blue" | "violet" | "coral" | "yellow" | "green" | "lime" | "grey"

  author: (
    name: "Jannis L. Wiehart",
    matrikelnummer: "6374047",
    email: "wiehart@uni-bremen.de",
    fachsemester: 2,
  ),

  doc: (
    title: "{TITLE}",
    identifier: "{unique_identifier}", // Steht in den Meta-Informationen und in der Fußzeile
    preheading: "Hausarbeit zum Thema",
    forschungsfrage: "{FORSCHUNGSFRAGE}",
    summary: "Hausarbeit von xxx",
    dateOfCreation: datetime(year: 2025, month: 08, day: 01), // = Abgabedatum
    description: "",
    keywords: (),
    font: "Palatino Linotype",
    fontSize: 12pt,
    lineSpacing: 1.1,
    citationStyle: "institute-of-electrical-and-electronics-engineers", // https://typst.app/docs/reference/model/bibliography/#parameters-style
  ),

  study: (
    studiengang: "Bachelor of Science - Informatik Vollfach",
    semester: "WSxx/xx",
    modul: "MODULNAME",
    dozenten: "DOZENT1, DOZENT2",
    fachbereich: "Fachbereich: FB03",
  ),

  acronym-list: entry-list,

  abstract: include "abstract.typ",
  anhaenge: include "anhaenge.typ",
)

#include "content.typ"
