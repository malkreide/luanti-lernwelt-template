TEXTUREN fuer das Thema "Eisbaer-Bucht"
=======================================

Das Thema laeuft OHNE eigene Texturen: Schnee-/Eis-Bloecke, die Blau-Weiss-Muster,
Polarlicht, Schlitten, Futterstelle, Eisblumen und Items bekommen ihre Farben/Muster
ueber den Generator der Engine ("[fill:16x16:#farbe" mit Auflagen).

Wenn ihr eigene PNG-Texturen einsetzen wollt, legt sie hier ab
(16x16 oder 32x32 Pixel):

- Fuer BLOECKE: in der init.lua beim jeweiligen Block-Eintrag
  texture = "lernwelt_eisbaer_blaueis.png" ergaenzen (ersetzt die Farbe).
- Fuer TIERE/Items: die "[fill..."-Eintraege durch Dateinamen ersetzen.
  Eigene Tier-Texturen brauchen aktuell etwas Handarbeit, da die Engine
  die Tier-Wuerfel automatisch einfaerbt.

MUSTER OHNE DATEIEN (Textur-Modifier):
- Statt einer PNG kann "texture" auch ein Muster aus Farbflaechen sein.
  Eine Basis "[fill:16x16:#farbe" und darueber Auflagen mit "^":
    ^[fill:BREITExHOEHE:X,Y:#farbe   (Rechteck der Groesse BxH an Position X,Y)
  Beispiele (siehe die Bloecke in der init.lua):
    Streifen:     [fill:16x16:#3498db^[fill:3x16:3,0:#ffffff^[fill:3x16:10,0:#ffffff
    Schachbrett:  [fill:16x16:#ffffff^[fill:8x8:0,0:#3498db^[fill:8x8:8,8:#3498db
    Schneeflocke: [fill:16x16:#ffffff^[fill:2x12:7,2:#5dade2^[fill:12x2:2,7:#5dade2 ...
- So lassen sich beliebige blau-weisse Muster bauen, ganz ohne Bilddateien.

PRO SEITE VERSCHIEDENE BILDER (top/side/bottom):
- Ein Block kann je Seite anders aussehen. Im Block-Eintrag statt "texture":
    top    = "...",   -- Oberseite (z. B. der Deckel der Proviantkiste)
    side   = "...",   -- alle vier Seitenflaechen
    bottom = "...",   -- Unterseite
  Beispiel: der "proviantkiste"-Block in der init.lua.

EIGENES GEMALTES BILD ALS BLOCK:
- In der init.lua steht bereits ein auskommentiertes Beispiel ("meinbild").
- PNG (16x16 oder 32x32) hier ablegen, z. B. lernwelt_eisbaer_meinbild.png,
  dann in der init.lua die zwei Minuszeichen "--" vor der Beispielzeile entfernen.

WICHTIG (Urheberrecht):
- Verwendet nur SELBST erstellte oder frei lizenzierte Grafiken/Modelle.
- Keine Bilder, Figuren oder Logos aus geschuetzten Marken/Serien einbauen.
