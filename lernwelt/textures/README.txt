TEXTUREN fuer das Lernwelt-Template
===================================

Das Template laeuft OHNE eigene Texturen: alle Bloecke, Tiere und
Items bekommen ihre Farben ueber den eingebauten Generator
"[fill:16x16:#farbe".

Wenn ihr eigene PNG-Texturen einsetzen wollt, legt sie in den
textures/-Ordner EURER Themen-Mod (nicht hier) und gebt sie in der
Welt-Definition an:

  Block:    { suffix="pilz_rot", texture="meinpack_pilz_rot.png", ... }
  Tier:     (Cube-Textur ersetzen -> direkt im Theme die Farbe gegen
             einen Dateinamen tauschen, oder ein 3D-Modell nutzen)

Empfohlene Groesse: 16x16 oder 32x32 Pixel, PNG.
