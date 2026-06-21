# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- **New example theme `lernwelt_sonnenhof` (Sonnenhof, magic farm / plants & animals):**
  a brand-free farm learning world built on the engine. Its base is a **Scheune** (barn) and it
  has three learning zones — **Felder** (fields), **Tiergehege** (animal pen) and **Mühle**
  (mill). The learning focus is **NMG** (Lehrplan 21: **NMG.2** plants & animals, **NMG.3** from
  seed to bread / origin of food), plus animal care, the food chain, counting (MA.1) and
  **patience** (EZ). Unlike the other themes — which build everything themselves — Sonnenhof is
  designed to **need very little custom content** by using existing mods directly: when
  **Farming Redo** (`farming`) is installed the **Zaubermühle** grinds real `farming:wheat` to
  `farming:flour` and bakes `farming:bread`, the **Zauber-Giesskanne** grows real Farming-Redo
  crops, and the starter kit adds real seeds; when **Animalia** (`animalia`) is installed the
  starter kit adds real animal spawn eggs and the **Futtertrog** pets nearby Animalia mobs. It
  **still works without them**: it ships its own small **Weizen** crop (seed → 4 stages →
  harvest) and 13 peaceful, helpable farm animals via the engine (chicken, cow, sheep, pig,
  goat, duck, donkey, farm cat, farm dog, bee, field mouse, stork and a rare, glowing **Goldenes
  Glückshuhn**). Signature theme extras (the engine cannot express these): the whole
  **"vom Samen zum Brot"** chain (sow → water → harvest → grind → bake); a **Zauber-Giesskanne**
  that advances any growing crop nearby (own + Farming-Redo); a **Zaubermühle** (grain → flour →
  bread, with milestones); and a **Futtertrog** for **Tierpflege** (feeds all nearby animals,
  own + Animalia). Watering can, mill, trough and the wheat field all work **even without a mob
  API**. ~12 declarative farm blocks (barn boards, timber frame, tiled roof, beam, hay bale,
  straw floor, tilled soil, flower meadow, cobbled path, pasture fence, flour sack, glowing barn
  lantern) plus sunflowers, a creature land spawner (the duck auto-spawns in water via the
  engine), ambient farm sounds, a first-join starter kit, and commands
  (`/sonnenhof_scheune` builds the signature **barn farm** base, `/sonnenhof_teststation`). Full
  DE/EN guides (`ANLEITUNG.md`, `GUIDE.md`, `KINDER-KURZ.md`, `WELT-EINRICHTEN.md`)
- **New example theme `lernwelt_naschwerk` (Naschwerk-Tal, sweets world / early maths):**
  a brand-free, extremely colourful candy learning world built on the engine. Its base is a
  **Lebkuchenhaus** (gingerbread house) and it has three learning zones — **Schoko-Fluss**
  (chocolate river), **Lolli-Wald** (lollipop forest) and **Gummi-Hügel** (gummy hills). The
  learning focus is **early maths** (Lehrplan 21: **MA.1** — grasping & counting quantities)
  plus **patterns** (red–yellow–red …, MA.2) and **colours** (BG.1). Twelve peaceful, helpable
  candy creatures (chocolate fish, marshmallow swan, cookie turtle, fizzy jellyfish,
  cotton-candy sheep, lollipop bird, candy rabbit, caramel squirrel, gummy bear, licorice
  snail, sugar mouse and a rare, glowing **Regenbogen-Lolli-Fee**), each shown with its zone
  in the logbook. Signature theme extras (the engine cannot express these): an interactive
  **Zähl-Naschtisch** (counting game — "how many bonbons?" with milestones, the MA.1 heart);
  a glowing **Regenbogen-Lolli** that slowly cycles colour (red → orange → yellow → green →
  blue → violet); a drivable **Naschwagen** (candy cart that sprays colourful sprinkles,
  two-seater); a **Naschschale** (candy bowl fed with bonbons, caring counter); and
  **Lollis pflanzen** (saplings that grow into random colourful candy blocks). Counting game,
  rainbow lolli, candy cart, bowl and lollis all work **even without a mob API**. Board tasks
  focus on counting ("2 and 1 more = ?"), colours and copying patterns (red-yellow-red). ~24
  declarative candy blocks (gingerbread & bricks, icing, milk/white chocolate, cookie, waffle,
  cotton candy, licorice, warm caramel, translucent gummy blocks, bright drops in four colours
  for patterns, candy cane, striped bonbon, lolli, glowing candy lamp, per-face candy box), a
  creature land spawner (water animals auto-spawn via the engine), letter blocks A–Z, ambient
  sounds, a first-join starter kit, and commands (`/naschwerk_lebkuchenhaus` builds the
  signature **gingerbread house** base, `/naschwerk_teststation`). Full DE/EN guides
  (`ANLEITUNG.md`, `GUIDE.md`, `KINDER-KURZ.md`, `WELT-EINRICHTEN.md`)
- **New example theme `lernwelt_baumhaus` (Baumhaus-Forscher, jungle treehouse /
  spatial orientation):** a brand-free jungle learning world built on the engine. Its base
  is a big **Baumhaus** (treehouse) and it has three learning zones that double as the
  **storeys of the forest** — **Blätterdach** (canopy, "up"), **Fluss** (river) and
  **Alte Ruinen** (old ruins). The learning focus is **spatial orientation** (Lehrplan 21:
  **NMG.3** — up/down, compass directions, following a plan) plus discovering animals: 14
  peaceful, helpable jungle animals (parrot, monkey, sloth, toucan, jungle butterfly, tree
  frog, fish, turtle, heron, dragonfly, gecko, bat, rhino beetle and a rare **Goldener
  Jaguar**), each shown with its habitat in the logbook. Signature theme extras (the engine
  cannot express these): **Bilderrahmen** (picture-hint item frames) that show a picture —
  leaf, water drop, stone, paw, treasure or a direction arrow — which children read as a
  hint (right-click to cycle the picture, sneak+right-click to choose one); a
  **Schnitzeljagd** (`/baumhaus_schnitzeljagd`) that lays out a chain of picture-hint frames
  with real directions (incl. one up high = "oben") ending at a **treasure chest** with
  milestone titles; a **Forscher-Kompass** that reports which way you face (N/O/S/W), how
  high you are (which forest storey) and where the nearest hint is; climbable **Lianen** and
  **Strickleitern** for hands-on up/down; and a rideable **Reit-Papagei** that flies up into
  the canopy (two-seater). Frames, treasure hunt, compass and climbing work **even without a
  mob API**. Board tasks focus on up/down, who swims, reading arrows and a **leaves light→dark
  pattern**. ~22 declarative jungle blocks (four leaf shades, bark trunk, planks, walls,
  glass, bridge, river & ruin stone, gold), an animal land spawner (water animals auto-spawn
  via the engine), drifting leaves, ambient sounds, a first-join starter kit, and commands
  (`/baumhaus_bauen` builds the signature **treehouse** base, `/baumhaus_schnitzeljagd`,
  `/baumhaus_teststation`). Full DE/EN guides (`ANLEITUNG.md`, `GUIDE.md`, `KINDER-KURZ.md`,
  `WELT-EINRICHTEN.md`)
- **New example theme `lernwelt_eisbaer` (Eisbär-Bucht, polar world / cold animals):**
  a brand-free polar learning world built on the engine. Its base is an **Iglu/Eispalast**
  and it has three learning zones — **Gefrorener See** (frozen lake), **Schneewald** (snow
  forest) and **Polarlicht-Höhle** (aurora cave). The learning focus is **cold animals & their
  habitats** (Lehrplan 21: **NMG.2 Tiere & Lebensräume**) plus **blue-white patterns**: twelve
  peaceful, helpable animals (penguin, seal, walrus, beluga, narwhal, snow hare, arctic fox,
  reindeer, snowy owl, polar bear, aurora fox and a rare glowing **Polarlicht-Bär**), each shown
  with its **habitat** in the logbook. Signature theme extras (the engine cannot express these):
  a drivable **Schlitten** (sled that glides over snow & ice, two-seater); a self-contained
  **Polarlicht** (aurora) made of nodes that **slowly cycle colour** (blau → türkis → grün →
  violett → weiss) for a gentle colour/pattern lesson; a **Futterstelle** + **Fisch** feeding
  mini-game with a caring counter (Tier-Freund → Polar-Pfleger → Kälte-Kümmerer); and
  **Eisblumen** saplings that grow into random **blue-white pattern blocks**. Sled, aurora,
  feeding and ice flowers work **even without a mob API**. Board tasks focus on **animals &
  habitats**, **blue-white pattern copying** and help goals. ~16 declarative snow/ice/pattern
  blocks (snow, pack/blue/clear ice, igloo bricks, five blue-white patterns, glowing ice
  crystal, snowy rock, a warm campfire, a per-face supply crate), letter blocks A–Z, an animal
  land spawner (water animals auto-spawn in water via the engine), ambient sounds, a first-join
  starter kit, and commands (`/eisbaer_eispalast` builds the signature **ice palace** base,
  `/eisbaer_iglu`, `/eisbaer_teststation`). Full DE/EN guides (`ANLEITUNG.md`, `GUIDE.md`,
  `KINDER-KURZ.md`, `WELT-EINRICHTEN.md`)
- **New example theme `lernwelt_schrauber` (Schrauber-Werkstatt, robots & simple
  logic):** a brand-free tinkerer's workshop built on the engine. Three learning zones —
  **Fließband** (conveyor), **Energieraum** and **Recyclinghof**. Its signature learning
  feature is a self-contained **logic system** (the direct **bridge to Mesecons**):
  wire up **Schalter → Leitung → Lampe → Tür** and watch cause produce effect ("wenn-dann")
  — a connected wire network is powered as soon as any switch/button on it is on, then every
  lamp lights, every door opens and the wire glows. If the optional **`mesecons`** mod is
  installed, the switch/button also act as real Mesecons receptors and the lamp/door as real
  effectors, so they interoperate with real Mesecons wire; without Mesecons the mini-logic
  runs on its own. A second signature feature, **assembling a robot in the right order**
  (Beine → Körper → Arme → Kopf — a wrong part is refused with a hint, so the **order is the
  algorithm**); the finished robot powers on, glows and follows its builder. A **Fließband**
  (conveyor) pushes players and objects in its arrow direction (cause & effect to stand on),
  and a **Recycler** + scrap heaps turn **Schrott** into new robot parts (Materialkreislauf).
  Logic, robot assembly, conveyor and recycler are the theme's own code and work **even
  without a mob API**. Board tasks focus on **cause & effect**, **simple if-then logic** and
  **sequencing/algorithms** (Lehrplan 21: Medien & Informatik — Informatik-Grundlagen). Ten
  peaceful, repairable robots (with families and a rare **Meisterbot**), ~13 declarative
  workshop blocks (workbench, steel/diamond plate, gear & bolt blocks, hazard stripes, glowing
  energy block, robot sheet metal), letter blocks A–Z, a robot land spawner, ambient sounds, a
  first-join starter kit, and commands (`/schrauber_werkstatt` builds the signature **workshop**
  base, `/schrauber_logik`, `/schrauber_teststation`, `/schrauber_roboter`). Full DE/EN guides
  (`ANLEITUNG.md`, `GUIDE.md`, `KINDER-KURZ.md`, `WELT-EINRICHTEN.md`)
- **New example theme `lernwelt_drachenhort` (Drachenhort, friendly dragons):** a
  brand-free dragon world built on the engine. Three learning zones — **Drachenberg**
  (mountain), **Lavafreier Krater** (a warm but completely safe, lava-free crater with
  harmless glowing "kalte Lava") and **Himmelsinseln** (sky islands). Its signature
  learning feature is **raising a baby dragon** (responsibility & patience): place a
  warm **Brut-Ei**, it **hatches** into a baby dragon, then feed it again and again with
  **Drachenfutter** — with a patience cooldown ("still full, be patient") — until, after
  several patient feedings, it is **tamed** (Animalia/`mobs_redo`-style tame-by-feeding,
  with an owner) and gently **follows** its child. Baby dragons, hatching eggs and feeding
  are the theme's own code and work **even without a mob API**. Board tasks focus on
  **counting eggs** (MA.1) and **matching colours** (MA.2) plus caring/patience (NMG);
  colourful **counting eggs** (`ei_rot/blau/gruen/gelb/lila`) can be laid out and counted.
  Ten peaceful, befriendable dragons (with families and a rare **Sternendrache**), a
  **flying Reitdrache** mount with a spark trail and a second seat, ~16 declarative blocks
  (glowing dragon stones, cloud block, mountain stone, crystal glass, scales, gold hoard,
  a per-face dragon **nest**), letter blocks A–Z, a land spawner, ambient sounds, a
  first-join starter kit, and commands (`/drachenhort_nest` builds the signature **dragon
  nest** base, `/drachenhort_teststation`, `/drachenhort_baby`). Full DE/EN guides
  (`ANLEITUNG.md`, `GUIDE.md`, `KINDER-KURZ.md`, `WELT-EINRICHTEN.md`)
- **New example theme `lernwelt_gluehpilz` (Gluehpilz-Wald, cosy mushroom realm):**
  a brand-free, very low-threshold "first world" built on the engine. Three learning
  zones (Pilzwald, Glüh-Höhle, Bach), ~30 declarative blocks (6 glowing mushrooms,
  moss/forest/mushroom-house parts, patterned + per-face blocks), 14 rescuable forest
  friends (with families and a rare Traum-Falter), a rideable **Leucht-Käfer** (glow-beetle
  mount with a second seat), forest-cleanup, mushroom-seed planting, drifting night
  **Glüh-Sporen**, letter blocks A–Z, and commands (`/pilzwald_haus` builds the signature
  **big mushroom house** base, `/pilzwald_teststation`, `/pilzwald_muell`) plus a
  first-join starter kit. Its special feature is **Tag-Nacht-Pilze**: right-click
  glowing mushrooms (`tag_pilz`, `daemmer_pilz`, `nacht_pilz`) to switch the whole
  world between day, dusk and night — a calm, child-controlled day/night cycle where the
  glow mushrooms light up the night. Tasks cover sorting by colour (MA.2), counting
  (MA.1), comparing big/small (MA.1/2) and experiencing day/night and light/dark
  (NMG.1). Full DE/EN guides (`ANLEITUNG.md`, `GUIDE.md`, `KINDER-KURZ.md`,
  `WELT-EINRICHTEN.md`); a custom ground spawner brings the land-walking friends to life
- **More space elements in `lernwelt_kosmo`:** a **Schwarzes Loch** (`schwarzes_loch`)
  that gently pulls nearby players in (child-friendly gravity well, no damage); a
  **Meteoritenschauer** — falling meteor entities with a fire trail that leave a
  collectible glowing `meteorit` node (counting hook with milestones), triggered with
  `/kosmo_meteore`; **Sternschnuppen** (purely visual shooting-star streaks that pass
  the sky now and then, with an occasional "make a wish"); and a **leuchtende Sonne**
  (`sonne`, max light) plus `/kosmo_sonne` to build a small sun ball. The black hole and
  sun are added to the starter kit and the `/kosmo_teststation`; docs updated
  (README/ANLEITUNG/GUIDE)
- **New example theme `lernwelt_kosmo` (Kosmo-Station, outer space):** a
  brand-free space-station learning world built on the engine. Four learning
  zones (Bunte Planeten, Asteroidengürtel, Sternennebel-Höhle, Mond-Basis),
  6 glowing planet blocks + station wall + window glass, 14 rescuable space
  friends (with families and a rare Golden comet), a drivable **Raumgleiter**
  (space glider with a second seat), space-junk cleanup, star-seed planting,
  letter blocks A–Z, test-station commands (`/kosmo_teststation`, `/kosmo_basis`,
  `/kosmo_schrott`) and a first-join starter kit. Its special feature is
  **Mond-Schwerkraft**: stand-on **jump/physics blocks** (`mond_boden` low
  gravity, `sprung_pad` trampoline bounce, `schwerelos_feld` weightless,
  `schwerkraft_normal` reset) that change how you move. Tasks cover counting
  planets (MA.1), colours, comparing sizes (MA.2), the rocket **launch-order**
  pattern (MI.1 mission sequence), light/dark and celestial bodies (NMG), and
  moon-jumping (BS.2). Full DE/EN guides (`ANLEITUNG.md`, `GUIDE.md`,
  `KINDER-KURZ.md`, `WELT-EINRICHTEN.md`); a custom ground spawner brings the
  land-walking friends to life
- `INSTALL.md` — a step-by-step install guide with per-OS sections for
  **Windows 11**, **macOS** and **Linux** (Luanti + base game + both mods +
  water-rich world setup); linked from both root READMEs
- **Per-face block textures** (engine): block definitions accept `tiles` (a raw
  Luanti tiles list) or the convenience fields `top` / `side` / `bottom`, so a
  block can have a different look per face (e.g. a chest with a lid)
- More `lernwelt_tiefsee` decoration blocks: fish scales, anchor, ship's wheel,
  and a real per-face **treasure chest** (`truhe`)
- **Letter blocks A–Z** (`buchstabe_a`…`buchstabe_z`) in `lernwelt_tiefsee`,
  rendered from a tiny procedural 5×7 pixel font — for laying out words
- A commented-out example in the theme for using your own painted **PNG** as a block
- `lernwelt_tiefsee/KINDER-KURZ.md` — a one-page, print-friendly kids' quick guide
  (big text, emojis, minimal words)
- `lernwelt_tiefsee/GUIDE.md` — an English translation of the player guide
  (ANLEITUNG.md), cross-linked both ways
- Patterned decoration blocks in `lernwelt_tiefsee` (stripes, dots, checker,
  frame, treasure chest, sand-with-shell, waves) — built purely from procedural
  texture modifiers (layered `[fill`), no image files needed; documented in
  ANLEITUNG.md and `textures/README.txt` (blocks already supported a `texture`
  field, including own PNGs)
- `lernwelt_tiefsee/ANLEITUNG.md` — a complete German player guide: every block,
  item, creature, zone and task, how to use them, the commands, the settings, a
  parents/teachers section, small missions and troubleshooting (linked from the
  theme README and both root READMEs)
- **Pattern task type** (engine): boards support a `pattern` task — reproduce a
  colour sequence with palette buttons
- **Accessibility settings** (engine): `lernwelt_big_text` (larger board font)
  and `lernwelt_easy_mode` (quizzes show only the correct answer + one other)
- **Explorer camera** (engine): per-world `<id>:kamera` item — left-click
  photographs the nearest undiscovered animal and marks it in the logbook; the
  logbook now shows a "discovered" status and an "X/N discovered" count
- **Animal families** (engine): a creature with `family = N` spawns N little
  ones when its (non-baby) parent is rescued, with a reunion message
- **`rare` creature flag** (engine): rare creatures are excluded from the
  automatic water spawner (egg/manual only)
- **`lernwelt_tiefsee` content**: six more animals (Seepferdchen, Krabbe,
  Delfin, Rochen, Seekuh and the rare, glowing legendary "Goldener Wal"),
  families on Delfin/Schildkröte/Seekuh, a colour-pattern board task, a naming
  quiz, a coral-planting mini-game (saplings grow into corals with a reef
  counter), submarine upgrades (headlight glow, bubble trail, a second seat),
  a bigger `/tiefsee_basis` glass-dome station command, and ambient whale/bubble
  sound hooks; camera + saplings added to the starter kit

- **Tasks on learning boards** (engine): zones may carry an optional `tasks`
  list — `quiz` (multiple-choice) and `rescue` (reach a rescue count) — shown
  on the board with answer buttons and progress; solving one gives a sound +
  message and counts towards the new progress report
- **`/lernfortschritt`** (engine): personal progress report — rank, rescues,
  tasks solved, animals rescued and the curriculum areas covered
- **Automatic water-animal spawning** (engine): a light, capped, backend-agnostic
  spawner adds a world's `swims` creatures in water near players; toggle with the
  new `lernwelt_spawn_creatures` setting
- **Ocean-cleanup mini-game** (`lernwelt_tiefsee`): breakable litter nodes
  (bottle, can, bag) with a personal cleanup counter and milestones
  (Meeres-Putzer → Riff-Retter → Ozean-Held); `/tiefsee_muell` (priv `server`)
  scatters test litter, and `/tiefsee_teststation` now includes some
- Example tasks in the `lernwelt_tiefsee` zones (one or two per zone)
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

### Fixed
- Startup error `Client: Don't know how to load file "lernwelt.tr"`: the
  translation template lived in `locale/` as `lernwelt.tr`, which has no
  language code, so newer Luanti builds try (and fail) to load it as a
  translation. Renamed it to `lernwelt/locale/template.txt` so it is kept as
  the master source-string list but never loaded as a `.tr` file. The real
  `lernwelt.de.tr` / `lernwelt.fr.tr` translations are unchanged.

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
