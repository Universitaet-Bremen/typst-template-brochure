#import "@preview/glossarium:0.5.9": gls, glspl
#import "@preview/moin-uni-brochure:0.1.0": anlesertext, box

= Kapitelüberschrift

== Auch mehrzeilige Überschrift

#anlesertext(
  [Hier folgt ein Anlesertext, der einem normalen Text vorrangestellt ist:\ #lorem(20)],
)

Dies ist ein normaler Text des Dokuments. #lorem(100)

=== Unterteilende Sub-Überschrift
==== Sub-Überschrift
#lorem(100)

==== Sub-Überschrift
#lorem(100)

#box(
  [
    *Beispielbox #gls("iot")*\
    Beispielhafte Box mit _Italic-Test-Inhalt_
  ],
)

==== Sub-Überschrift
#lorem(200)
