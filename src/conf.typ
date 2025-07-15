// -------------------------------------------------------------------------------
//  DOKUMENTEN-PARAMETER (Anpassbar)
// -------------------------------------------------------------------------------

#let colortheme = "red"

#let author = (
  name: "Jannis L. Wiehart",
  matrikelnummer: "6374047",
  email: "wiehart@uni-bremen.de",
  fachsemester: 2
)

#let doc = (
  title: "{TITLE}", 
  identifier: "{unique_identifier}", // Steht in den Meta-Informationen und in der Fußzeile
  preheading: "Hausarbeit zum Thema",
  forschungsfrage: "{FORSCHUNGSFRAGE}",
  summary: "Hausarbeit von xxx",
  dateOfCreation: datetime(year: 2025, month: 08, day: 01), // = Abgabedatum
  description: "",
  keywords: (),
  citation-style: "institute-of-electrical-and-electronics-engineers", // https://typst.app/docs/reference/model/bibliography/#parameters-style
)

#let study = (
  studiengang: "Bachelor of Science - Informatik Vollfach",
  semester: "WSxx/xx",
  modul: "MODULNAME",
  dozenten: "DOZENT1, DOZENT2",
  fachbereich: "Fachbereich: FB03"
)



// -------------------------------------------------------------------------------
//  Funktionen (Nicht verändern!) 
// -------------------------------------------------------------------------------


#let months_short = ("Jan", "Feb", "Mrz", "Apr", "Mai", "Jun", "Jul", "Aug", "Sep", "Okt", "Nov", "Dez")
#let months_long = ("Januar", "Februar", "März", "April", "Mai", "Juni", "Juli", "August", "September", "Oktober", "November", "Dezember")

#let translated-month(long: false, dt) = {
  if long {
    months_long.at(dt.month() - 1)
  } else {
    months_short.at(dt.month() - 1)
  }
}


// ENDE DOKUMENTEN-PARAMETER --------------------------------------------------------------------------