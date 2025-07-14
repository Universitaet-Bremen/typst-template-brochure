#import "src/conf.typ": *
#import "src/modules.typ" as uni
#import "@preview/glossarium:0.5.7": gls, glspl
// ALLE MODULE AUFRUFBAR ÜBER #uni.MODULNAME()

= Kapitelüberschrift

== Auch mehrzeilige Überschrift

#uni.anlesertext([Hier folgt ein Anlesertext, der einem normalen Text vorrangestellt ist:\ #lorem(20)])

Dies ist ein normaler Text des Dokuments. #lorem(100)

=== Unterteilende Sub-Überschrift
==== Sub-Überschrift
#lorem(100)

==== Sub-Überschrift
#lorem(100)

#uni.box(
  [
    *Beispielbox #gls("iot")*\
    Beispielhafte Box mit _Italic-Test-Inhalt_
  ]
)

==== Sub-Überschrift
#lorem(200)