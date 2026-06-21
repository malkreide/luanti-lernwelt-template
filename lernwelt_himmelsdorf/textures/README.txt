TEXTUREN fuer das Thema "Himmelsdorf"
=====================================

Das Thema laeuft OHNE eigene Texturen: Wolken-/Himmels-/Regenbogen-Bloecke, die
Muster, der leuchtende Regenbogen, der Heissluftballon, die Wetter-Station,
Regenbogen-Samen und Items bekommen ihre Farben/Muster ueber den Generator der
Engine ("[fill:16x16:#farbe" mit Auflagen).

Wenn ihr eigene PNG-Texturen einsetzen wollt, legt sie hier ab
(16x16 oder 32x32 Pixel):

- Fuer BLOECKE: in der init.lua beim jeweiligen Block-Eintrag
  texture = "lernwelt_himmelsdorf_wolke.png" ergaenzen (ersetzt die Farbe).
- Fuer TIERE/Items: die "[fill..."-Eintraege durch Dateinamen ersetzen.
  Eigene Tier-Texturen brauchen aktuell etwas Handarbeit, da die Engine
  die Tier-Wuerfel automatisch einfaerbt.

MUSTER OHNE DATEIEN (Textur-Modifier):
- Statt einer PNG kann "texture" auch ein Muster aus Farbflaechen sein.
  Eine Basis "[fill:16x16:#farbe" und darueber Auflagen mit "^":
    ^[fill:BREITExHOEHE:X,Y:#farbe   (Rechteck der Groesse BxH an Position X,Y)
  Beispiele (siehe die Bloecke in der init.lua):
    Regenbogen:   [fill:16x16:#e74c3c^[fill:16x2:0,2:#e67e22^[fill:16x2:0,4:#f1c40f ...
    Wolke:        [fill:16x16:#eef7ff^[fill:6x4:2,8:#ffffff^[fill:5x4:9,9:#ffffff ...
    Sonne:        [fill:16x16:#f9e79f^[fill:8x8:4,4:#f1c40f^[fill:4x4:6,6:#fff8dc ...
- So lassen sich beliebige Himmels-/Regenbogen-Muster bauen, ganz ohne Bilddateien.

PRO SEITE VERSCHIEDENE BILDER (top/side/bottom):
- Ein Block kann je Seite anders aussehen. Im Block-Eintrag statt "texture":
    top    = "...",   -- Oberseite (z. B. die Grasflaeche des Inselbodens)
    side   = "...",   -- alle vier Seitenflaechen
    bottom = "...",   -- Unterseite (z. B. die haengenden Wurzeln/Steine)
  Beispiel: der "schwebeland"- und der "ballonkorb"-Block in der init.lua.

EIGENES GEMALTES BILD ALS BLOCK:
- In der init.lua steht bereits ein auskommentiertes Beispiel ("meinbild").
- PNG (16x16 oder 32x32) hier ablegen, z. B. lernwelt_himmelsdorf_meinbild.png,
  dann in der init.lua die zwei Minuszeichen "--" vor der Beispielzeile entfernen.

WICHTIG (Urheberrecht):
- Verwendet nur SELBST erstellte oder frei lizenzierte Grafiken/Modelle.
- Keine Bilder, Figuren oder Logos aus geschuetzten Marken/Serien einbauen.
