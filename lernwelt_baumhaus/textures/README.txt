TEXTUREN fuer das Thema "Baumhaus-Forscher"
===========================================

Das Thema laeuft OHNE eigene Texturen: Blaetter, Baumstamm, Planken, Ruinen,
Dschungeltiere, die Bilderrahmen-Bilder und alle Items bekommen ihre Farben und
Muster ueber den Generator der Engine ("[fill:16x16:#farbe" plus Auflagen "^[fill").

Wenn ihr eigene PNG-Texturen einsetzen wollt, legt sie hier ab
(16x16 oder 32x32 Pixel):

- Fuer BLOECKE: in der init.lua beim jeweiligen Block-Eintrag
  texture = "lernwelt_baumhaus_blatt_hell.png" ergaenzen (ersetzt die Farbe).
- Fuer TIERE/Items: die "[fill..."-Eintraege durch Dateinamen ersetzen.
  Eigene Tier-Texturen brauchen aktuell etwas Handarbeit, da die Engine
  die Wuerfel automatisch einfaerbt.

BILDHINWEISE / BILDERRAHMEN:
- Die Bilder in den Rahmen (Blatt, Tropfen, Stein, Tier-Spur, Schatz, Pfeile)
  sind reine Farbmuster (siehe Tabelle PICTURES in der init.lua). Wer eigene
  Hinweis-Bilder moechte, kann dort die Overlay-Strings anpassen oder durch
  einen PNG-Dateinamen ersetzen (z.B. eigene Foto-Hinweise fuer eine
  Schnitzeljagd in der echten Umgebung der Kinder).

MUSTER OHNE DATEIEN (Textur-Modifier):
- Statt einer PNG kann "texture" auch ein Muster aus Farbflaechen sein.
  Eine Basis "[fill:16x16:#farbe" und darueber Auflagen mit "^":
    ^[fill:BREITExHOEHE:X,Y:#farbe   (Rechteck der Groesse BxH an Position X,Y)
  Beispiele: die Blatt-, Ruinen- und Pfeil-Texturen in der init.lua.

PRO SEITE VERSCHIEDENE BILDER (top/side/bottom):
- Ein Block kann je Seite anders aussehen. Im Block-Eintrag statt "texture":
    top    = "...",   -- Oberseite (z. B. die Jahresringe des Baumstamms)
    side   = "...",   -- alle vier Seitenflaechen (z. B. Rinde)
    bottom = "...",   -- Unterseite
  Beispiel: der Block "baumstamm" in der init.lua.

WICHTIG (Urheberrecht):
- Verwendet nur SELBST erstellte oder frei lizenzierte Grafiken/Modelle.
- Keine Bilder, Figuren oder Logos aus geschuetzten Marken/Serien einbauen.
