# Luanti Lernwelt Template

![Version](https://img.shields.io/badge/version-1.1.0-blue)
![License](https://img.shields.io/badge/license-MIT-green)
![Luanti](https://img.shields.io/badge/Luanti-5.x-orange)

> Ein wiederverwendbares Framework für kindgerechte Lernwelten in Luanti (Minetest) — Namen und Texturen tauschen, die Mechanik bleibt.

[🇬🇧 English Version](README.md)

> 🗺️ **Aufbau & Mechanik auf einen Blick:** siehe die [Architektur-Visualisierung](docs/ARCHITEKTUR.md).

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
- **Keine Texturen nötig** — Farben via `[fill`; **Muster** (geschichtete `[fill`),
  **Pro-Seiten-Texturen** (`top`/`side`/`bottom`) und eigene **PNGs** optional

## Themenwelten

Mitgeliefert werden eine minimale Kopiervorlage (`lernwelt_beispiel`) sowie
**vierzehn** voll ausgebaute Beispiel-Themen. Jede Welt hat eine eigene README,
eine vollständige Spielanleitung (`ANLEITUNG.md`), eine einseitige Kinder-Karte
(`KINDER-KURZ.md`), eine englische Anleitung (`GUIDE.md`) und eine Einrichtungs-
Notiz (`WELT-EINRICHTEN.md`).

| Welt | Thema | Schwerpunkt | Anleitung |
|---|---|---|---|
| [Glühpilz-Wald 🍄](lernwelt_gluehpilz/README.md) | kuscheliges Pilzreich (ideale Erstwelt) | Sortieren, frühe Mathematik, Tag-Nacht-Wechsel | [ANLEITUNG](lernwelt_gluehpilz/ANLEITUNG.md) · [EN](lernwelt_gluehpilz/GUIDE.md) |
| [Tiefsee-Retter 🌊](lernwelt_tiefsee/README.md) | Unterwasser-Rettung | Tiere retten, Tauchkapsel | [ANLEITUNG](lernwelt_tiefsee/ANLEITUNG.md) · [EN](lernwelt_tiefsee/GUIDE.md) |
| [Kosmo-Station 🚀](lernwelt_kosmo/README.md) | Weltraum-Station | Mond-Schwerkraft, Physik | [ANLEITUNG](lernwelt_kosmo/ANLEITUNG.md) · [EN](lernwelt_kosmo/GUIDE.md) |
| [Drachenhort 🐉](lernwelt_drachenhort/README.md) | freundliche Drachen | Verantwortung & Geduld (Drachenbaby grossziehen) | [ANLEITUNG](lernwelt_drachenhort/ANLEITUNG.md) · [EN](lernwelt_drachenhort/GUIDE.md) |
| [Schrauber-Werkstatt 🔧](lernwelt_schrauber/README.md) | Roboter & Logik | Schalter → Lampe → Tür-Logik, Algorithmen | [ANLEITUNG](lernwelt_schrauber/ANLEITUNG.md) · [EN](lernwelt_schrauber/GUIDE.md) |
| [Eisbär-Bucht 🐻‍❄️](lernwelt_eisbaer/README.md) | Polarwelt | Kälte-Tiere & Lebensräume (NMG.2) | [ANLEITUNG](lernwelt_eisbaer/ANLEITUNG.md) · [EN](lernwelt_eisbaer/GUIDE.md) |
| [Baumhaus-Forscher 🌳](lernwelt_baumhaus/README.md) | Dschungel-Baumhaus | Raumorientierung (NMG.3) | [ANLEITUNG](lernwelt_baumhaus/ANLEITUNG.md) · [EN](lernwelt_baumhaus/GUIDE.md) |
| [Naschwerk-Tal 🍬](lernwelt_naschwerk/README.md) | Süssigkeiten-Tal | frühe Mathematik / Zählen (MA.1) | [ANLEITUNG](lernwelt_naschwerk/ANLEITUNG.md) · [EN](lernwelt_naschwerk/GUIDE.md) |
| [Schatzinsel 🏴‍☠️](lernwelt_schatzinsel/README.md) | freundliche-Piraten-Schatzinsel | Raumorientierung & Zählen (NMG.3 / MA.1) | [ANLEITUNG](lernwelt_schatzinsel/ANLEITUNG.md) · [EN](lernwelt_schatzinsel/GUIDE.md) |
| [Sonnenhof 🌻](lernwelt_sonnenhof/README.md) | Zauber-Bauernhof (nutzt Farming Redo + Animalia) | Pflanzen & Tiere (NMG), vom Samen zum Brot | [ANLEITUNG](lernwelt_sonnenhof/ANLEITUNG.md) · [EN](lernwelt_sonnenhof/GUIDE.md) |
| [Summ-Garten 🐝](lernwelt_summgarten/README.md) | Bienen & Blumen | NMG + Geometrie (MA.2) | [ANLEITUNG](lernwelt_summgarten/ANLEITUNG.md) · [EN](lernwelt_summgarten/GUIDE.md) |
| [Saurier-Forscher 🦕](lernwelt_saurier/README.md) | Dinosaurier-Forscherstation | NMG & Grössenvergleich (MA) | [ANLEITUNG](lernwelt_saurier/ANLEITUNG.md) · [EN](lernwelt_saurier/GUIDE.md) |
| [Bimmelbahn-Land 🚂](lernwelt_bimmelbahn/README.md) | Kleine-Züge-Welt | Medien & Informatik (MI – Reihenfolge), Farben (BG) | [ANLEITUNG](lernwelt_bimmelbahn/ANLEITUNG.md) · [EN](lernwelt_bimmelbahn/GUIDE.md) |
| [Himmelsdorf 🌈](lernwelt_himmelsdorf/README.md) | Wolkenstadt | Wetter & Raumorientierung (NMG) | [ANLEITUNG](lernwelt_himmelsdorf/ANLEITUNG.md) · [EN](lernwelt_himmelsdorf/GUIDE.md) |

> 💡 **Eine Idee für eine neue Welt?** Schlage sie über das geführte Formular vor:
> [**New issue → 💡 Themenwelt vorschlagen / Suggest a theme world**](https://github.com/malkreide/luanti-lernwelt-template/issues/new/choose).
> Du füllst nur aus, was du schon weisst — Programmieren ist nicht nötig.

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

> 🪟🍎🐧 **Schritt für Schritt (Windows, macOS, Linux):** siehe [INSTALL.md](INSTALL.md).

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

Alles in diesem Projekt ist eines von zwei Dingen: **die Engine** (der
gemeinsame Maschinenraum, den jede Welt nutzt) oder **ein Thema** (eine
fertige, spielbare Welt). Man kann das ganze Repo also lesen als *eine Engine
plus viele austauschbare Welten*.

```
luanti-lernwelt-template/
│
├── lernwelt/            ← DIE ENGINE — hier liegt die gesamte gemeinsame
│                          Mechanik. Einmal aktivieren, normalerweise nie ändern.
│
├── lernwelt_beispiel/   ← Eine leere Start-Welt. Diesen Ordner kopieren, um
│                          die eigene Welt zu beginnen.
│
└── lernwelt_*/          ← Ein Ordner pro fertiger Welt (14 Stück, z.B.
                           lernwelt_gluehpilz, lernwelt_drachenhort …).
                           Die vollständige Liste ist die Tabelle „Themenwelten“ oben.
```

**Die Engine — `lernwelt/`**
Das ist der wiederverwendbare Teil, der jeder Welt dieselben Funktionen gibt:
die friedliche Konfiguration, die Lern-Tafeln, die Tiere und das Logbuch, die
Ränge und Abzeichen sowie die Lehrplan-21-Tags. Ein Thema schaltet diese nur
ein — der Engine-Code selbst wird nie angefasst.

**Ein Thema — z.B. `lernwelt_gluehpilz/`**
Das ist eine spielbare Welt. Jeder Themen-Ordner ist gleich aufgebaut: Wer
einen versteht, versteht alle.

| Datei | Was sie ist |
|---|---|
| `init.lua` | **Die Welt selbst** — eine `register_world{…}`-Beschreibung, plus Extras, die die Engine nicht abdeckt |
| `mod.conf` | Luantis Mod-Steckbrief (Name + Abhängigkeiten) |
| `README.md` | Kurze Beschreibung der Welt |
| `ANLEITUNG.md` | Vollständige Spielanleitung (Deutsch) |
| `GUIDE.md` | Vollständige Spielanleitung (Englisch) |
| `KINDER-KURZ.md` | Einseitige Karte für Kinder |
| `WELT-EINRICHTEN.md` | Wie man die Welt in Luanti einrichtet |

> 💡 **Kurz gesagt:** Man *spielt* immer nur die Themen und *kopiert* eines,
> um eine eigene Welt zu bauen. Die Engine ist der gemeinsame Werkzeugkasten
> darunter — man muss ihre inneren Dateien nicht verstehen, um sie zu nutzen.

<details>
<summary>Im Inneren der Engine (nur wenn du neugierig bist)</summary>

Die `lernwelt/`-Engine teilt ihre Arbeit in kleine Module unter `lernwelt/api/`:

| Modul | Aufgabe |
|---|---|
| `config.lua` | friedliche Config + `/lernwelt` |
| `lehrplan.lua` | Lehrplan-21-Tagging + `/lernplan` |
| `blocks.lua` | Farbblock-Generator |
| `zones.lua` | Zonen + Lern-Tafeln |
| `progress.lua` | Ränge, HUD, Abzeichen, Belohnungen |
| `mobs_adapter.lua` | `mobs_redo` / `mcl_mobs`-Abstraktion |
| `creatures.lua` | Spawner, Rettung, Logbuch |
| `register.lua` | der `register_world()`-Einstiegspunkt |

Übersetzungen liegen in `lernwelt/locale/` als `lernwelt.<lang>.tr`.

</details>

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

## Mitmachen

Beiträge sind willkommen — Übersetzungen, Bugfixes, Doku und neue
Beispiel-Themen. Wie es geht, steht in [CONTRIBUTING.md](CONTRIBUTING.md). Von
allen Beteiligten wird erwartet, dass sie unseren
[Verhaltenskodex](CODE_OF_CONDUCT.md) einhalten.

## Changelog

Siehe [CHANGELOG.md](CHANGELOG.md)

## Lizenz

MIT License — siehe [LICENSE](LICENSE). Der Code ist themenneutral; jedes
Thema ist selbst dafür verantwortlich, eigene, nicht rechtsverletzende
Namen und Assets zu verwenden.

## Autor

Hayal Oezkan · [malkreide](https://github.com/malkreide)
