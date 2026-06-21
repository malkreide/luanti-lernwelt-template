TEXTUREN fuer das Thema "Saurier-Forscher"
==========================================

Das Thema laeuft OHNE eigene Texturen: Bloecke, Stations-Glas, Dinos, Fossilien
und Items bekommen ihre Farben ueber den Generator der Engine
("[fill:16x16:#farbe").

Wenn ihr eigene PNG-Texturen einsetzen wollt, legt sie hier ab
(16x16 oder 32x32 Pixel):

- Fuer BLOECKE: in der init.lua beim jeweiligen Block-Eintrag
  texture = "lernwelt_saurier_fels.png" ergaenzen (ersetzt die Farbe).
- Fuer DINOS/Items: die "[fill..."-Eintraege durch Dateinamen ersetzen.
  Eigene Dino-Texturen brauchen aktuell etwas Handarbeit, da die Engine
  die Tier-Wuerfel automatisch einfaerbt.

MUSTER OHNE DATEIEN (Textur-Modifier):
- Statt einer PNG kann "texture" auch ein Muster aus Farbflaechen sein.
  Eine Basis "[fill:16x16:#farbe" und darueber Auflagen mit "^":
    ^[fill:BREITExHOEHE:X,Y:#farbe   (Rechteck der Groesse BxH an Position X,Y)
  Beispiele (siehe die "muster_*"-Bloecke in der init.lua):
    Schachbrett:  [fill:16x16:#e4c690^[fill:8x8:0,0:#5d4037^[fill:8x8:8,8:#5d4037
    Fussabdruck:  [fill:16x16:#e4c690^[fill:4x5:6,8:#5d4037^[fill:2x3:4,5:#5d4037...
- So lassen sich beliebige einfache Muster bauen, ganz ohne Bilddateien.
  Auch die Buchstaben- und Zahlen-Bloecke werden so per Code gemalt.

PRO SEITE VERSCHIEDENE BILDER (top/side/bottom):
- Ein Block kann je Seite anders aussehen. Im Block-Eintrag statt "texture":
    top    = "...",   -- Oberseite (z. B. Deckel)
    side   = "...",   -- alle vier Seitenflaechen
    bottom = "...",   -- Unterseite
  Beispiel: der "forscherkiste"-Block in der init.lua (Deckel oben, Holz seitlich).

EIGENES GEMALTES BILD ALS BLOCK:
- In der init.lua steht bereits ein auskommentiertes Beispiel ("meinbild").
- PNG (16x16 oder 32x32) hier ablegen, z. B. lernwelt_saurier_meinbild.png,
  dann in der init.lua die zwei Minuszeichen "--" vor der Beispielzeile entfernen.

WICHTIG (Urheberrecht):
- Verwendet nur SELBST erstellte oder frei lizenzierte Grafiken/Modelle.
- Keine Bilder, Figuren oder Logos aus geschuetzten Marken/Serien/Filmen einbauen.
