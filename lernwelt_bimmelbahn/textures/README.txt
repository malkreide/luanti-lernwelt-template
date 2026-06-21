TEXTUREN fuer das Thema "Bimmelbahn-Land"
=========================================

Das Thema laeuft OHNE eigene Texturen: Bloecke, Bahnhofs-Glas, Schienen,
Stations-Schilder, Signale, Wagen, Fahrgaeste und Items bekommen ihre Farben
ueber den Generator der Engine ("[fill:16x16:#farbe").

Wenn ihr eigene PNG-Texturen einsetzen wollt, legt sie hier ab
(16x16 oder 32x32 Pixel):

- Fuer BLOECKE: in der init.lua beim jeweiligen Block-Eintrag
  texture = "lernwelt_bimmelbahn_backstein.png" ergaenzen (ersetzt die Farbe).
- Fuer FAHRGAESTE/Items: die "[fill..."-Eintraege durch Dateinamen ersetzen.
  Eigene Tier-Texturen brauchen aktuell etwas Handarbeit, da die Engine
  die Tier-Wuerfel automatisch einfaerbt.

MUSTER OHNE DATEIEN (Textur-Modifier):
- Statt einer PNG kann "texture" auch ein Muster aus Farbflaechen sein.
  Eine Basis "[fill:16x16:#farbe" und darueber Auflagen mit "^":
    ^[fill:BREITExHOEHE:X,Y:#farbe   (Rechteck der Groesse BxH an Position X,Y)
  Beispiele (siehe die "muster_*"- und "schiene"-Bloecke in der init.lua):
    Schachbrett:   [fill:16x16:#ecf0f1^[fill:8x8:0,0:#34495e^[fill:8x8:8,8:#34495e
    Bahnuebergang: [fill:16x16:#2c3e50^[fill:16x3:0,1:#f1c40f^[fill:16x3:0,7:#f1c40f...
- So lassen sich beliebige einfache Muster bauen, ganz ohne Bilddateien.
  Auch die Buchstaben- und Zahlen-Bloecke werden so per Code gemalt.

PRO SEITE VERSCHIEDENE BILDER (top/side/bottom):
- Ein Block kann je Seite anders aussehen. Im Block-Eintrag statt "texture":
    top    = "...",   -- Oberseite (z. B. Zifferblatt der Uhr)
    side   = "...",   -- alle vier Seitenflaechen
    bottom = "...",   -- Unterseite
  Beispiele: die Bloecke "bahnhofsuhr" und "koffer" in der init.lua.

EIGENES GEMALTES BILD ALS BLOCK:
- In der init.lua steht bereits ein auskommentiertes Beispiel ("meinbild").
- PNG (16x16 oder 32x32) hier ablegen, z. B. lernwelt_bimmelbahn_meinbild.png,
  dann in der init.lua die zwei Minuszeichen "--" vor der Beispielzeile entfernen.

WICHTIG (Urheberrecht):
- Verwendet nur SELBST erstellte oder frei lizenzierte Grafiken/Modelle.
- Keine Bilder, Figuren oder Logos aus geschuetzten Marken/Serien/Filmen einbauen.
