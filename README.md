# Luanti Lernwelt Template

![Version](https://img.shields.io/badge/version-1.1.0-blue)
![License](https://img.shields.io/badge/license-MIT-green)
![Luanti](https://img.shields.io/badge/Luanti-5.x-orange)

> A reusable framework for child-friendly educational worlds in Luanti (Minetest) — swap names and textures, keep all the mechanics.

[🇩🇪 Deutsche Version](README.de.md)

> 🗺️ **Architecture & themes at a glance:** see the [visual guide](docs/ARCHITEKTUR.md) (in German, with diagrams).

## Overview

`lernwelt` is a Luanti engine mod that encapsulates everything a small,
curated learning world for pre-schoolers needs: a peaceful configuration
(no damage, no monsters, frozen daytime), a **zone system** with info
boards, a **creature spawner** with a rescue mechanic and logbook,
**progress** (ranks, HUD, badges) and **Lehrplan-21 tagging** (the Swiss
curriculum).

A theme author writes a single declarative `register_world{...}` call —
no further Lua required. Themes are interchangeable, so the same proven
scaffold can become a glowing-mushroom forest, a dragon sanctuary, a
robot workshop, and so on. This sidesteps copyright entirely: the
framework is theme-neutral, and themes use original names and textures.

## Features

- **Peaceful config** applied at runtime + copy-paste lines for `minetest.conf`
- **Zone system** with placeable "learning boards" (activity + curriculum + optional teleport)
- **Tasks on the learning boards** (optional): quizzes, pattern-matching and rescue goals with rewards
- **Creature spawner** for friendly, rescuable land/water animals (works with `mobs_redo` *or* `mcl_mobs` — VoxeLibre / Mineclonia)
- **Automatic water-animal spawning** near players (light, capped, can be turned off; `rare` creatures excluded)
- **Animal families**: a rescued parent brings its little ones along
- **Explorer camera** per world: photograph animals to discover them in the logbook (collecting)
- **Per-world logbook** with creature profiles, rescue counters and a "discovered" status
- **Progress system**: ranks, HUD, auto-generated badge items, rescue sounds
- **Lehrplan-21 tagging** with a `/lernplan` overview plus a personal `/lernfortschritt` report
- **Accessibility**: larger-text mode and easy mode (fewer quiz options)
- **Curriculum-agnostic**: ships with Lehrplan-21 (Swiss curriculum) as the default tag set — replace `lernwelt.fachbereiche` to use Common Core, the National Curriculum, or your own
- **Internationalized**: English source strings + translation files (`locale/*.tr`), German included; the in-game UI follows the client language
- **No textures required** — colours via `[fill`; **patterns** (layered `[fill`),
  **per-face textures** (`top`/`side`/`bottom`) and own **PNGs** optional

## Prerequisites

- Luanti / Minetest 5.x
- A base game, recommended: **Mineclonia** or **Minetest Game**
- A mob API for the living animals — optional. `mobs_redo` (Minetest Game) or `mcl_mobs` (built into VoxeLibre / Mineclonia); the engine auto-detects whichever is present

## Installation

```bash
# Copy both mods into your Luanti mods folder:
#   <luanti>/mods/lernwelt            (the engine)
#   <luanti>/mods/lernwelt_beispiel   (the example theme)
# Then enable them for your world in the "Select Mods" menu.
```

> 🪟🍎🐧 **Step-by-step (Windows, macOS, Linux):** see [INSTALL.md](INSTALL.md) (in German).

## Usage / Quickstart

A complete theme is just one declarative table:

```lua
lernwelt.register_world({
    id    = "gluehpilz",   -- must equal the mod name (folder / mod.conf); may be omitted
    title = "Gluehpilz-Wald",
    config    = { peaceful = true, damage = false, freeze_time = "day" },
    blocks    = { { suffix = "pilz_rot", name = "Roter Leuchtpilz", color = "#e74c3c", glow = 7 } },
    zones     = { { id = "wiese", title = "Bach-Wiese", activity = "Muster legen", lehrplan = { "MA.2" } } },
    creatures = { { id = "schnecke", name = "Schnecke", zone = "wiese", color = "#f39c12", speed = 0.3 } },
    ranks     = { { 0, "Frischling" }, { 10, "Forscher", "#2ecc71" } },
    logbook   = { title = "Forscher-Logbuch" },
})
```

In game:

- Right-click an animal → rescue it (counter, rank, sound)
- Right-click the logbook item → creature profiles + your counts
- Place and right-click a "learning board" node → activity + curriculum
- `/lernplan` → overview of all zones and their Lehrplan-21 links
- `/lernwelt` → status + recommended `minetest.conf` lines

## Make your own world

1. Copy `lernwelt_beispiel`, rename the folder (e.g. `lernwelt_drachenhort`)
2. Change `name` in `mod.conf` to that same folder name
3. Edit `init.lua`: set `id` to the **same** mod name (or omit `id` — it
   defaults to the mod name), then swap `title`, blocks, zones, creatures,
   ranks and tags
4. Optional: add your own PNG textures and reference them

> **Why `id` must equal the mod name:** every block, item and animal is
> registered in the `<id>:` namespace, and Luanti only lets a mod register
> items in its own namespace. The engine enforces this and fails early with a
> clear message if they differ.

## Project Structure

```
luanti-lernwelt-template/
├── lernwelt/                 # engine mod (the reusable framework)
│   ├── init.lua              # loads the API modules
│   ├── settingtypes.txt      # HUD toggle
│   ├── locale/
│   │   └── lernwelt.de.tr     # German translation (add lernwelt.<lang>.tr for more)
│   └── api/
│       ├── config.lua        # peaceful config + /lernwelt
│       ├── lehrplan.lua      # Lehrplan-21 tagging + /lernplan
│       ├── blocks.lua        # colour-block generator
│       ├── zones.lua         # zones + learning boards
│       ├── progress.lua      # ranks, HUD, badges, reward()
│       ├── mobs_adapter.lua  # mobs_redo / mcl_mobs abstraction
│       ├── creatures.lua     # spawner, rescue, logbook
│       └── register.lua      # register_world()
├── lernwelt_beispiel/        # minimal copy-me template (titled Gluehpilz-Wald)
│   └── init.lua              # one declarative register_world{...}
├── lernwelt_gluehpilz/       # example theme: Gluehpilz-Wald (cosy first world)
│   ├── init.lua              # register_world{...} + glow-beetle + day/night mushrooms
│   └── settingtypes.txt      # starter-kit toggle
├── lernwelt_tiefsee/         # example theme: Tiefsee-Retter (underwater)
│   ├── init.lua              # register_world{...} + submarine + starter kit
│   └── settingtypes.txt      # starter-kit toggle
├── lernwelt_kosmo/           # example theme: Kosmo-Station (outer space)
│   ├── init.lua              # register_world{...} + space glider + moon gravity
│   └── settingtypes.txt      # starter-kit toggle
├── lernwelt_drachenhort/     # example theme: Drachenhort (friendly dragons)
│   ├── init.lua              # register_world{...} + baby-dragon raising + flying mount
│   └── settingtypes.txt      # starter-kit toggle
├── lernwelt_schrauber/       # example theme: Schrauber-Werkstatt (robots & logic)
│   ├── init.lua              # register_world{...} + switch/lamp/door logic + robot assembly
│   └── settingtypes.txt      # starter-kit toggle
├── lernwelt_eisbaer/         # example theme: Eisbaer-Bucht (polar world, cold animals)
│   ├── init.lua              # register_world{...} + sled + colour-cycling aurora + feeding
│   └── settingtypes.txt      # starter-kit toggle
├── lernwelt_baumhaus/        # example theme: Baumhaus-Forscher (jungle, spatial orientation)
│   ├── init.lua              # register_world{...} + picture-hint frames + treasure hunt + compass
│   └── settingtypes.txt      # starter-kit toggle
├── lernwelt_naschwerk/       # example theme: Naschwerk-Tal (sweets / early maths)
│   ├── init.lua              # register_world{...} + counting game + candy cart + colour-cycling lolli
│   └── settingtypes.txt      # starter-kit toggle
├── lernwelt_schatzinsel/     # example theme: Schatzinsel (friendly pirates, maps & counting)
│   ├── init.lua              # register_world{...} + compass + map + signpost treasure hunt + coin counting + raft
│   └── settingtypes.txt      # starter-kit toggle
├── lernwelt_sonnenhof/       # example theme: Sonnenhof (magic farm; uses Farming Redo + Animalia)
│   ├── init.lua              # register_world{...} + seed-to-bread + watering can + magic mill + trough
│   └── settingtypes.txt      # starter-kit toggle
├── lernwelt_summgarten/      # example theme: Summ-Garten (bees & flowers; NMG + geometry)
│   ├── init.lua              # register_world{...} + pollen brush + honey extractor + honeycomb hexagons + honey counting
│   └── settingtypes.txt      # starter-kit toggle
├── lernwelt_saurier/         # example theme: Saurier-Forscher (friendly herbivore dinos; NMG + sizes)
│   ├── init.lua              # register_world{...} + fossil digging + jeep + egg hatching + size parade
│   └── settingtypes.txt      # starter-kit toggle
├── lernwelt_bimmelbahn/      # example theme: Bimmelbahn-Land (little trains, colourful villages; MI sequence)
│   ├── init.lua              # register_world{...} + route order game + switch/signal demo + drivable train
│   └── settingtypes.txt      # starter-kit toggle
└── lernwelt_himmelsdorf/     # example theme: Himmelsdorf (cloud city; NMG weather & spatial orientation)
    ├── init.lua              # register_world{...} + hot-air balloon + weather station + colour-cycling rainbow + altimeter
    └── settingtypes.txt      # starter-kit toggle
```

The repo ships a minimal copy-me skeleton, **`lernwelt_beispiel`**, plus fourteen
fully built example themes: **`lernwelt_gluehpilz`** (Gluehpilz-Wald),
**`lernwelt_tiefsee`** (Tiefsee-Retter), **`lernwelt_kosmo`** (Kosmo-Station),
**`lernwelt_drachenhort`** (Drachenhort), **`lernwelt_schrauber`**
(Schrauber-Werkstatt), **`lernwelt_eisbaer`** (Eisbaer-Bucht),
**`lernwelt_baumhaus`** (Baumhaus-Forscher), **`lernwelt_naschwerk`**
(Naschwerk-Tal), **`lernwelt_schatzinsel`** (Schatzinsel),
**`lernwelt_sonnenhof`** (Sonnenhof), **`lernwelt_summgarten`** (Summ-Garten),
**`lernwelt_saurier`** (Saurier-Forscher), **`lernwelt_bimmelbahn`**
(Bimmelbahn-Land) and **`lernwelt_himmelsdorf`** (Himmelsdorf).
They show how a theme can add its own extra content on top of the engine —
Gluehpilz-Wald a rideable glow-beetle plus **day/night mushrooms** (a child-controlled
time-of-day cycle), Tiefsee a drivable submarine, Kosmo a space glider plus
**moon-gravity jump/physics blocks**, Drachenhort **raising a baby dragon**
(hatch an egg, then patiently feed & tame it — responsibility & patience) plus a
**flying dragon mount**, Schrauber-Werkstatt a self-contained **switch → wire →
lamp → door logic system** (a gentle bridge to Mesecons) plus **assembling a robot in
the right order** (an algorithm), and Eisbaer-Bucht a drivable **sled**, a glowing
**aurora** that slowly cycles colour, and a feeding station for **cold animals &
their habitats** (NMG.2), and Baumhaus-Forscher a **jungle treehouse** built around
**spatial orientation** (NMG.3): the storeys of the forest (up/down via climbable
vines & rope ladders), a **treasure hunt with picture hints in item frames**
(Bilderrahmen) and an **explorer compass**, and Naschwerk-Tal an extremely colourful
**candy valley** built around **early maths** (MA.1): an interactive **counting game**
(Zähl-Naschtisch — "how many bonbons?"), **pattern boards** (red–yellow–red …), a
drivable **candy cart** and a glowing **rainbow lolli** that slowly cycles colour,
and Schatzinsel a friendly-pirate **treasure island** built around **spatial
orientation** (NMG.3 / MA.3) and **counting** (MA.1): a **treasure compass**
(which way you face, up/down, coins counted), a **treasure map** that reads the way to
the next clue, a **signpost treasure hunt** with picture & arrow hints across three
zones (island, dripstone cave, lagoon), **gold-coin collecting & counting** with number
blocks 0–9, and a two-seat **raft** — a ship-and-dock base you build with one command,
and Sonnenhof a **magic farm** built around **plants & animals** (NMG): the whole
**"from seed to bread"** chain (sow → water → harvest → grind → bake), animal care
at a feeding trough and a food-chain lesson — and, unlike the other themes, it leans
on existing mods, using **Farming Redo** (seeds, flour, bread) and **Animalia**
(chicken, cow, sheep …) directly when installed, with its own fallback crop & animals
otherwise, and Summ-Garten a **bees-and-flowers garden** that **connects NMG with
geometry**: making **pollination** tangible (a **pollen brush** pollinates flowers and
blossoms so a blossom grows into a **fruit**), recognising and continuing the **hexagon
pattern** of the **honeycomb** (MA.2 – form & space), naming the **colours** of the
flowers and **counting honey drops** (MA.1) at a refilling comb — plus a **honey
extractor** (nectar → honey) and three zones (flower meadow, orchard, honey store) —
together with a first-join starter kit, and Saurier-Forscher a friendly **dinosaur
research station** built around **science** (NMG) and **comparing sizes** (MA /
Grössen): friendly **herbivore dinosaurs** of very different sizes across three zones
(valley, fossil dig site, nesting place), **digging up fossils** hidden in the sand
(the "Ausgraben" heart — bones, teeth, ammonites, petrified eggs with milestones),
**classifying** dinos (plant-eater? long-neck, horned, plated, duck-bill …),
**learning dino names** with letter blocks, a **size parade** that lines the dinos up
small → big, **hatching dino eggs** at the nesting place and a two-seat **research
jeep**, and Bimmelbahn-Land a **little-train world** built around **media & informatics**
(MI — sequencing) and **colours** (BG): a central **Hauptbahnhof** connected by rails to
four **colourful villages** (red, yellow, blue, green), a **route-order task** (the heart
— the timetable desk hands you a route like *red → blue → yellow* and you must stop at the
colour station signs **in exactly that order**), a gently simplified **switch & signal
logic** (a toggleable Weiche and a red/green Signal, with a self-running **demo train**
that stops at red and goes at green — a soft bridge to Mesecons/Basic-Trains "if–then"),
**colour matching**, a two-seat **drivable Bimmelbahn** that whistles and steams and a
**wagon parade** that lines up colourful wagons in order, and Himmelsdorf a **cloud
city** on a floating island built around **weather & spatial orientation** (NMG): a
hands-on **weather station** that cycles the sky through **sun → clouds → rain →
thunderstorm → rainbow**, a glowing **rainbow** block that slowly cycles the **seven
rainbow colours**, a real **hot-air balloon** you fly (warm air rises — flight physics)
and an **altimeter** plus up/down quizzes for **oben/unten** (spatial orientation),
across three zones (rainbow bridge, cloud fields, balloon harbour). Full
**player guides** (every element, controls, tasks & goals) live in
[`lernwelt_gluehpilz/ANLEITUNG.md`](lernwelt_gluehpilz/ANLEITUNG.md),
[`lernwelt_tiefsee/ANLEITUNG.md`](lernwelt_tiefsee/ANLEITUNG.md),
[`lernwelt_kosmo/ANLEITUNG.md`](lernwelt_kosmo/ANLEITUNG.md),
[`lernwelt_drachenhort/ANLEITUNG.md`](lernwelt_drachenhort/ANLEITUNG.md),
[`lernwelt_schrauber/ANLEITUNG.md`](lernwelt_schrauber/ANLEITUNG.md),
[`lernwelt_eisbaer/ANLEITUNG.md`](lernwelt_eisbaer/ANLEITUNG.md),
[`lernwelt_baumhaus/ANLEITUNG.md`](lernwelt_baumhaus/ANLEITUNG.md),
[`lernwelt_naschwerk/ANLEITUNG.md`](lernwelt_naschwerk/ANLEITUNG.md),
[`lernwelt_schatzinsel/ANLEITUNG.md`](lernwelt_schatzinsel/ANLEITUNG.md),
[`lernwelt_sonnenhof/ANLEITUNG.md`](lernwelt_sonnenhof/ANLEITUNG.md),
[`lernwelt_summgarten/ANLEITUNG.md`](lernwelt_summgarten/ANLEITUNG.md),
[`lernwelt_saurier/ANLEITUNG.md`](lernwelt_saurier/ANLEITUNG.md),
[`lernwelt_bimmelbahn/ANLEITUNG.md`](lernwelt_bimmelbahn/ANLEITUNG.md) and
[`lernwelt_himmelsdorf/ANLEITUNG.md`](lernwelt_himmelsdorf/ANLEITUNG.md).

## Translations

The engine's interface strings are written in English and translated via
`lernwelt/locale/lernwelt.<lang>.tr` (Luanti's translation system). German
(`de`) and French (`fr`) are included. To add a language, copy the template
`lernwelt/locale/template.txt` to `lernwelt.<lang>.tr` (e.g. `lernwelt.fr.tr`)
and fill in the right-hand side — see [CONTRIBUTING.md](CONTRIBUTING.md) for
the full guide. Theme **content** (animal names, activities) is authored
directly in the theme and stays in whatever language the theme author chooses.

## Changelog

See [CHANGELOG.md](CHANGELOG.md)

## License

MIT License — see [LICENSE](LICENSE). Code is theme-neutral; each theme
is responsible for using original, non-infringing names and assets.

## Author

Hayal Oezkan · [malkreide](https://github.com/malkreide)
