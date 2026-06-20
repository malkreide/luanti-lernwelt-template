TEXTUREN fuer das Thema "Kosmo-Station"
=======================================

Das Thema laeuft OHNE eigene Texturen: Planeten, Stations-Wand, Bullaugen-Glas,
Weltraum-Freunde und Items bekommen ihre Farben ueber den Generator der Engine
("[fill:16x16:#farbe").

Wenn ihr eigene PNG-Texturen einsetzen wollt, legt sie hier ab
(16x16 oder 32x32 Pixel):

- Fuer BLOECKE: in der init.lua beim jeweiligen Block-Eintrag
  texture = "lernwelt_kosmo_planet_rot.png" ergaenzen (ersetzt die Farbe).
- Fuer FREUNDE/Items: die "[fill..."-Eintraege durch Dateinamen ersetzen.
  Eigene Tier-/Wesen-Texturen brauchen aktuell etwas Handarbeit, da die Engine
  die Wuerfel automatisch einfaerbt.

MUSTER OHNE DATEIEN (Textur-Modifier):
- Statt einer PNG kann "texture" auch ein Muster aus Farbflaechen sein.
  Eine Basis "[fill:16x16:#farbe" und darueber Auflagen mit "^":
    ^[fill:BREITExHOEHE:X,Y:#farbe   (Rechteck der Groesse BxH an Position X,Y)
  Beispiele (siehe die "muster_*"-Bloecke in der init.lua):
    Sternenhimmel: [fill:16x16:#1b1b3a^[fill:2x2:3,3:#ffffff^[fill:2x2:10,5:#ffffff
    Schachbrett:   [fill:16x16:#f1c40f^[fill:8x8:0,0:#34495e^[fill:8x8:8,8:#34495e
- So lassen sich beliebige einfache Muster bauen, ganz ohne Bilddateien.

PRO SEITE VERSCHIEDENE BILDER (top/side/bottom):
- Ein Block kann je Seite anders aussehen. Im Block-Eintrag statt "texture":
    top    = "...",   -- Oberseite (z. B. Deckel)
    side   = "...",   -- alle vier Seitenflaechen
    bottom = "...",   -- Unterseite
  Beispiel: der "vorratskiste"-Block in der init.lua (Deckel oben, Metall an den Seiten).

EIGENES GEMALTES BILD ALS BLOCK:
- In der init.lua steht bereits ein auskommentiertes Beispiel ("meinbild").
- PNG (16x16 oder 32x32) hier ablegen, z. B. lernwelt_kosmo_meinbild.png,
  dann in der init.lua die zwei Minuszeichen "--" vor der Beispielzeile entfernen.

WICHTIG (Urheberrecht):
- Verwendet nur SELBST erstellte oder frei lizenzierte Grafiken/Modelle.
- Keine Bilder, Figuren oder Logos aus geschuetzten Marken/Serien einbauen.
