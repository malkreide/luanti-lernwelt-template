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

## Theme worlds

The repo ships a minimal copy-me skeleton (`lernwelt_beispiel`) plus **fourteen**
fully built example themes. Each world has its own README, a complete player
guide (`ANLEITUNG.md`), a one-page kids' sheet (`KINDER-KURZ.md`), an English
guide (`GUIDE.md`) and a setup note (`WELT-EINRICHTEN.md`).

Every theme's README opens with **Lehrplan-21 badges** that show, at a glance,
which competency areas it teaches — e.g.
![Mathematik](https://img.shields.io/badge/Mathematik-MA.1,%20MA.2-1565c0)
![NMG](https://img.shields.io/badge/Natur,%20Mensch,%20Gesellschaft-NMG.2-2e7d32)
![Medien und Informatik](https://img.shields.io/badge/Medien%20und%20Informatik-MI.1-6a1b9a)
— colour-coded per subject, with the exact tags from the world's learning boards.

| World | Theme | Learning focus | Guide |
|---|---|---|---|
| [Glühpilz-Wald 🍄](lernwelt_gluehpilz/README.md) | cosy mushroom realm (ideal first world) | sorting, early maths, day/night cycle | [ANLEITUNG](lernwelt_gluehpilz/ANLEITUNG.md) · [EN](lernwelt_gluehpilz/GUIDE.md) |
| [Tiefsee-Retter 🌊](lernwelt_tiefsee/README.md) | underwater rescue | rescuing animals, submarine | [ANLEITUNG](lernwelt_tiefsee/ANLEITUNG.md) · [EN](lernwelt_tiefsee/GUIDE.md) |
| [Kosmo-Station 🚀](lernwelt_kosmo/README.md) | outer-space station | moon gravity, physics | [ANLEITUNG](lernwelt_kosmo/ANLEITUNG.md) · [EN](lernwelt_kosmo/GUIDE.md) |
| [Drachenhort 🐉](lernwelt_drachenhort/README.md) | friendly dragons | responsibility & patience (raising a baby dragon) | [ANLEITUNG](lernwelt_drachenhort/ANLEITUNG.md) · [EN](lernwelt_drachenhort/GUIDE.md) |
| [Schrauber-Werkstatt 🔧](lernwelt_schrauber/README.md) | robots & logic | switch → lamp → door logic, algorithms | [ANLEITUNG](lernwelt_schrauber/ANLEITUNG.md) · [EN](lernwelt_schrauber/GUIDE.md) |
| [Eisbär-Bucht 🐻‍❄️](lernwelt_eisbaer/README.md) | polar world | cold animals & habitats (NMG.2) | [ANLEITUNG](lernwelt_eisbaer/ANLEITUNG.md) · [EN](lernwelt_eisbaer/GUIDE.md) |
| [Baumhaus-Forscher 🌳](lernwelt_baumhaus/README.md) | jungle treehouse | spatial orientation (NMG.3) | [ANLEITUNG](lernwelt_baumhaus/ANLEITUNG.md) · [EN](lernwelt_baumhaus/GUIDE.md) |
| [Naschwerk-Tal 🍬](lernwelt_naschwerk/README.md) | candy valley | early maths / counting (MA.1) | [ANLEITUNG](lernwelt_naschwerk/ANLEITUNG.md) · [EN](lernwelt_naschwerk/GUIDE.md) |
| [Schatzinsel 🏴‍☠️](lernwelt_schatzinsel/README.md) | friendly-pirate treasure island | spatial orientation & counting (NMG.3 / MA.1) | [ANLEITUNG](lernwelt_schatzinsel/ANLEITUNG.md) · [EN](lernwelt_schatzinsel/GUIDE.md) |
| [Sonnenhof 🌻](lernwelt_sonnenhof/README.md) | magic farm (uses Farming Redo + Animalia) | plants & animals (NMG), seed-to-bread | [ANLEITUNG](lernwelt_sonnenhof/ANLEITUNG.md) · [EN](lernwelt_sonnenhof/GUIDE.md) |
| [Summ-Garten 🐝](lernwelt_summgarten/README.md) | bees & flowers | NMG + geometry (MA.2) | [ANLEITUNG](lernwelt_summgarten/ANLEITUNG.md) · [EN](lernwelt_summgarten/GUIDE.md) |
| [Saurier-Forscher 🦕](lernwelt_saurier/README.md) | dinosaur research station | science (NMG) & comparing sizes (MA) | [ANLEITUNG](lernwelt_saurier/ANLEITUNG.md) · [EN](lernwelt_saurier/GUIDE.md) |
| [Bimmelbahn-Land 🚂](lernwelt_bimmelbahn/README.md) | little-train land | media & informatics (MI sequencing), colours (BG) | [ANLEITUNG](lernwelt_bimmelbahn/ANLEITUNG.md) · [EN](lernwelt_bimmelbahn/GUIDE.md) |
| [Himmelsdorf 🌈](lernwelt_himmelsdorf/README.md) | cloud city | weather & spatial orientation (NMG) | [ANLEITUNG](lernwelt_himmelsdorf/ANLEITUNG.md) · [EN](lernwelt_himmelsdorf/GUIDE.md) |

> 💡 **Got an idea for a new world?** Suggest one with the guided form:
> [**New issue → 💡 Themenwelt vorschlagen / Suggest a theme world**](https://github.com/malkreide/luanti-lernwelt-template/issues/new/choose).
> You only fill in what you already know — no coding needed.

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

Everything in this project is one of two things: **the engine** (the shared
machinery that every world reuses) or **a theme** (one finished, playable
world). So you can read the whole repo as *one engine plus many
interchangeable worlds*.

```
luanti-lernwelt-template/
│
├── lernwelt/            ← THE ENGINE — all shared mechanics live here.
│                          You enable it once and normally never edit it.
│
├── lernwelt_beispiel/   ← An empty starter world. Copy this folder to
│                          begin your own theme.
│
└── lernwelt_*/          ← One folder per finished world (14 of them, e.g.
                           lernwelt_gluehpilz, lernwelt_drachenhort …).
                           The full list is the “Theme worlds” table above.
```

**The engine — `lernwelt/`**
This is the reusable part that gives every world the same features: the
peaceful setup, the learning boards, the animals and logbook, the ranks and
badges, and the Lehrplan-21 tags. A theme simply switches these on — the
engine code itself is never touched.

**A theme — e.g. `lernwelt_gluehpilz/`**
This is one playable world. Every theme folder is built the same way, so once
you understand one, you understand them all:

| File | What it is |
|---|---|
| `init.lua` | **The world itself** — one `register_world{…}` description, plus any extras the engine doesn't cover |
| `mod.conf` | Luanti's mod card (name + dependencies) |
| `README.md` | Short description of the world |
| `ANLEITUNG.md` | Full player guide (German) |
| `GUIDE.md` | Full player guide (English) |
| `KINDER-KURZ.md` | One-page sheet for children |
| `WELT-EINRICHTEN.md` | How to set the world up in Luanti |

> 💡 **In short:** you only ever *play* the themes and *copy* one to make
> your own. The engine is the shared toolbox underneath — you don't have to
> understand its inner files to use it.

<details>
<summary>Inside the engine (only if you're curious)</summary>

The `lernwelt/` engine keeps its work in small modules under `lernwelt/api/`:

| Module | Responsibility |
|---|---|
| `config.lua` | peaceful config + `/lernwelt` |
| `lehrplan.lua` | Lehrplan-21 tagging + `/lernplan` |
| `blocks.lua` | colour-block generator |
| `zones.lua` | zones + learning boards |
| `progress.lua` | ranks, HUD, badges, rewards |
| `mobs_adapter.lua` | `mobs_redo` / `mcl_mobs` abstraction |
| `creatures.lua` | spawner, rescue, logbook |
| `register.lua` | the `register_world()` entry point |

Translations live in `lernwelt/locale/` as `lernwelt.<lang>.tr`.

</details>

## Translations

The engine's interface strings are written in English and translated via
`lernwelt/locale/lernwelt.<lang>.tr` (Luanti's translation system). German
(`de`) and French (`fr`) are included. To add a language, copy the template
`lernwelt/locale/template.txt` to `lernwelt.<lang>.tr` (e.g. `lernwelt.fr.tr`)
and fill in the right-hand side — see [CONTRIBUTING.md](CONTRIBUTING.md) for
the full guide. Theme **content** (animal names, activities) is authored
directly in the theme and stays in whatever language the theme author chooses.

## Contributing

Contributions are welcome — translations, bug fixes, docs and new example
themes. See [CONTRIBUTING.md](CONTRIBUTING.md) to get started. Everyone taking
part is expected to follow our [Code of Conduct](CODE_OF_CONDUCT.md).

## Changelog

See [CHANGELOG.md](CHANGELOG.md)

## License

MIT License — see [LICENSE](LICENSE). Code is theme-neutral; each theme
is responsible for using original, non-infringing names and assets.

## Author

Hayal Oezkan · [malkreide](https://github.com/malkreide)
