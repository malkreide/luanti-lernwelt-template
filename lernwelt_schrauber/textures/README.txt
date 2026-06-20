TEXTUREN fuer das Thema "Schrauber-Werkstatt"
=============================================

Das Thema laeuft OHNE eigene Texturen: Werkstatt-Bloecke, Logik-Kit (Schalter,
Leitung, Lampe, Tuer), Roboter, Fliessband, Recycler und Items bekommen ihre
Farben/Muster ueber den Generator der Engine ("[fill:16x16:#farbe" mit Auflagen).

Wenn ihr eigene PNG-Texturen einsetzen wollt, legt sie hier ab
(16x16 oder 32x32 Pixel):

- Fuer BLOECKE: in der init.lua beim jeweiligen Block-Eintrag
  texture = "lernwelt_schrauber_stahlplatte.png" ergaenzen (ersetzt die Farbe).
- Fuer ROBOTER/Items: die "[fill..."-Eintraege durch Dateinamen ersetzen.
  Eigene Roboter-Texturen brauchen aktuell etwas Handarbeit, da die Engine
  die Tier-/Roboter-Wuerfel automatisch einfaerbt.

MUSTER OHNE DATEIEN (Textur-Modifier):
- Statt einer PNG kann "texture" auch ein Muster aus Farbflaechen sein.
  Eine Basis "[fill:16x16:#farbe" und darueber Auflagen mit "^":
    ^[fill:BREITExHOEHE:X,Y:#farbe   (Rechteck der Groesse BxH an Position X,Y)
  Beispiele (siehe die Bloecke in der init.lua):
    Riffelblech:  [fill:16x16:#7f8c8d^[fill:3x3:1,1:#95a5a6^[fill:3x3:7,4:#95a5a6 ...
    Warnband:     [fill:16x16:#f1c40f^[fill:4x16:0,0:#1a1a1a^[fill:4x16:8,0:#1a1a1a
    Schachbrett:  [fill:16x16:#95a5a6^[fill:8x8:0,0:#7f8c8d^[fill:8x8:8,8:#7f8c8d
- So lassen sich beliebige einfache Muster bauen, ganz ohne Bilddateien.

PRO SEITE VERSCHIEDENE BILDER (top/side/bottom):
- Ein Block kann je Seite anders aussehen. Im Block-Eintrag statt "texture":
    top    = "...",   -- Oberseite (z. B. Werkzeuge auf der Werkbank)
    side   = "...",   -- alle vier Seitenflaechen
    bottom = "...",   -- Unterseite
  Beispiel: der "werkbank"-Block in der init.lua (Werkzeuge oben, Stahl an den Seiten).

EIGENES GEMALTES BILD ALS BLOCK:
- In der init.lua steht bereits ein auskommentiertes Beispiel ("meinbild").
- PNG (16x16 oder 32x32) hier ablegen, z. B. lernwelt_schrauber_meinbild.png,
  dann in der init.lua die zwei Minuszeichen "--" vor der Beispielzeile entfernen.

WICHTIG (Urheberrecht):
- Verwendet nur SELBST erstellte oder frei lizenzierte Grafiken/Modelle.
- Keine Bilder, Figuren oder Logos aus geschuetzten Marken/Serien einbauen.
