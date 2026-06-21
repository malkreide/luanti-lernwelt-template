TEXTUREN fuer das Thema "Naschwerk-Tal"
=======================================

Das Thema laeuft OHNE eigene Texturen: alle Suessigkeits-Bloecke (Lebkuchen,
Schokolade, Gummi, Drops, Lollis ...), der Regenbogen-Lolli, der Naschwagen,
die Naschschale, die Lolli-Setzlinge und die Items bekommen ihre Farben/Muster
ueber den Generator der Engine ("[fill:16x16:#farbe" mit Auflagen).

Wenn ihr eigene PNG-Texturen einsetzen wollt, legt sie hier ab
(16x16 oder 32x32 Pixel):

- Fuer BLOECKE: in der init.lua beim jeweiligen Block-Eintrag
  texture = "lernwelt_naschwerk_schokolade.png" ergaenzen (ersetzt die Farbe).
- Fuer TIERE/Items: die "[fill..."-Eintraege durch Dateinamen ersetzen.
  Eigene Tier-Texturen brauchen aktuell etwas Handarbeit, da die Engine
  die Tier-Wuerfel automatisch einfaerbt.

MUSTER OHNE DATEIEN (Textur-Modifier):
- Statt einer PNG kann "texture" auch ein Muster aus Farbflaechen sein.
  Eine Basis "[fill:16x16:#farbe" und darueber Auflagen mit "^":
    ^[fill:BREITExHOEHE:X,Y:#farbe   (Rechteck der Groesse BxH an Position X,Y)
  Beispiele (siehe die Bloecke in der init.lua):
    Zuckerstange: [fill:16x16:#ffffff^[fill:4x16:0,0:#e74c3c^[fill:4x16:8,0:#e74c3c
    Schokolade:   [fill:16x16:#4a2c11^[fill:7x7:1,1:#6b3e1d^[fill:7x7:8,1:#6b3e1d ...
    Drops (rot):  [fill:16x16:#e74c3c^[fill:5x4:3,3:#ff9e93^[fill:16x3:0,13:#a83228
- So lassen sich beliebige bunte Suessigkeits-Muster bauen, ganz ohne Bilddateien.

PRO SEITE VERSCHIEDENE BILDER (top/side/bottom):
- Ein Block kann je Seite anders aussehen. Im Block-Eintrag statt "texture":
    top    = "...",   -- Oberseite (z. B. der Deckel der Naschkiste)
    side   = "...",   -- alle vier Seitenflaechen
    bottom = "...",   -- Unterseite
  Beispiel: der "naschkiste"-Block in der init.lua.

EIGENES GEMALTES BILD ALS BLOCK:
- In der init.lua steht bereits ein auskommentiertes Beispiel ("meinbild").
- PNG (16x16 oder 32x32) hier ablegen, z. B. lernwelt_naschwerk_meinbild.png,
  dann in der init.lua die zwei Minuszeichen "--" vor der Beispielzeile entfernen.

WICHTIG (Urheberrecht):
- Verwendet nur SELBST erstellte oder frei lizenzierte Grafiken/Modelle.
- Keine Bilder, Figuren oder Logos aus geschuetzten Marken/Serien einbauen.
