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
└── lernwelt_naschwerk/       # example theme: Naschwerk-Tal (sweets / early maths)
    ├── init.lua              # register_world{...} + counting game + candy cart + colour-cycling lolli
    └── settingtypes.txt      # starter-kit toggle
```

The repo ships a minimal copy-me skeleton, **`lernwelt_beispiel`**, plus eight
fully built example themes: **`lernwelt_gluehpilz`** (Gluehpilz-Wald),
**`lernwelt_tiefsee`** (Tiefsee-Retter), **`lernwelt_kosmo`** (Kosmo-Station),
**`lernwelt_drachenhort`** (Drachenhort), **`lernwelt_schrauber`**
(Schrauber-Werkstatt), **`lernwelt_eisbaer`** (Eisbaer-Bucht),
**`lernwelt_baumhaus`** (Baumhaus-Forscher) and **`lernwelt_naschwerk`**
(Naschwerk-Tal).
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
drivable **candy cart** and a glowing **rainbow lolli** that slowly cycles colour —
together with a first-join starter kit. Full
**player guides** (every element, controls, tasks & goals) live in
[`lernwelt_gluehpilz/ANLEITUNG.md`](lernwelt_gluehpilz/ANLEITUNG.md),
[`lernwelt_tiefsee/ANLEITUNG.md`](lernwelt_tiefsee/ANLEITUNG.md),
[`lernwelt_kosmo/ANLEITUNG.md`](lernwelt_kosmo/ANLEITUNG.md),
[`lernwelt_drachenhort/ANLEITUNG.md`](lernwelt_drachenhort/ANLEITUNG.md),
[`lernwelt_schrauber/ANLEITUNG.md`](lernwelt_schrauber/ANLEITUNG.md),
[`lernwelt_eisbaer/ANLEITUNG.md`](lernwelt_eisbaer/ANLEITUNG.md),
[`lernwelt_baumhaus/ANLEITUNG.md`](lernwelt_baumhaus/ANLEITUNG.md) and
[`lernwelt_naschwerk/ANLEITUNG.md`](lernwelt_naschwerk/ANLEITUNG.md).

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
