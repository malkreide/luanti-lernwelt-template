# Luanti Lernwelt Template

![Version](https://img.shields.io/badge/version-1.1.0-blue)
![License](https://img.shields.io/badge/license-MIT-green)
![Luanti](https://img.shields.io/badge/Luanti-5.x-orange)

> A reusable framework for child-friendly educational worlds in Luanti (Minetest) — swap names and textures, keep all the mechanics.

[🇩🇪 Deutsche Version](README.de.md)

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
- **Creature spawner** for friendly, rescuable land/water animals (works with `mobs_redo` *or* `mcl_mobs` — VoxeLibre / Mineclonia)
- **Per-world logbook** with creature profiles and personal rescue counters
- **Progress system**: ranks, HUD, auto-generated badge items, rescue sounds
- **Lehrplan-21 tagging** with a `/lernplan` overview for parents and teachers
- **Curriculum-agnostic**: ships with Lehrplan-21 (Swiss curriculum) as the default tag set — replace `lernwelt.fachbereiche` to use Common Core, the National Curriculum, or your own
- **Internationalized**: English source strings + translation files (`locale/*.tr`), German included; the in-game UI follows the client language
- **No textures required** — colours are generated via `[fill`; PNGs optional

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

## Usage / Quickstart

A complete theme is just one declarative table:

```lua
lernwelt.register_world({
    id    = "gluehpilz",
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
2. Change `name` in `mod.conf`
3. Edit `init.lua`: swap `id`, `title`, blocks, zones, creatures, ranks, tags
4. Optional: add your own PNG textures and reference them

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
├── lernwelt_beispiel/        # example theme: Gluehpilz-Wald
│   └── init.lua              # one declarative register_world{...}
└── tiefsee/                  # example theme: Tiefsee-Retter (underwater)
    └── init.lua              # register_world{...} + a custom submarine
```

Two themes ship as examples: **`lernwelt_beispiel`** (Gluehpilz-Wald) and
**`tiefsee`** (Tiefsee-Retter), the latter showing how a theme can add its own
extra content — a drivable submarine — on top of the engine.

## Translations

The engine's interface strings are written in English and translated via
`lernwelt/locale/lernwelt.<lang>.tr` (Luanti's translation system). German
(`de`) and French (`fr`) are included. To add a language, copy the template
`lernwelt/locale/lernwelt.tr` to `lernwelt.<lang>.tr` (e.g. `lernwelt.fr.tr`)
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
