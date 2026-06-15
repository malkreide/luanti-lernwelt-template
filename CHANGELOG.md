# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Mob adapter (`api/mobs_adapter.lua`): the creature spawner now works with
  `mcl_mobs` (VoxeLibre / Mineclonia) in addition to `mobs_redo`, auto-detecting
  whichever mob API is present
- `mcl_mobs` added to `optional_depends` of both mods

### Changed
- `register_creatures` no longer hard-requires the `mobs` mod; it uses the new
  adapter and only skips animals when no mob API at all is available

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
