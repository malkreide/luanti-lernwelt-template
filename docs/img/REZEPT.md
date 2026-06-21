# 📸 Rezept: Lern-Tafel- & Logbuch-Screenshot

Schritt-für-Schritt zu den zwei wichtigsten Bildern (`lerntafel.png` und
`logbuch.png`) — mit echten Befehlen aus der Beispielwelt **Glühpilz-Wald**.

> Für eine **andere Themenwelt** einfach `gluehpilz` durch den Mod-Namen
> ersetzen (z.B. `drachenhort:logbuch`, `drachenhort:tafel_<zone>`).

---

## 0) Vorbereiten (einmalig)

1. Luanti starten → **Neue Welt** anlegen.
2. Beim Erstellen **„Kreativmodus"** anhaken (dann funktioniert `/giveme` ohne
   Weiteres) und Schaden aus.
3. In der Mod-Auswahl **`lernwelt`** *und* **`lernwelt_gluehpilz`** aktivieren →
   Welt starten.
4. Als Singleplayer-Host hast du alle Rechte. Falls ein Befehl meckert:
   ```
   /grantme all
   ```
5. Bequemer Blickwinkel (Doppel-Sprung = fliegen):
   ```
   /grantme fly, fast, noclip
   ```

> 💡 Für **gut lesbare** Tafeln/Logbuch vorher den Großschrift-Modus an:
> *Einstellungen → Alle Einstellungen → Suche „lernwelt" → „Größere Schrift"*
> (oder in `minetest.conf`: `lernwelt_big_text = true`).

---

## A) Lern-Tafel 🪧

1. Tafel ins Inventar holen:
   ```
   /giveme gluehpilz:tafel_pilzwald
   ```
   (Alternativen: `gluehpilz:tafel_gluehhoehle`, `gluehpilz:tafel_bach`.)
2. Tafel **platzieren** (Rechtsklick auf den Boden) und dich davorstellen.
3. Optional Umgebung aufhübschen: ein paar bunte Lernwelt-Blöcke daneben setzen.
4. Auf die Tafel **rechtsklicken** → das Menü öffnet sich
   (**Aktivität + Lehrplan-Bezug**, evtl. eine Aufgabe).
5. Bei **offenem Menü** die Taste **F12** drücken → Screenshot liegt im
   `screenshots/`-Ordner deiner Luanti-Nutzerdaten.
6. Datei kopieren nach `docs/img/lerntafel.png`.

---

## B) Logbuch 📖

Damit Einträge „entdeckt" aussehen, retten wir vorher schnell ein Tier:

1. Spawn-Ei, Kamera und Logbuch holen:
   ```
   /giveme gluehpilz:igel
   /giveme gluehpilz:kamera
   /giveme gluehpilz:logbuch
   ```
2. Das **Igel-Ei** auf den Boden setzen (Rechtsklick) → ein Igel erscheint.
3. **Tier retten:** mit leerer Hand auf den Igel **rechtsklicken** (Zähler steigt,
   Sound). *Oder* die **Kamera** in die Hand nehmen und den Igel anklicken
   (= „mit Kamera entdeckt").
4. Das **Logbuch** (`Wald-Tagebuch`) in die Hand nehmen und **rechtsklicken** →
   das Logbuch-Menü öffnet sich (Steckbriefe, Rettungs-Zähler, „entdeckt"-Status).
5. Bei offenem Menü **F12** → Screenshot.
6. Ablegen als `docs/img/logbuch.png`.

---

## C) Optimieren & Einbinden

1. Screenshot bei Bedarf auf das Menü **zuschneiden** (beliebiger Bildeditor).
2. Im README den passenden `Screenshot-Slot` einkommentieren — z.B. in
   `README.md` / `README.de.md` für Tafel + Logbuch, oder in
   `lernwelt_gluehpilz/README.md` für das Hero-Bild.

---

## 🎞️ Optional: GIF (Tier retten)

1. **OBS Studio** starten, Fenster-/Bildschirmaufnahme.
2. 4–5 Sekunden aufnehmen, während du auf den Igel rechtsklickst
   (Zähler + Sound + Effekt).
3. In GIF/WebP umwandeln und verkleinern — Befehle siehe
   [README dieses Ordners](README.md):
   ```bash
   ffmpeg -i in.mp4 -vf "fps=12,scale=720:-1,palettegen" palette.png
   ffmpeg -i in.mp4 -i palette.png -lavfi "fps=12,scale=720:-1[x];[x][1:v]paletteuse" docs/img/hero.gif
   ```

---

## Spickzettel: Item-Namen pro Welt

| Item | Name | Bedienung |
|---|---|---|
| Lern-Tafel | `<welt>:tafel_<zone>` | platzieren + rechtsklicken |
| Logbuch | `<welt>:logbuch` | in die Hand nehmen + rechtsklicken |
| Kamera | `<welt>:kamera` | in die Hand nehmen, Tier anklicken |
| Tier (Spawn-Ei) | `<welt>:<tier-id>` | platzieren, dann retten |

Die Zonen- und Tier-IDs einer Welt stehen in ihrer `init.lua` (Felder `zones`
und `creatures`).
