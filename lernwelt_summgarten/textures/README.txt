TEXTUREN fuer das Thema "Summ-Garten"
=====================================

Das Thema laeuft OHNE eigene Texturen: alle Bloecke (Bienenstock, Bienenkasten,
Waben, Wachsblock, Honigglas, Blumenwiese, Gartenzaun, Bluetenhecke, Obstbaum,
Gartenlaterne ...), die Honigschleuder, die gefuellte Honigwabe, die sechs
Blumen, die Obstbluete/Frucht, der Bestaeubungs-Pinsel und die Items (Nektar,
Honig, Apfel, Wachs) bekommen ihre Farben/Muster ueber den Generator der Engine
("[fill:16x16:#farbe" mit Auflagen).

Das SECHSECK-/WABEN-Muster wird per Code erzeugt (Funktion honeycomb() in der
init.lua): versetzte Sechseck-Zellen auf einem dunklen Wachs-Rand.

Wenn ihr eigene PNG-Texturen einsetzen wollt, legt sie hier ab
(16x16 oder 32x32 Pixel):

- Fuer BLOECKE: in der init.lua beim jeweiligen Block-Eintrag
  texture = "lernwelt_summgarten_wabe.png" ergaenzen (ersetzt die Farbe).
- Fuer TIERE/Items: die "[fill..."-Eintraege durch Dateinamen ersetzen.
  Eigene Tier-Texturen brauchen aktuell etwas Handarbeit, da die Engine
  die Tier-Wuerfel automatisch einfaerbt.

MUSTER OHNE DATEIEN (Textur-Modifier):
- Statt einer PNG kann "texture" auch ein Muster aus Farbflaechen sein.
  Eine Basis "[fill:16x16:#farbe" und darueber Auflagen mit "^":
    ^[fill:BREITExHOEHE:X,Y:#farbe   (Rechteck der Groesse BxH an Position X,Y)
  Beispiele (siehe die Bloecke in der init.lua):
    Blumenwiese: [fill:16x16:#5fae3a^[fill:2x2:3,3:#f1c40f^[fill:2x2:11,5:#ffffff ...
    Waben:       per honeycomb()-Funktion erzeugt (Sechseck-Zellen)

PRO SEITE VERSCHIEDENE BILDER (top/side/bottom):
- Ein Block kann je Seite anders aussehen. Im Block-Eintrag statt "texture":
    top    = "...",   -- Oberseite
    side   = "...",   -- alle vier Seitenflaechen
    bottom = "...",   -- Unterseite
  Beispiele: "bienenstock", "honigglas" und "obstbaum_stamm" in der init.lua.

EIGENES GEMALTES BILD ALS BLOCK:
- In der init.lua steht bereits ein auskommentiertes Beispiel ("meinbild").
- PNG (16x16 oder 32x32) hier ablegen, z. B. lernwelt_summgarten_meinbild.png,
  dann in der init.lua die zwei Minuszeichen "--" vor der Beispielzeile entfernen.

WICHTIG (Urheberrecht):
- Verwendet nur SELBST erstellte oder frei lizenzierte Grafiken/Modelle.
- Keine Bilder, Figuren oder Logos aus geschuetzten Marken/Serien einbauen.
