TEXTUREN fuer das Thema "Tiefsee-Retter"
========================================

Das Thema laeuft OHNE eigene Texturen: Korallen, Stations-Glas, Tiere und
Items bekommen ihre Farben ueber den Generator der Engine
("[fill:16x16:#farbe").

Wenn ihr eigene PNG-Texturen einsetzen wollt, legt sie hier ab
(16x16 oder 32x32 Pixel):

- Fuer BLOECKE: in der init.lua beim jeweiligen Block-Eintrag
  texture = "lernwelt_tiefsee_koralle_rot.png" ergaenzen (ersetzt die Farbe).
- Fuer TIERE/Items: die "[fill..."-Eintraege durch Dateinamen ersetzen.
  Eigene Tier-Texturen brauchen aktuell etwas Handarbeit, da die Engine
  die Tier-Wuerfel automatisch einfaerbt.

MUSTER OHNE DATEIEN (Textur-Modifier):
- Statt einer PNG kann "texture" auch ein Muster aus Farbflaechen sein.
  Eine Basis "[fill:16x16:#farbe" und darueber Auflagen mit "^":
    ^[fill:BREITExHOEHE:X,Y:#farbe   (Rechteck der Groesse BxH an Position X,Y)
  Beispiele (siehe die "muster_*"-Bloecke in der init.lua):
    Schachbrett: [fill:16x16:#f1c40f^[fill:8x8:0,0:#34495e^[fill:8x8:8,8:#34495e
    Streifen:    [fill:16x16:#e74c3c^[fill:3x16:3,0:#ffffff^[fill:3x16:10,0:#ffffff
- So lassen sich beliebige einfache Muster bauen, ganz ohne Bilddateien.

WICHTIG (Urheberrecht):
- Verwendet nur SELBST erstellte oder frei lizenzierte Grafiken/Modelle.
- Keine Bilder, Figuren oder Logos aus geschuetzten Marken/Serien einbauen.
