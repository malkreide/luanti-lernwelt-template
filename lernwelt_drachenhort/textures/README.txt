TEXTUREN fuer das Thema "Drachenhort"
=====================================

Das Thema laeuft OHNE eigene Texturen: Drachensteine, Wolken, Eier, Drachen
und Items bekommen ihre Farben ueber den Generator der Engine
("[fill:16x16:#farbe").

Wenn ihr eigene PNG-Texturen einsetzen wollt, legt sie hier ab
(16x16 oder 32x32 Pixel):

- Fuer BLOECKE: in der init.lua beim jeweiligen Block-Eintrag
  texture = "lernwelt_drachenhort_drachenstein_rot.png" ergaenzen (ersetzt die Farbe).
- Fuer DRACHEN/Items: die "[fill..."-Eintraege durch Dateinamen ersetzen.
  Eigene Drachen-Texturen brauchen aktuell etwas Handarbeit, da die Engine
  die Tier-Wuerfel automatisch einfaerbt.

MUSTER OHNE DATEIEN (Textur-Modifier):
- Statt einer PNG kann "texture" auch ein Muster aus Farbflaechen sein.
  Eine Basis "[fill:16x16:#farbe" und darueber Auflagen mit "^":
    ^[fill:BREITExHOEHE:X,Y:#farbe   (Rechteck der Groesse BxH an Position X,Y)
  Beispiele (siehe die "schuppen_*"- und "muster"-Bloecke in der init.lua):
    Schuppen:    [fill:16x16:#c0392b^[fill:3x3:1,1:#e74c3c^[fill:3x3:7,1:#e74c3c ...
    Schachbrett: [fill:16x16:#7f8c8d^[fill:8x8:0,0:#566573^[fill:8x8:8,8:#566573
- So lassen sich beliebige einfache Muster bauen, ganz ohne Bilddateien.

PRO SEITE VERSCHIEDENE BILDER (top/side/bottom):
- Ein Block kann je Seite anders aussehen. Im Block-Eintrag statt "texture":
    top    = "...",   -- Oberseite (z. B. Nest-Rand)
    side   = "...",   -- alle vier Seitenflaechen
    bottom = "...",   -- Unterseite
  Beispiel: der "nest"-Block in der init.lua (Stroh-Rand oben, Zweige an den Seiten).

EIGENES GEMALTES BILD ALS BLOCK:
- In der init.lua steht bereits ein auskommentiertes Beispiel ("meinbild").
- PNG (16x16 oder 32x32) hier ablegen, z. B. lernwelt_drachenhort_meinbild.png,
  dann in der init.lua die zwei Minuszeichen "--" vor der Beispielzeile entfernen.

WICHTIG (Urheberrecht):
- Verwendet nur SELBST erstellte oder frei lizenzierte Grafiken/Modelle.
- Keine Bilder, Figuren oder Logos aus geschuetzten Marken/Serien einbauen.
