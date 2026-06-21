# Screenshots & GIFs

Dieser Ordner enthält die Bilder/GIFs für die READMEs. **Visuelle Repos werden
deutlich häufiger geöffnet** – schon ein Screenshot der **Lern-Tafel** und des
**Logbuchs** lohnt sich.

In den READMEs sind die Einbettungs-Stellen bereits als **HTML-Kommentar**
vorbereitet (Suche nach `Screenshot-Slot`). Sobald die passende Datei hier
liegt, einfach den Kommentar entfernen – fertig.

## Shot-Liste (Wunschbilder)

| Datei | Motiv | Format |
|---|---|---|
| `lerntafel.png` | Geöffnete **Lern-Tafel** (Aktivität + Lehrplan-Bezug, ggf. Aufgabe) | PNG |
| `logbuch.png` | Geöffnetes **Logbuch** (Tier-Steckbriefe, Rettungs-Zähler) | PNG |
| `hero.gif` *(optional)* | Kurzer Rundgang/Tier retten als Loop | GIF / animiertes WebP |
| `lernwelt_<id>.png` | Ein „Hero"-Bild pro Themenwelt, z.B. `lernwelt_gluehpilz.png` | PNG / GIF |

Die Themenwelt-Bilder heissen wie der Mod-Ordner (`lernwelt_gluehpilz`,
`lernwelt_drachenhort`, …) und werden in der jeweiligen Themen-README direkt
unter den Lehrplan-Badges eingebunden.

## 1. Aufnehmen (in Luanti)

- **Standbild:** Taste **F12** speichert einen Screenshot (Ordner `screenshots/`
  in den Luanti-Nutzerdaten).
- **Sauberes Bild:** mit **F1** das HUD aus-/einblenden. Für die Lern-Tafel und
  das Logbuch das jeweilige Menü **offen** lassen, damit man die UI sieht.
- **Guter Blickwinkel:** `/grantme fly fast noclip`, dann frei positionieren.
- **GIF/Video:** Bildschirmaufnahme mit **OBS Studio** (alle Plattformen),
  **ScreenToGif** (Windows), **Peek** (Linux) oder **Kap** (macOS). Kurz halten
  (3–6 s, gut als Loop), nur den relevanten Ausschnitt.

## 2. Optimieren (GIFs werden schnell gross)

- Ziel: unter ~3–5 MB.
- GIF verkleinern: `gifsicle -O3 --colors 128 in.gif -o out.gif`
- Noch kleiner – animiertes **WebP** aus einem Video:
  `ffmpeg -i in.mp4 -vf "fps=12,scale=720:-1" -loop 0 out.webp`
- Hochwertiges GIF aus Video (Palette):
  ```bash
  ffmpeg -i in.mp4 -vf "fps=12,scale=720:-1,palettegen" palette.png
  ffmpeg -i in.mp4 -i palette.png -lavfi "fps=12,scale=720:-1[x];[x][1:v]paletteuse" hero.gif
  ```

## 3. Format-Hinweis

GitHub zeigt **PNG/JPG**, **animiertes GIF** und **animiertes WebP** direkt im
README. **`.mp4` spielt über die Markdown-Bildsyntax `![]()` nicht ab** – für
Bewegung also GIF oder WebP verwenden.
