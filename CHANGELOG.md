# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Second example theme `lernwelt_tiefsee` (Tiefsee-Retter): a brand-free
  underwater learning world built on the engine — coral blocks, station glass,
  four learning zones, eight rescuable sea animals, a Meeres-Logbuch, ranks and
  badges via one `register_world{...}` call, plus a self-contained drivable
  submarine ("Tauchkapsel") that demonstrates adding theme-specific content
  the engine does not cover
- `lernwelt_tiefsee` first-join **starter kit** (logbook, submarine, coral
  blocks and one spawn egg per sea animal) for immediate in-game testing,
  toggleable via the `lernwelt_tiefsee_starter_kit` setting
- `lernwelt_tiefsee` chat command `/tiefsee_teststation` (priv: `server`) that
  builds a small ready-made station — glass floor, the four learning boards and
  a Tauchkapsel — in front of the player
- Backwards-compatibility `register_alias` entries so existing builds survive
  the renames: old standalone `tiefsee:*` → `lernwelt_tiefsee:*` (blocks, items,
  spawn eggs, badges) and old example `gluehpilz:*` → `lernwelt_beispiel:*`
- `lernwelt_tiefsee/WELT-EINRICHTEN.md` — guide for creating a water-rich world,
  with ready-made mapgen configs ("flat sea" and "natural ocean") and setup steps

### Changed
- Renamed the theme folder/mod `tiefsee` → `lernwelt_tiefsee` (mod name now
  equals the world id, keeping all nodes/items in the `lernwelt_tiefsee:`
  namespace and following the `lernwelt_*` theme convention)
- `register_world` now defaults `def.id` to the calling mod name and asserts
  that an explicit `id` matches it, with a clear error message. This fixes a
  latent crash: a theme whose `id` differed from its mod name (e.g. the old
  example `id = "gluehpilz"` in mod `lernwelt_beispiel`) tried to register
  nodes/items in a foreign namespace, which strict Luanti builds reject
- Example theme `lernwelt_beispiel` now uses `id = "lernwelt_beispiel"`
  (was `"gluehpilz"`); the theme title stays "Gluehpilz-Wald". Note: nodes are
  now `lernwelt_beispiel:*` instead of `gluehpilz:*`, so blocks placed in an
  existing test world from the old version become unknown nodes
- `lernwelt/locale/lernwelt.tr` — translation template listing every engine
  source string (not loaded by Luanti; copy to `lernwelt.<lang>.tr`)
- `CONTRIBUTING.md` with a step-by-step guide for contributing translations
- `lernwelt/locale/lernwelt.fr.tr` — French translation (example/second locale)

## [1.2.0] - 2026-06-15

### Added
- Mob adapter (`api/mobs_adapter.lua`): the creature spawner now works with
  `mcl_mobs` (VoxeLibre / Mineclonia) in addition to `mobs_redo`, auto-detecting
  whichever mob API is present
- `mcl_mobs` added to `optional_depends` of both mods

### Changed
- `register_creatures` no longer hard-requires the `mobs` mod; it uses the new
  adapter and only skips animals when no mob API at all is available

### Fixed
- "Project Structure" tree in both READMEs now shows the correct repo root
  (`luanti-lernwelt-template/`)

## [1.1.0] - 2026-06-15

### Changed
- Engine code comments and source strings converted to English (international contributors)
- Engine UI strings moved to Luanti's translation system (`core.get_translator`)
- Default fallback rank names are now English (themes still define their own)

### Added
- `locale/lernwelt.de.tr` — full German translation of all engine UI strings
- README note: framework is curriculum-agnostic (Lehrplan-21 is the default tag set)

## [1.0.0] - 2026-06-14

### Added
- Engine mod `lernwelt` with declarative `register_world{...}` API
- Peaceful config module (runtime + recommended `minetest.conf` lines)
- Zone system with placeable learning boards and optional teleport
- Creature spawner with rescue mechanic, per-world logbook and counters
- Progress system: ranks, HUD, auto-generated badge items, sounds
- Lehrplan-21 tagging with `/lernplan` overview and `/lernwelt` status
- Colour-block generator (no PNG required, `[fill`-based)
- Example theme `lernwelt_beispiel` (Gluehpilz-Wald)
