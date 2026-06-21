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
├── lernwelt_beispiel/        # minimale Kopiervorlage (Titel Gluehpilz-Wald)
│   └── init.lua              # ein deklaratives register_world{...}
├── lernwelt_gluehpilz/       # Beispiel-Thema: Gluehpilz-Wald (kuschelige Erstwelt)
│   ├── init.lua              # register_world{...} + Leucht-Kaefer + Tag-Nacht-Pilze
│   └── settingtypes.txt      # Schalter fuer die Startausruestung
├── lernwelt_tiefsee/         # Beispiel-Thema: Tiefsee-Retter (Unterwasser)
│   ├── init.lua              # register_world{...} + Tauchkapsel + Startausruestung
│   └── settingtypes.txt      # Schalter fuer die Startausruestung
├── lernwelt_kosmo/           # Beispiel-Thema: Kosmo-Station (Weltraum)
│   ├── init.lua              # register_world{...} + Raumgleiter + Mond-Schwerkraft
│   └── settingtypes.txt      # Schalter fuer die Startausruestung
├── lernwelt_drachenhort/     # Beispiel-Thema: Drachenhort (freundliche Drachen)
│   ├── init.lua              # register_world{...} + Drachenbaby grossziehen + Flugdrache
│   └── settingtypes.txt      # Schalter fuer die Startausruestung
├── lernwelt_schrauber/       # Beispiel-Thema: Schrauber-Werkstatt (Roboter & Logik)
│   ├── init.lua              # register_world{...} + Schalter/Lampe/Tuer-Logik + Roboterbau
│   └── settingtypes.txt      # Schalter fuer die Startausruestung
├── lernwelt_eisbaer/         # Beispiel-Thema: Eisbaer-Bucht (Polarwelt, Kaelte-Tiere)
│   ├── init.lua              # register_world{...} + Schlitten + farbwechselnde Aurora + Fuettern
│   └── settingtypes.txt      # Schalter fuer die Startausruestung
├── lernwelt_baumhaus/        # Beispiel-Thema: Baumhaus-Forscher (Dschungel, Raumorientierung)
│   ├── init.lua              # register_world{...} + Bild-Hinweis-Rahmen + Schnitzeljagd + Kompass
│   └── settingtypes.txt      # Schalter fuer die Startausruestung
├── lernwelt_naschwerk/       # Beispiel-Thema: Naschwerk-Tal (Suessigkeiten / fruehe Mathematik)
│   ├── init.lua              # register_world{...} + Zaehl-Spiel + Naschwagen + farbwechselnder Lolli
│   └── settingtypes.txt      # Schalter fuer die Startausruestung
├── lernwelt_schatzinsel/     # Beispiel-Thema: Schatzinsel (freundliche Piraten, Karten & Zaehlen)
│   ├── init.lua              # register_world{...} + Kompass + Schatzkarte + Wegweiser-Schnitzeljagd + Muenzen-Zaehlen + Floss
│   └── settingtypes.txt      # Schalter fuer die Startausruestung
└── lernwelt_sonnenhof/       # Beispiel-Thema: Sonnenhof (Zauber-Bauernhof; nutzt Farming Redo + Animalia)
    ├── init.lua              # register_world{...} + Vom Samen zum Brot + Giesskanne + Zaubermuehle + Trog
    └── settingtypes.txt      # Schalter fuer die Startausruestung
```

Dabei sind eine minimale Kopiervorlage, **`lernwelt_beispiel`**, sowie zehn voll
ausgebaute Beispiel-Themen: **`lernwelt_gluehpilz`** (Gluehpilz-Wald),
**`lernwelt_tiefsee`** (Tiefsee-Retter), **`lernwelt_kosmo`** (Kosmo-Station),
**`lernwelt_drachenhort`** (Drachenhort), **`lernwelt_schrauber`**
(Schrauber-Werkstatt), **`lernwelt_eisbaer`** (Eisbaer-Bucht),
**`lernwelt_baumhaus`** (Baumhaus-Forscher), **`lernwelt_naschwerk`**
(Naschwerk-Tal), **`lernwelt_schatzinsel`** (Schatzinsel) und **`lernwelt_sonnenhof`** (Sonnenhof).
Sie zeigen, wie ein Thema **eigene Zusatz-Inhalte** zusätzlich zur Engine mitbringen
kann — der Glühpilz-Wald einen reitbaren Leucht-Käfer plus **Tag-Nacht-Pilze** (ein
kindgesteuerter Tag-Nacht-Wechsel), die Tiefsee eine fahrbare Tauchkapsel, die
Kosmo-Station einen Raumgleiter plus **Mond-Schwerkraft-Blöcke**, der Drachenhort
das **Großziehen eines Drachenbabys** (ein Ei ausbrüten, dann geduldig füttern & zähmen —
Verantwortung & Geduld) plus einen **fliegenden Reitdrachen**, die Schrauber-Werkstatt
ein selbstständiges **Schalter → Leitung → Lampe → Tür-Logiksystem** (sanfte Brücke zu
Mesecons) plus **einen Roboter in der richtigen Reihenfolge zusammenbauen** (ein Algorithmus),
die Eisbär-Bucht einen fahrbaren **Schlitten**, ein leuchtendes **Polarlicht**, das
langsam die Farbe wechselt, und eine Futterstelle für **Kälte-Tiere & ihre Lebensräume**
(NMG.2), und der Baumhaus-Forscher ein **Dschungel-Baumhaus** rund um die
**Raumorientierung** (NMG.3): die Stockwerke des Waldes (oben/unten über kletterbare
Lianen & Strickleitern), eine **Schnitzeljagd mit Bild-Hinweisen in Bilderrahmen** und
einen **Forscher-Kompass**, und das Naschwerk-Tal ein knallbuntes **Süssigkeiten-Tal**
rund um die **frühe Mathematik** (MA.1): ein interaktives **Zähl-Spiel** (Zähl-Naschtisch
— „Wie viele Bonbons?"), **Muster-Tafeln** (rot–gelb–rot …), einen fahrbaren **Naschwagen**
und einen leuchtenden **Regenbogen-Lolli**, der langsam die Farbe wechselt, und die
Schatzinsel eine freundliche-Piraten-**Schatzinsel** rund um **Raumorientierung**
(NMG.3 / MA.3) und **Zählen** (MA.1): einen **Schatz-Kompass** (wohin du schaust,
oben/unten, gezählte Münzen), eine **Schatzkarte**, die den Weg zum nächsten Hinweis
liest, eine **Schnitzeljagd mit Bild- und Pfeil-Wegweisern** über drei Zonen (Insel,
Tropfsteinhöhle, Lagune), **Goldmünzen-Sammeln & -Zählen** mit Zahlen-Blöcken 0–9 und
ein zweisitziges **Floss** — dazu eine Schiff-und-Steg-Basis per Befehl, und der
Sonnenhof ein **Zauber-Bauernhof** rund um **Pflanzen & Tiere** (NMG): die ganze Kette
**„Vom Samen zum Brot"** (säen → giessen → ernten → mahlen → backen), Tierpflege am
Futtertrog und eine Lektion zur Nahrungskette — und er stützt sich, anders als die
übrigen Themen, auf vorhandene Mods: Er nutzt **Farming Redo** (Saat, Mehl, Brot) und
**Animalia** (Huhn, Kuh, Schaf …) direkt, sofern installiert, sonst eigene Pflanze &
Tiere — je mit einer Startausrüstung beim ersten Join. Vollständige
**Spielanleitungen** dazu (alle Elemente, Bedienung, Aufgaben & Ziele) stehen in
[`lernwelt_gluehpilz/ANLEITUNG.md`](lernwelt_gluehpilz/ANLEITUNG.md),
[`lernwelt_tiefsee/ANLEITUNG.md`](lernwelt_tiefsee/ANLEITUNG.md),
[`lernwelt_kosmo/ANLEITUNG.md`](lernwelt_kosmo/ANLEITUNG.md),
[`lernwelt_drachenhort/ANLEITUNG.md`](lernwelt_drachenhort/ANLEITUNG.md),
[`lernwelt_schrauber/ANLEITUNG.md`](lernwelt_schrauber/ANLEITUNG.md),
[`lernwelt_eisbaer/ANLEITUNG.md`](lernwelt_eisbaer/ANLEITUNG.md),
[`lernwelt_baumhaus/ANLEITUNG.md`](lernwelt_baumhaus/ANLEITUNG.md),
[`lernwelt_naschwerk/ANLEITUNG.md`](lernwelt_naschwerk/ANLEITUNG.md),
[`lernwelt_schatzinsel/ANLEITUNG.md`](lernwelt_schatzinsel/ANLEITUNG.md) und
[`lernwelt_sonnenhof/ANLEITUNG.md`](lernwelt_sonnenhof/ANLEITUNG.md).

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
