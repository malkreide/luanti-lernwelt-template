# Luanti Lernwelt Template

![Version](https://img.shields.io/badge/version-1.1.0-blue)
![License](https://img.shields.io/badge/license-MIT-green)
![Luanti](https://img.shields.io/badge/Luanti-5.x-orange)

> Ein wiederverwendbares Framework für kindgerechte Lernwelten in Luanti (Minetest) — Namen und Texturen tauschen, die Mechanik bleibt.

[🇬🇧 English Version](README.md)

## Übersicht

`lernwelt` ist eine Luanti-Engine-Mod, die alles kapselt, was eine kleine,
kuratierte Lernwelt für Vorschulkinder braucht: eine friedliche
Konfiguration (kein Schaden, keine Monster, eingefrorener Tag), ein
**Zonen-System** mit Lern-Tafeln, einen **Creature-Spawner** mit
Rettungs-Mechanik und Logbuch, ein **Fortschritts-System** (Ränge, HUD,
Abzeichen) und **Lehrplan-21-Tagging**.

Ein Thema besteht aus einem einzigen deklarativen `register_world{...}`-
Aufruf — kein weiterer Lua-Code nötig. Themen sind austauschbar: dasselbe
bewährte Gerüst wird so zum Glühpilz-Wald, zum Drachenhort, zur
Roboter-Werkstatt. Das umgeht das Copyright-Problem grundsätzlich, denn
das Framework ist themenneutral und Themen verwenden eigene Namen und
Texturen.

## Funktionen

- **Friedliche Config** zur Laufzeit gesetzt + kopierbare Zeilen für `minetest.conf`
- **Zonen-System** mit platzierbaren Lern-Tafeln (Aktivität + Lehrplan + optionaler Teleport)
- **Aufgaben an den Lern-Tafeln** (optional): Quiz, Muster-Nachlegen und Rette-Ziele mit Belohnung
- **Creature-Spawner** für friedliche, rettbare Land-/Wassertiere (funktioniert mit `mobs_redo` *oder* `mcl_mobs` — VoxeLibre / Mineclonia)
- **Automatisches Spawnen von Wassertieren** in der Nähe der Spielenden (schonend begrenzt, abschaltbar; `rare`-Tiere ausgenommen)
- **Tier-Familien**: ein gerettetes Elterntier bringt seine Jungtiere mit
- **Entdecker-Kamera** pro Welt: Tiere fotografieren = im Logbuch entdecken (Sammeln)
- **Logbuch pro Welt** mit Tier-Steckbriefen, Rettungs-Zählern und „entdeckt"-Status
- **Fortschritt**: Ränge, HUD, automatisch erzeugte Abzeichen-Items, Rettungs-Sounds
- **Lehrplan-21-Tagging** mit `/lernplan`-Übersicht und persönlichem Bericht `/lernfortschritt`
- **Barrierearm**: Großschrift-Modus und Einfacher Modus (weniger Quiz-Optionen)
- **Curriculum-agnostisch**: Lehrplan 21 (Schweiz) ist nur der mitgelieferte Default — `lernwelt.fachbereiche` lässt sich gegen jeden anderen Lehrplan tauschen
- **Internationalisiert**: englische Quellstrings + Übersetzungsfiles (`locale/*.tr`), Deutsch inklusive; die Spiel-Oberfläche folgt der Client-Sprache
- **Keine Texturen nötig** — Farben via `[fill`; eigene PNGs optional

## Voraussetzungen

- Luanti / Minetest 5.x
- Ein Basis-Game, empfohlen: **Mineclonia** oder **Minetest Game**
- Eine Mob-API für die lebenden Tiere — optional. `mobs_redo` (Minetest Game) oder `mcl_mobs` (in VoxeLibre / Mineclonia enthalten); die Engine erkennt automatisch, welche vorhanden ist

## Installation

```bash
# Beide Mods in den Luanti-Mods-Ordner kopieren:
#   <luanti>/mods/lernwelt            (die Engine)
#   <luanti>/mods/lernwelt_beispiel   (das Beispiel-Thema)
# Danach im Menue "Mods auswaehlen" fuer die Welt aktivieren.
```

## Verwendung / Schnellstart

Ein vollständiges Thema ist nur eine deklarative Tabelle:

```lua
lernwelt.register_world({
    id    = "gluehpilz",   -- muss dem Mod-Namen entsprechen (Ordner / mod.conf); darf entfallen
    title = "Gluehpilz-Wald",
    config    = { peaceful = true, damage = false, freeze_time = "day" },
    blocks    = { { suffix = "pilz_rot", name = "Roter Leuchtpilz", color = "#e74c3c", glow = 7 } },
    zones     = { { id = "wiese", title = "Bach-Wiese", activity = "Muster legen", lehrplan = { "MA.2" } } },
    creatures = { { id = "schnecke", name = "Schnecke", zone = "wiese", color = "#f39c12", speed = 0.3 } },
    ranks     = { { 0, "Frischling" }, { 10, "Forscher", "#2ecc71" } },
    logbook   = { title = "Forscher-Logbuch" },
})
```

Im Spiel:

- Rechtsklick auf ein Tier → retten (Zähler, Rang, Sound)
- Rechtsklick auf das Logbuch-Item → Steckbriefe + deine Zähler
- Lern-Tafel platzieren und anklicken → Aktivität + Lehrplan-Bezug
- `/lernplan` → Übersicht aller Zonen und ihrer Lehrplan-21-Bezüge
- `/lernwelt` → Status + empfohlene `minetest.conf`-Zeilen

## Eigene Welt bauen

1. `lernwelt_beispiel` kopieren, Ordner umbenennen (z.B. `lernwelt_drachenhort`)
2. `name` in der `mod.conf` auf genau diesen Ordnernamen setzen
3. `init.lua` bearbeiten: `id` auf den **gleichen** Mod-Namen setzen (oder `id`
   weglassen — dann wird automatisch der Mod-Name verwendet), dann `title`,
   Blöcke, Zonen, Tiere, Ränge und Tags tauschen
4. Optional: eigene PNG-Texturen ablegen und angeben

> **Warum `id` = Mod-Name?** Jeder Block, jedes Item und jedes Tier wird im
> Namensraum `<id>:` registriert, und Luanti erlaubt einem Mod nur den eigenen
> Namensraum. Die Engine erzwingt das und bricht bei Abweichung früh mit einer
> klaren Meldung ab.

## Projektstruktur

```
luanti-lernwelt-template/
├── lernwelt/                 # Engine-Mod (das wiederverwendbare Framework)
│   ├── init.lua              # laedt die API-Module
│   ├── settingtypes.txt      # HUD-Schalter
│   ├── locale/
│   │   └── lernwelt.de.tr     # deutsche Uebersetzung (weitere: lernwelt.<lang>.tr)
│   └── api/
│       ├── config.lua        # friedliche Config + /lernwelt
│       ├── lehrplan.lua      # Lehrplan-21-Tagging + /lernplan
│       ├── blocks.lua        # Farbblock-Generator
│       ├── zones.lua         # Zonen + Lern-Tafeln
│       ├── progress.lua      # Raenge, HUD, Abzeichen, reward()
│       ├── mobs_adapter.lua  # mobs_redo / mcl_mobs Abstraktion
│       ├── creatures.lua     # Spawner, Rettung, Logbuch
│       └── register.lua      # register_world()
├── lernwelt_beispiel/        # Beispiel-Thema: Gluehpilz-Wald
│   └── init.lua              # ein deklaratives register_world{...}
└── lernwelt_tiefsee/         # Beispiel-Thema: Tiefsee-Retter (Unterwasser)
    ├── init.lua              # register_world{...} + Tauchkapsel + Startausruestung
    └── settingtypes.txt      # Schalter fuer die Startausruestung
```

Zwei Themen sind als Beispiele dabei: **`lernwelt_beispiel`** (Gluehpilz-Wald)
und **`lernwelt_tiefsee`** (Tiefsee-Retter). Letzteres zeigt, wie ein Thema **eigene
Zusatz-Inhalte** — hier eine fahrbare Tauchkapsel und eine Startausrüstung beim
ersten Join — zusätzlich zur Engine mitbringen kann. Eine vollständige
**Spielanleitung** dazu (alle Elemente, Bedienung, Aufgaben & Ziele) steht in
[`lernwelt_tiefsee/ANLEITUNG.md`](lernwelt_tiefsee/ANLEITUNG.md).

## Übersetzungen

Die Oberflächen-Texte der Engine sind auf Englisch geschrieben und werden
über `lernwelt/locale/lernwelt.<lang>.tr` (Luantis Übersetzungssystem)
übersetzt. Deutsch (`de`) und Französisch (`fr`) sind dabei. Für eine weitere
Sprache die Vorlage
`lernwelt/locale/template.txt` nach `lernwelt.<lang>.tr` kopieren (z.B.
`lernwelt.fr.tr`) und die rechte Seite ausfüllen — die vollständige Anleitung
steht in [CONTRIBUTING.md](CONTRIBUTING.md). Die **Inhalte** eines Themas
(Tiernamen, Aktivitäten) stehen direkt im Thema und bleiben in der Sprache,
die der Themen-Autor wählt.

## Changelog

Siehe [CHANGELOG.md](CHANGELOG.md)

## Lizenz

MIT License — siehe [LICENSE](LICENSE). Der Code ist themenneutral; jedes
Thema ist selbst dafür verantwortlich, eigene, nicht rechtsverletzende
Namen und Assets zu verwenden.

## Autor

Hayal Oezkan · [malkreide](https://github.com/malkreide)
