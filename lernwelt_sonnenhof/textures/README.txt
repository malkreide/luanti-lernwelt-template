TEXTUREN fuer das Thema "Sonnenhof"
===================================

Das Thema laeuft OHNE eigene Texturen: alle Bloecke (Scheunenwand, Fachwerk,
Dach, Stroh, Ackererde, Weidezaun, Mehlsack, Hoflaterne ...), die Zaubermuehle,
der Futtertrog, das Weizen-Feld, die Sonnenblume, die Zauber-Giesskanne und die
Items (Korn, Mehl, Brot, Tierfutter, Samen) bekommen ihre Farben/Muster ueber
den Generator der Engine ("[fill:16x16:#farbe" mit Auflagen).

Wenn ihr eigene PNG-Texturen einsetzen wollt, legt sie hier ab
(16x16 oder 32x32 Pixel):

- Fuer BLOECKE: in der init.lua beim jeweiligen Block-Eintrag
  texture = "lernwelt_sonnenhof_scheunenwand.png" ergaenzen (ersetzt die Farbe).
- Fuer TIERE/Items: die "[fill..."-Eintraege durch Dateinamen ersetzen.
  Eigene Tier-Texturen brauchen aktuell etwas Handarbeit, da die Engine
  die Tier-Wuerfel automatisch einfaerbt.

MUSTER OHNE DATEIEN (Textur-Modifier):
- Statt einer PNG kann "texture" auch ein Muster aus Farbflaechen sein.
  Eine Basis "[fill:16x16:#farbe" und darueber Auflagen mit "^":
    ^[fill:BREITExHOEHE:X,Y:#farbe   (Rechteck der Groesse BxH an Position X,Y)
  Beispiele (siehe die Bloecke in der init.lua):
    Strohballen: [fill:16x16:#e3c14f^[fill:14x14:1,1:#d4af3d^[fill:4x4:6,6:#b8932c
    Ackererde:   [fill:16x16:#6b4a2b^[fill:16x2:0,2:#5a3d22^[fill:16x2:0,7:#5a3d22 ...

PRO SEITE VERSCHIEDENE BILDER (top/side/bottom):
- Ein Block kann je Seite anders aussehen. Im Block-Eintrag statt "texture":
    top    = "...",   -- Oberseite (z. B. der Deckel des Strohballens)
    side   = "...",   -- alle vier Seitenflaechen
    bottom = "...",   -- Unterseite
  Beispiele: "strohballen", "holzbalken" und "mehlsack" in der init.lua.

EIGENES GEMALTES BILD ALS BLOCK:
- In der init.lua steht bereits ein auskommentiertes Beispiel ("meinbild").
- PNG (16x16 oder 32x32) hier ablegen, z. B. lernwelt_sonnenhof_meinbild.png,
  dann in der init.lua die zwei Minuszeichen "--" vor der Beispielzeile entfernen.

WICHTIG (Urheberrecht):
- Verwendet nur SELBST erstellte oder frei lizenzierte Grafiken/Modelle.
- Keine Bilder, Figuren oder Logos aus geschuetzten Marken/Serien einbauen.
