-- ============================================================
--  THEME:  SONNENHOF  (a friendly magic farm)
--  A brand-free farm learning world built ON TOP of the reusable
--  "lernwelt" engine. The whole educational frame - blocks,
--  learning zones, helpable farm animals, logbook, ranks and
--  badges - comes from one declarative register_world{...} call.
--
--  The theme's heart is NMG (Lehrplan 21): PLANTS & ANIMALS.
--  Children learn "vom Samen zum Brot" (from seed to bread),
--  TIERPFLEGE (caring for animals), the NAHRUNGSKETTE (food chain)
--  and GEDULD (patience - plants need time to grow). The base is
--  a SCHEUNE (barn) and the farm has three zones: the FELDER
--  (fields), the TIERGEHEGE (animal pen) and the MUEHLE (mill).
--  (Lehrplan 21: NMG.2 Pflanzen & Tiere, NMG.3 Vom Samen zum Brot.)
--
--  DESIGN GOAL of this theme (unlike the other examples, which
--  build everything themselves): use existing mods directly so
--  very little custom code is needed. When present, the theme
--  uses *Farming Redo* (seeds, wheat, flour, bread) and *Animalia*
--  (chicken, cow, sheep, pig ...) directly. It STILL works without
--  them: it ships a small own crop ("Weizen") and its own friendly
--  farm animals via the engine, so nothing breaks.
--
--  Things the engine cannot express live as small pieces of
--  custom code after register_world:
--    C) the theme's own WEIZEN crop (seed -> 4 stages -> harvest)
--    D) the ZAUBER-GIESSKANNE (waters & grows nearby crops; works
--       on Farming-Redo crops too - "vom Samen zum Brot" + Geduld)
--    E) the ZAUBERMUEHLE (Korn -> Mehl -> Brot; uses Farming-Redo
--       items when present)
--    F) the FUTTERTROG (Tierpflege: feed nearby animals, incl.
--       Animalia mobs)
--    G) farm food items (Korn, Mehl, Brot, Tierfutter) + sunflower
--    H) a first-join starter kit (quick testing)
--    I) a land spawner so the farm animals come alive
--    J) base commands (Scheune, test station) + ambient sound
--
--  The mod name equals the world id ("lernwelt_sonnenhof"), so all
--  nodes/items live in the "lernwelt_sonnenhof:" namespace.
--
--  Content is authored in German (ASCII: ae/oe/ue), like the other
--  example themes. The engine's own UI is translated separately
--  via lernwelt/locale/*.tr.
-- ============================================================

local WORLD_ID = "lernwelt_sonnenhof"
local function L(suffix) return WORLD_ID .. ":" .. suffix end

-- Which optional mods are actually present (decided once at load).
local HAS_FARMING  = core.get_modpath("farming")  ~= nil
local HAS_ANIMALIA = core.get_modpath("animalia") ~= nil

-- ------------------------------------------------------------
--  A) THE WHOLE LEARNING WORLD AS ONE DECLARATIVE TABLE
-- ------------------------------------------------------------
lernwelt.register_world({

    -- internal prefix; kept identical to the mod name so all
    -- nodes/items live in the "lernwelt_sonnenhof:" namespace
    id    = WORLD_ID,
    title = "Sonnenhof",

    -- --- 1) Peaceful, child-friendly world ---
    config = {
        damage      = false,   -- no damage / no dying
        creative    = true,    -- unlimited blocks
        peaceful    = true,    -- no monsters
        freeze_time = "day",   -- always bright and sunny
        no_weather  = true,
    },

    -- --- 2) A handful of warm, farmy building blocks ---
    --  Deliberately FEW blocks: the fields, crops and animals come
    --  from Farming Redo / Animalia (or the theme's own small crop),
    --  so the farm needs little hand-built content.
    --  The "texture" field is a Luanti texture-modifier string: a
    --  base "[fill" plus overlaid "^[fill:WxH:X,Y:#colour" rectangles.
    blocks = {
        -- The barn (base): red boards + a timber-frame variant.
        { suffix = "scheunenwand", name = "Scheunenwand (rote Bretter)",
          texture = "[fill:16x16:#a8392a^[fill:2x16:3,0:#7d2719^[fill:2x16:11,0:#7d2719" ..
                    "^[fill:16x1:0,5:#c25140^[fill:16x1:0,11:#c25140" },
        { suffix = "fachwerk", name = "Fachwerk-Wand",
          texture = "[fill:16x16:#f3ecd9^[fill:16x2:0,0:#6b4a2b^[fill:16x2:0,14:#6b4a2b" ..
                    "^[fill:2x16:0,0:#6b4a2b^[fill:2x16:14,0:#6b4a2b^[fill:2x16:7,0:#6b4a2b" ..
                    "^[fill:16x2:0,7:#6b4a2b" },
        { suffix = "scheunendach", name = "Scheunendach (Ziegel)",
          texture = "[fill:16x16:#8a3324^[fill:16x2:0,2:#6e2619^[fill:16x2:0,8:#6e2619" ..
                    "^[fill:16x2:0,14:#6e2619" },
        { suffix = "holzbalken", name = "Holzbalken",
          top    = "[fill:16x16:#9c6b3a^[fill:8x8:4,4:#82592f",
          side   = "[fill:16x16:#9c6b3a^[fill:16x2:0,3:#7a5128^[fill:16x2:0,11:#7a5128",
          bottom = "[fill:16x16:#7a5128" },

        -- Straw / hay (a barn classic).
        { suffix = "strohballen", name = "Strohballen",
          top    = "[fill:16x16:#e3c14f^[fill:14x14:1,1:#d4af3d^[fill:4x4:6,6:#b8932c",
          side   = "[fill:16x16:#e3c14f^[fill:16x2:0,2:#c9a437^[fill:16x2:0,7:#c9a437" ..
                   "^[fill:16x2:0,12:#c9a437" },
        { suffix = "stroh", name = "Stroh (Boden)",
          texture = "[fill:16x16:#e6c659^[fill:6x1:1,3:#c9a437^[fill:6x1:9,6:#c9a437" ..
                    "^[fill:6x1:3,10:#c9a437^[fill:6x1:8,13:#c9a437" },

        -- Field & path.
        { suffix = "ackererde", name = "Ackererde (umgegraben)",
          texture = "[fill:16x16:#6b4a2b^[fill:16x2:0,2:#5a3d22^[fill:16x2:0,7:#5a3d22" ..
                    "^[fill:16x2:0,12:#5a3d22" },
        { suffix = "blumenwiese", name = "Blumenwiese",
          texture = "[fill:16x16:#5fae3a^[fill:2x2:3,3:#f1c40f^[fill:2x2:11,5:#ffffff" ..
                    "^[fill:2x2:6,10:#e74c3c^[fill:2x2:12,12:#f1c40f" },
        { suffix = "feldweg", name = "Feldweg (Pflaster)",
          texture = "[fill:16x16:#9a9488^[fill:7x7:1,1:#8a8478^[fill:7x7:8,1:#857f73" ..
                    "^[fill:7x7:1,8:#857f73^[fill:7x7:8,8:#8a8478" },

        -- A simple pasture fence look (decorative full block).
        { suffix = "weidezaun", name = "Weidezaun",
          texture = "[fill:16x16:#caa46a^[fill:16x2:0,3:#8a5a2b^[fill:16x2:0,10:#8a5a2b" ..
                    "^[fill:2x16:3,0:#8a5a2b^[fill:2x16:11,0:#8a5a2b" },

        -- A flour sack (decoration / the mill's product, as a block).
        { suffix = "mehlsack", name = "Mehlsack",
          top    = "[fill:16x16:#efe6cf^[fill:6x6:5,5:#d8c79a",
          side   = "[fill:16x16:#efe6cf^[fill:16x3:0,0:#cdbb8c^[fill:6x4:5,8:#b89b6a" },

        -- A warm barn lantern (cosy lamp light).
        { suffix = "hoflaterne", name = "Hoflaterne",
          texture = "[fill:16x16:#5a3d22^[fill:8x10:4,3:#ffe08a^[fill:4x6:6,5:#fff6cf",
          glow = 12 },

        -- Eigenes gemaltes Bild als Block? Lege eine PNG (16x16 oder 32x32)
        -- "lernwelt_sonnenhof_meinbild.png" in den textures/-Ordner und entferne
        -- die zwei Minuszeichen vor der naechsten Zeile:
        -- { suffix = "meinbild", name = "Mein Bild", texture = "lernwelt_sonnenhof_meinbild.png" },
    },

    -- --- 3) Learning zones (each gets a placeable learning board) ---
    -- Zone titles double as the "habitat" shown in the logbook.
    zones = {
        {
            id = "felder", title = "Felder", color = "#6cae3a",
            activity = "Auf den Feldern beginnt alles: Saee einen Samen, giesse ihn " ..
                       "mit der Zauber-Giesskanne und habe Geduld - aus dem Samen " ..
                       "wird ein Halm und schliesslich reifes Korn. Bienen bestaeuben " ..
                       "die Bluten. Das ist der Start von 'Vom Samen zum Brot'.",
            lehrplan = { "NMG.3", "NMG.2", "EZ.1" },
            tasks = {
                { type = "quiz",
                  question = "Was braucht ein Samen zum Wachsen?",
                  options = { "Wasser und Sonne", "Schokolade", "Dunkelheit" }, answer = 1,
                  done = "Richtig! Ein Samen braucht Wasser, Sonne und Erde." },
                { type = "pattern",
                  -- planting in tidy rows (gruen-gelb-gruen ...)
                  sequence = { "#6cae3a", "#f1c40f", "#6cae3a" },
                  palette  = { { "#6cae3a", "Gruen" }, { "#f1c40f", "Gelb" },
                               { "#6b4a2b", "Erde" } },
                  done = "Schoen! Eine ordentliche Saatreihe gelegt." },
                { type = "rescue", creature = "biene", count = 3,
                  done = "Stark! Drei Bienen geholfen - sie bestaeuben die Felder." },
            },
        },
        {
            id = "tiergehege", title = "Tiergehege", color = "#b5742a",
            activity = "Im Tiergehege leben die Hoftiere: Huhn, Kuh, Schaf, Schwein, " ..
                       "Ziege und Ente. Pflege sie am Futtertrog, zaehle sie und lerne, " ..
                       "wer was gibt (Eier, Milch, Wolle) und was sie fressen " ..
                       "(Nahrungskette).",
            lehrplan = { "NMG.2", "MA.1", "EZ.1" },
            tasks = {
                { type = "quiz",
                  question = "Was gibt uns das Huhn?",
                  options = { "Eier", "Wolle", "Honig" }, answer = 1,
                  done = "Genau! Das Huhn legt Eier." },
                { type = "quiz",
                  question = "Nahrungskette: Was frisst die Kuh?",
                  options = { "Gras", "Fleisch", "Steine" }, answer = 1,
                  done = "Richtig! Die Kuh frisst Gras - und gibt uns Milch." },
                { type = "rescue", creature = "huhn", count = 3,
                  done = "Klasse! Drei Huehnern geholfen." },
            },
        },
        {
            id = "muehle", title = "Muehle", color = "#d9b66a",
            activity = "In der Muehle wird das reife Korn weiterverarbeitet: Die " ..
                       "Zaubermuehle mahlt Korn zu Mehl, und aus Mehl wird Brot " ..
                       "gebacken. So schliesst sich der Weg 'Vom Samen zum Brot'.",
            lehrplan = { "NMG.3", "MA.1", "D.2" },
            tasks = {
                { type = "quiz",
                  question = "Was macht die Muehle aus Korn?",
                  options = { "Mehl", "Milch", "Eier" }, answer = 1,
                  done = "Richtig! Die Muehle mahlt Korn zu Mehl." },
                { type = "quiz",
                  question = "Vom Samen zum Brot - was kommt ZULETZT?",
                  options = { "Brot", "Samen", "Halm" }, answer = 1,
                  done = "Genau! Samen - Halm - Korn - Mehl - Brot." },
                { type = "rescue", creature = "feldmaus", count = 2,
                  done = "Wunderbar! Zwei Feldmaeusen an der Muehle geholfen." },
            },
        },
    },

    -- --- 4) Helpable farm animals (peaceful; right-click = help) ---
    --  These are the engine's own gentle "rescue" animals so the
    --  logbook, camera and rescue loop always work - even without a
    --  mob mod. When Animalia IS installed the theme additionally
    --  hands out real Animalia animals in the starter kit (see H),
    --  and the names below mirror the Animalia line-up so it feels
    --  consistent either way.
    creatures = {
        {
            id = "huhn", name = "Huhn", zone = "tiergehege",
            color = "#f4f1e9", size = 0.5, speed = 1.0, family = 2,
            food = "Koerner", power = "Legt Eier",
            heart = "#ffe08a",
            rescue_text = "Geholfen! Das Huhn gackert zufrieden und pickt weiter.",
        },
        {
            id = "kuh", name = "Kuh", zone = "tiergehege",
            color = "#caa46a", size = 1.1, speed = 0.6, family = 1,
            food = "Gras und Heu", power = "Gibt Milch",
            heart = "#fff3d6",
            rescue_text = "Geholfen! Die Kuh muht freundlich und kaut weiter.",
        },
        {
            id = "schaf", name = "Schaf", zone = "tiergehege",
            color = "#f0ece1", size = 0.9, speed = 0.8, family = 2,
            food = "Gras", power = "Gibt Wolle",
            heart = "#ffffff",
            rescue_text = "Geholfen! Das Schaf blooekt und hopst ins Gras.",
        },
        {
            id = "schwein", name = "Schwein", zone = "tiergehege",
            color = "#f3b6c2", size = 0.8, speed = 0.9, family = 2,
            food = "Ruebenschalen", power = "Suhlt sich gern im Schlamm",
            heart = "#ffd0e6",
            rescue_text = "Geholfen! Das Schwein grunzt vergnuegt.",
        },
        {
            id = "ziege", name = "Ziege", zone = "tiergehege",
            color = "#e8dcc0", size = 0.8, speed = 1.1,
            food = "Blaetter und Gras", power = "Klettert ueberall hoch",
            heart = "#fff3d6",
            rescue_text = "Geholfen! Die Ziege meckert und springt davon.",
        },
        {
            id = "ente", name = "Ente", zone = "tiergehege",
            color = "#e7d98a", size = 0.5, speed = 0.9, swims = true, family = 2,
            food = "Wasserpflanzen", power = "Schwimmt im Hofteich",
            heart = "#fff0b0",
            rescue_text = "Geholfen! Die Ente schnattert und paddelt davon.",
        },
        {
            id = "esel", name = "Esel", zone = "tiergehege",
            color = "#a99a86", size = 1.0, speed = 0.9,
            food = "Hafer und Heu", power = "Traegt schwere Saecke",
            heart = "#d8cdbd",
            rescue_text = "Geholfen! Der Esel iaht und trottet zufrieden weiter.",
        },
        {
            id = "hofkatze", name = "Hofkatze", zone = "felder",
            color = "#c8893f", size = 0.5, speed = 1.4,
            food = "Milch", power = "Faengt Maeuse in der Scheune",
            heart = "#ffd9a8",
            rescue_text = "Geholfen! Die Hofkatze schnurrt und streicht um deine Beine.",
        },
        {
            id = "hofhund", name = "Hofhund", zone = "felder",
            color = "#8a6a45", size = 0.7, speed = 1.3,
            food = "Knochen", power = "Passt auf den Hof auf",
            heart = "#d8b58a",
            rescue_text = "Geholfen! Der Hofhund wedelt freudig mit dem Schwanz.",
        },
        {
            id = "biene", name = "Biene", zone = "felder",
            color = "#f2c40f", size = 0.4, speed = 1.5, glow = 4,
            food = "Bluetennektar", power = "Bestaeubt die Bluten - wichtig fuer die Ernte",
            heart = "#ffe9a0",
            rescue_text = "Geholfen! Die Biene summt von Blume zu Blume.",
        },
        {
            id = "feldmaus", name = "Feldmaus", zone = "felder",
            color = "#b59a78", size = 0.4, speed = 1.6, family = 2,
            food = "Koerner", power = "Flink und neugierig",
            heart = "#d8c4a8",
            rescue_text = "Geholfen! Die Feldmaus huscht piepsend ins Korn.",
        },
        {
            id = "storch", name = "Storch", zone = "felder",
            color = "#f6f2ea", size = 0.9, speed = 1.0,
            food = "Froesche", power = "Stakst durch die Wiese",
            heart = "#ffd0c0",
            rescue_text = "Geholfen! Der Storch klappert und stakst weiter.",
        },
        {
            -- legendary, rare: never auto-spawns (egg/manual only)
            id = "goldhuhn", name = "Goldenes Glueckshuhn", zone = "tiergehege",
            color = "#ffcf33", size = 0.6, speed = 1.2, glow = 12, rare = true,
            food = "Goldkoerner", power = "Sehr selten - legt goldene Eier und leuchtet",
            heart = "#ffe27a",
            rescue_text = "Das seltene Goldene Glueckshuhn schenkt dir ein goldenes Funkeln!",
        },
    },

    -- --- 5) Ranks (3rd field = colour -> creates a badge item) ---
    ranks = {
        { 0,  "Hofkind" },
        { 5,  "Jungbauer" },
        { 10, "Hofhelfer",      "#8ac34a" },
        { 25, "Bauernmeister",  "#d9b66a" },
        { 50, "Sonnenhof-Held", "#f1c40f" },
    },

    -- --- 6) Logbook item ---
    logbook = { title = "Sonnenhof-Logbuch", item_color = "#f1c40f" },

    -- --- 7) Plain texts for curriculum codes (for /lernplan & boards) ---
    kompetenzen = {
        ["NMG.2"] = "Tiere und Pflanzen erkunden, benennen und pflegen",
        ["NMG.3"] = "Vom Samen zum Brot - Nahrung und ihre Herkunft",
        ["MA.1"]  = "Mengen erfassen und zaehlen (Tiere, Ernte)",
        ["EZ.1"]  = "Geduld, Verantwortung und Sorgfalt",
        ["D.2"]   = "Hoftiere und Pflanzen benennen und beschreiben",
    },
})

-- ============================================================
--  THEME EXTRAS  (self-contained Lua the engine cannot express)
-- ============================================================

-- A small helper used by several extras: award a personal counter
-- with milestones (sound + chat), e.g. "watered", "fed", "baked".
local function bump_counter(player, key, label, milestones)
    local meta = player:get_meta()
    local k    = WORLD_ID .. ":" .. key
    local n    = meta:get_int(k) + 1
    meta:set_int(k, n)
    local name = player:get_player_name()
    core.chat_send_player(name, label .. ": " .. n)
    local title = milestones and milestones[n]
    if title then
        core.sound_play("lernwelt_rankup", { to_player = name, gain = 1.0 })
        core.chat_send_player(name, "Toll! Du bist jetzt: " .. title .. "!")
    end
    return n
end

-- ------------------------------------------------------------
--  G) EXTRA: FARM FOOD ITEMS  (Korn, Mehl, Brot, Tierfutter)
--  Tiny craftitems that form the theme's OWN "vom Samen zum Brot"
--  chain and animal food - used as a fallback when Farming Redo is
--  absent (and always handy in the starter kit).
-- ------------------------------------------------------------
core.register_craftitem(L("korn"), {
    description     = "Korn (Weizen)\nIn die Zaubermuehle geben = Mehl",
    inventory_image = "[fill:16x16:#0000^[fill:3x9:6,4:#d4af3d^[fill:5x3:5,3:#e8c84e" ..
                      "^[fill:3x3:4,7:#c9a437^[fill:3x3:9,7:#c9a437",
    groups          = { food = 1, flammable = 2 },
})

core.register_craftitem(L("mehl"), {
    description     = "Mehl\nIn die Zaubermuehle geben = Brot",
    inventory_image = "[fill:16x16:#efe6cf^[fill:10x10:3,3:#f6f0e0^[fill:3x3:6,6:#d8c79a",
    groups          = { food = 1 },
})

core.register_craftitem(L("brot"), {
    description     = "Brot\nFrisch aus der Zaubermuehle - vom Samen zum Brot!",
    inventory_image = "[fill:16x16:#0000^[fill:12x7:2,5:#c8843a^[fill:12x2:2,4:#dca157" ..
                      "^[fill:2x2:5,6:#7a4f1e^[fill:2x2:9,7:#7a4f1e",
    groups          = { food = 2 },
    on_use          = core.item_eat and core.item_eat(2) or nil,
})

core.register_craftitem(L("tierfutter"), {
    description     = "Tierfutter\nIn die Hand nehmen und einen Futtertrog mit " ..
                      "Rechtsklick fuettern (Tierpflege)",
    inventory_image = "[fill:16x16:#caa46a^[fill:5x5:2,2:#e8c84e^[fill:4x4:9,3:#d4af3d" ..
                      "^[fill:5x5:6,8:#b8932c",
    groups          = { food = 1 },
})

-- A cheerful sunflower (plantlike) - the "Sonnen"-hof signature.
core.register_node(L("sonnenblume"), {
    description = "Sonnenblume",
    drawtype = "plantlike",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    waving = 1,
    visual_scale = 1.4,
    tiles = { "[fill:16x16:#0000^[fill:2x9:7,6:#3e7d2a^[fill:8x8:4,1:#7a4f1e" ..
              "^[fill:10x4:3,0:#f2c40f^[fill:4x10:6,-2:#f2c40f^[fill:4x4:6,2:#7a4f1e" },
    inventory_image = "[fill:16x16:#0000^[fill:2x9:7,6:#3e7d2a^[fill:10x10:3,1:#f2c40f" ..
                      "^[fill:5x5:5,3:#7a4f1e",
    selection_box = { type = "fixed", fixed = { -0.3, -0.5, -0.3, 0.3, 0.6, 0.3 } },
    groups = { dig_immediate = 3, snappy = 3, flammable = 2, plant = 1 },
})

-- ------------------------------------------------------------
--  C) EXTRA: WEIZEN  (the theme's own crop: seed -> 4 stages)
--  A self-contained crop so "vom Samen zum Brot" works even
--  without Farming Redo. Plant the seed; it grows slowly on a
--  timer (GEDULD!). The Zauber-Giesskanne (D) speeds it up. The
--  ripe stage (weizen_4) drops Korn + a seed when harvested.
--  Stages are named "weizen_1..weizen_4" so the generic grower in
--  (D) advances them just like Farming-Redo's "wheat_1..8".
-- ------------------------------------------------------------
local WEIZEN_STAGES   = 4
local WEIZEN_GROWTIME = 18   -- seconds per stage when left alone (patience)

local function weizen_tile(stage)
    -- a little greener/taller/golder per stage
    local h    = 3 + stage * 3                       -- height of the halm
    local col  = (stage >= WEIZEN_STAGES) and "#d4af3d" or "#5fae3a"
    local ear  = (stage >= WEIZEN_STAGES)
        and "^[fill:6x4:5,1:#e8c84e^[fill:4x3:6,0:#f0d35a" or ""
    return ("[fill:16x16:#0000^[fill:2x%d:7,%d:%s%s"):format(h, 15 - h, col, ear)
end

for stage = 1, WEIZEN_STAGES do
    local ripe   = (stage == WEIZEN_STAGES)
    local groups = { dig_immediate = 3, snappy = 3, flammable = 2, plant = 1,
                     attached_node = 1, not_in_creative_inventory = 1 }
    if not ripe then groups.growing = 1 end

    core.register_node(L("weizen_" .. stage), {
        description         = "Weizen (Stufe " .. stage .. ")",
        drawtype            = "plantlike",
        paramtype           = "light",
        sunlight_propagates = true,
        walkable            = false,
        floodable           = true,
        waving              = 1,
        tiles               = { weizen_tile(stage) },
        selection_box       = { type = "fixed", fixed = { -0.3, -0.5, -0.3, 0.3, 0.2, 0.3 } },
        groups              = groups,
        drop                = ripe
            and { items = { { items = { L("korn") .. " 2", L("weizen_samen") } } } }
            or  L("weizen_samen"),
        on_timer = function(pos)
            if stage >= WEIZEN_STAGES then return false end
            core.swap_node(pos, { name = L("weizen_" .. (stage + 1)) })
            core.get_node_timer(pos):start(WEIZEN_GROWTIME)
            return false
        end,
        after_place_node = function(pos)
            core.get_node_timer(pos):start(WEIZEN_GROWTIME)
        end,
    })
end

-- The seed: place it on soil/ground to start a weizen_1.
core.register_craftitem(L("weizen_samen"), {
    description     = "Weizen-Samen\nAuf den Boden setzen = saeen (dann giessen!)",
    inventory_image = "[fill:16x16:#0000^[fill:3x3:6,6:#7a4f1e^[fill:2x2:7,5:#a8763a" ..
                      "^[fill:2x2:5,8:#a8763a^[fill:2x2:9,8:#a8763a",
    on_place = function(itemstack, placer, pointed_thing)
        if pointed_thing.type ~= "node" or not (placer and placer:is_player()) then
            return itemstack
        end
        local above = pointed_thing.above
        if core.get_node(above).name ~= "air" then return itemstack end
        core.set_node(above, { name = L("weizen_1") })
        core.get_node_timer(above):start(WEIZEN_GROWTIME)
        if not core.is_creative_enabled(placer:get_player_name()) then
            itemstack:take_item()
        end
        return itemstack
    end,
})

-- ------------------------------------------------------------
--  D) EXTRA: ZAUBER-GIESSKANNE  (waters & grows nearby crops)
--  The theme's "vom Samen zum Brot" + GEDULD tool. Right-click a
--  field with the watering can: every growing crop in a small area
--  jumps one growth stage. It is fully generic - it advances any
--  staged plant node "<base>_<n>" whose next stage "<base>_<n+1>"
--  exists and that is a plant/growing node. So it grows the
--  theme's own Weizen AND real Farming-Redo crops (wheat_1..8,
--  carrot, potato ...). Each watering counts towards a personal
--  "Giess-Profi" milestone.
-- ------------------------------------------------------------
local WATER_RADIUS = 2
local WATER_MILESTONES = {
    [5]  = "Giess-Anfaenger",
    [15] = "Giess-Profi",
    [30] = "Giess-Meister",
}

-- Is this node a plant we may advance?
local function is_growable(name)
    local def = core.registered_nodes[name]
    if not def or not def.groups then return false end
    local g = def.groups
    return (g.growing or g.plant or g.farming_plant or g.seed) ~= nil
end

local function water_and_grow(center)
    local grown = 0
    for x = -WATER_RADIUS, WATER_RADIUS do
    for y = -1, 1 do
    for z = -WATER_RADIUS, WATER_RADIUS do
        local p    = { x = center.x + x, y = center.y + y, z = center.z + z }
        local name = core.get_node(p).name
        local base, num = name:match("^(.-)_(%d+)$")
        if base and num and is_growable(name) then
            local nextn = base .. "_" .. (tonumber(num) + 1)
            if core.registered_nodes[nextn] then
                core.swap_node(p, { name = nextn, param2 = core.get_node(p).param2 })
                grown = grown + 1
            end
        end
    end end end
    return grown
end

core.register_tool(L("giesskanne"), {
    description     = "Zauber-Giesskanne\nRechtsklick auf ein Feld = Pflanzen giessen " ..
                      "und wachsen lassen",
    inventory_image = "[fill:16x16:#0000^[fill:9x7:2,6:#3aa6c8^[fill:4x4:10,7:#3aa6c8" ..
                      "^[fill:6x2:4,4:#2b8aa8^[fill:2x4:5,1:#bfe9f5^[fill:2x4:8,1:#bfe9f5",
    on_place = function(itemstack, placer, pointed_thing)
        if pointed_thing.type ~= "node" or not (placer and placer:is_player()) then
            return itemstack
        end
        local name   = placer:get_player_name()
        local center = pointed_thing.under
        local grown  = water_and_grow(center)

        -- a sparkle of blue water drops
        core.add_particlespawner({
            amount = 16, time = 0.3,
            minpos = { x = center.x - WATER_RADIUS, y = center.y + 1, z = center.z - WATER_RADIUS },
            maxpos = { x = center.x + WATER_RADIUS, y = center.y + 1.5, z = center.z + WATER_RADIUS },
            minvel = { x = 0, y = -1, z = 0 }, maxvel = { x = 0, y = -2, z = 0 },
            minexptime = 0.4, maxexptime = 0.8, minsize = 1, maxsize = 2,
            texture = "[fill:8x8:#7ec8ec",
        })
        core.sound_play("lernwelt_rescue", { to_player = name, gain = 0.4 })

        if grown > 0 then
            bump_counter(placer, "gegossen", "Pflanzen gegossen und gewachsen", WATER_MILESTONES)
        else
            core.chat_send_player(name,
                "Du giesst die Erde. Saee zuerst Samen (Weizen-Samen) - dann waechst hier etwas!")
        end
        return itemstack
    end,
})

-- ------------------------------------------------------------
--  E) EXTRA: ZAUBERMUEHLE  (Korn -> Mehl -> Brot)
--  The mill closes the "vom Samen zum Brot" chain. Right-click it
--  holding Korn -> you get Mehl; holding Mehl -> you get Brot. When
--  Farming Redo is installed it ALSO grinds real farming:wheat ->
--  farming:flour and farming:flour -> farming:bread, so the theme
--  works hand in hand with that mod. Each step counts (milestones).
-- ------------------------------------------------------------
local MILL_MILESTONES = {
    [5]  = "Muellerlehrling",
    [15] = "Mueller",
    [30] = "Muellermeister",
}

-- Build the input -> output map once (theme items always, Farming
-- Redo items when present).
local MILL = {
    [L("korn")] = { out = L("mehl"), msg = "Die Zaubermuehle mahlt Korn zu Mehl.",   key = "gemahlen" },
    [L("mehl")] = { out = L("brot"), msg = "Aus Mehl wird ein frisches Brot gebacken!", key = "gebacken" },
}
if HAS_FARMING then
    if core.registered_items["farming:wheat"] and core.registered_items["farming:flour"] then
        MILL["farming:wheat"] = { out = "farming:flour",
            msg = "Die Zaubermuehle mahlt Weizen zu Mehl.", key = "gemahlen" }
    end
    if core.registered_items["farming:flour"] and core.registered_items["farming:bread"] then
        MILL["farming:flour"] = { out = "farming:bread",
            msg = "Aus Mehl wird ein frisches Brot gebacken!", key = "gebacken" }
    end
end

core.register_node(L("muehle"), {
    description = "Zaubermuehle\nKorn in die Hand nehmen, Rechtsklick = mahlen " ..
                  "(Korn -> Mehl -> Brot)",
    tiles = {
        "[fill:16x16:#cdbb8c^[fill:12x12:2,2:#e3d6b0^[fill:4x4:6,6:#8a5a2b",          -- top: millstone
        "[fill:16x16:#8a5a2b",                                                        -- bottom
        "[fill:16x16:#cdbb8c^[fill:16x3:0,6:#8a5a2b^[fill:4x10:6,4:#a8763a" ..
        "^[fill:2x10:7,4:#7a4f1e",                                                     -- sides
    },
    paramtype2        = "facedir",
    groups            = { cracky = 2, oddly_breakable_by_hand = 2 },
    is_ground_content = false,
    on_rightclick = function(pos, node, clicker)
        if not (clicker and clicker:is_player()) then return end
        local name    = clicker:get_player_name()
        local wielded  = clicker:get_wielded_item()
        local recipe   = MILL[wielded:get_name()]
        if not recipe then
            core.chat_send_player(name,
                "Die Muehle braucht Korn oder Mehl. Nimm 'Korn' (oder Mehl) in die Hand " ..
                "und mach Rechtsklick. Korn bekommst du beim Ernten von reifem Weizen.")
            return
        end
        if not core.is_creative_enabled(name) then
            wielded:take_item(); clicker:set_wielded_item(wielded)
        end
        local inv = clicker:get_inventory()
        if inv then inv:add_item("main", recipe.out) end

        core.add_particlespawner({
            amount = 10, time = 0.3,
            minpos = vector.subtract(pos, 0.4), maxpos = vector.add(pos, 0.6),
            minvel = { x = -0.4, y = 0.5, z = -0.4 }, maxvel = { x = 0.4, y = 1.5, z = 0.4 },
            minexptime = 0.4, maxexptime = 0.9, minsize = 1, maxsize = 2,
            texture = "[fill:8x8:#efe6cf",
        })
        core.sound_play("lernwelt_rescue", { to_player = name, gain = 0.5 })
        core.chat_send_player(name, recipe.msg)
        bump_counter(clicker, recipe.key,
            (recipe.key == "gebacken") and "Brote gebacken" or "Mal gemahlen",
            MILL_MILESTONES)
    end,
})

-- ------------------------------------------------------------
--  F) EXTRA: FUTTERTROG  (Tierpflege - feed nearby animals)
--  Caring for the farm: hold Tierfutter (or Korn) and right-click
--  a Futtertrog. Every animal nearby - the theme's own creatures
--  AND real Animalia/mob animals - gets a little heart, and a
--  personal "Tierpflege" counter ticks up with milestones. Makes
--  responsibility and care tangible (NMG / EZ).
-- ------------------------------------------------------------
local FEED_MILESTONES = {
    [5]  = "Tierfreund",
    [15] = "Tierpfleger",
    [30] = "Hof-Tierpfleger",
}
local FEED_FOODS = { [L("tierfutter")] = true, [L("korn")] = true }
if HAS_FARMING then
    for _, n in ipairs({ "farming:wheat", "farming:seed_wheat", "farming:carrot" }) do
        if core.registered_items[n] then FEED_FOODS[n] = true end
    end
end

-- Is this entity an animal we can pet? (own creatures, Animalia, or
-- any common mob backend) - never the player itself.
local function is_animal_entity(le)
    if not (le and le.name) then return false end
    local n = le.name
    return n:sub(1, #WORLD_ID + 1) == WORLD_ID .. ":"
        or n:sub(1, 9)  == "animalia:"
        or n:sub(1, 5)  == "mobs:"
        or n:sub(1, 4)  == "mcl_"
end

core.register_node(L("futtertrog"), {
    description = "Futtertrog\nTierfutter (oder Korn) in die Hand nehmen, " ..
                  "Rechtsklick = Tiere pflegen",
    tiles = {
        "[fill:16x16:#8a5a2b^[fill:12x12:2,2:#5a3d22^[fill:5x5:3,3:#e8c84e" ..
        "^[fill:5x5:8,4:#d4af3d^[fill:4x4:5,9:#caa46a",                       -- top: trough with feed
        "[fill:16x16:#5a3d22",                                               -- bottom
        "[fill:16x16:#8a5a2b^[fill:16x3:0,2:#6b4a2b^[fill:16x3:0,11:#6b4a2b", -- sides
    },
    paramtype2        = "facedir",
    groups            = { choppy = 2, oddly_breakable_by_hand = 2 },
    is_ground_content = false,
    on_rightclick = function(pos, node, clicker)
        if not (clicker and clicker:is_player()) then return end
        local name    = clicker:get_player_name()
        local wielded = clicker:get_wielded_item()
        if not FEED_FOODS[wielded:get_name()] then
            core.chat_send_player(name,
                "Der Futtertrog braucht Tierfutter. Nimm 'Tierfutter' (oder Korn) in die " ..
                "Hand und mach Rechtsklick. Tiere in der Naehe werden dann gepflegt.")
            return
        end
        if not core.is_creative_enabled(name) then
            wielded:take_item(); clicker:set_wielded_item(wielded)
        end

        -- a few hearts over the trough and over nearby animals
        local function hearts(p)
            core.add_particlespawner({
                amount = 6, time = 0.3,
                minpos = vector.subtract(p, 0.3), maxpos = vector.add(p, 0.3),
                minvel = { x = -0.3, y = 1, z = -0.3 }, maxvel = { x = 0.3, y = 2, z = 0.3 },
                minexptime = 0.5, maxexptime = 1.0, minsize = 1, maxsize = 2,
                texture = "[fill:8x8:#ff6f91",
            })
        end
        hearts({ x = pos.x, y = pos.y + 0.6, z = pos.z })
        local petted = 0
        for _, obj in ipairs(core.get_objects_inside_radius(pos, 8)) do
            if not obj:is_player() and is_animal_entity(obj:get_luaentity()) then
                local p = obj:get_pos()
                if p then hearts({ x = p.x, y = p.y + 0.5, z = p.z }) end
                petted = petted + 1
            end
        end

        core.sound_play("lernwelt_rescue", { to_player = name, gain = 0.5 })
        bump_counter(clicker, "gepflegt", "Tiere gepflegt", FEED_MILESTONES)
        if petted > 0 then
            core.chat_send_player(name, "Tiere in der Naehe gefuettert: " .. petted)
        end
    end,
})

-- ------------------------------------------------------------
--  H) EXTRA: STARTER KIT  (handed out once on first join)
--  Makes the world testable right away: the logbook, the camera,
--  the watering can, seeds, animal feed + a trough, all building
--  blocks, and one spawn egg per farm creature. When Farming Redo
--  and/or Animalia are present, real farming seeds and Animalia
--  spawn eggs are added too (best-effort; anything missing is
--  simply skipped). Turn off via "lernwelt_sonnenhof_starter_kit".
-- ------------------------------------------------------------
local STARTER_BLOCKS = {
    "scheunenwand", "fachwerk", "scheunendach", "holzbalken",
    "strohballen", "stroh", "ackererde", "blumenwiese", "feldweg",
    "weidezaun", "mehlsack", "hoflaterne",
    "muehle", "futtertrog", "sonnenblume",
}
-- Spawn-egg item names match the creature ids (world_id:creature_id)
local STARTER_EGGS = {
    "huhn", "kuh", "schaf", "schwein", "ziege", "ente", "esel",
    "hofkatze", "hofhund", "biene", "feldmaus", "storch", "goldhuhn",
}
-- Real Farming Redo items to add when present.
local FARMING_GIFTS = {
    "farming:seed_wheat 10", "farming:seed_cotton 5", "farming:carrot 3",
    "farming:potato 3", "farming:hoe_steel",
}
-- Best-effort Animalia spawn eggs (names differ across versions, so
-- we try several and keep whatever is actually registered).
local ANIMALIA_GIFTS = {
    "animalia:chicken", "animalia:cow", "animalia:sheep", "animalia:pig",
    "animalia:turkey", "animalia:cat",
    "animalia:spawn_chicken", "animalia:spawn_cow", "animalia:spawn_sheep",
    "animalia:spawn_pig", "animalia:spawn_turkey", "animalia:spawn_cat",
}

-- Add an item only if it is actually registered (robust across
-- games with or without the optional mods).
local function give_if_exists(inv, itemstring)
    local name = ItemStack(itemstring):get_name()
    if core.registered_items[name] then
        inv:add_item("main", itemstring)
    end
end

local function give_starter_kit(player)
    local inv = player:get_inventory()
    if not inv then return end
    give_if_exists(inv, L("logbuch"))
    give_if_exists(inv, L("kamera"))
    give_if_exists(inv, L("giesskanne"))
    give_if_exists(inv, L("weizen_samen") .. " 10")
    give_if_exists(inv, L("tierfutter") .. " 20")
    give_if_exists(inv, L("korn") .. " 10")
    for _, suffix in ipairs(STARTER_BLOCKS) do
        give_if_exists(inv, L(suffix) .. " 10")
    end
    for _, cid in ipairs(STARTER_EGGS) do
        give_if_exists(inv, L(cid))
    end
    -- Use the real mods directly when they are installed.
    if HAS_FARMING then
        for _, it in ipairs(FARMING_GIFTS) do give_if_exists(inv, it) end
    end
    if HAS_ANIMALIA then
        for _, it in ipairs(ANIMALIA_GIFTS) do give_if_exists(inv, it) end
    end

    local extra = ""
    if HAS_FARMING or HAS_ANIMALIA then
        extra = " Zusaetzlich gefunden: " ..
            (HAS_FARMING  and "Farming-Redo-Saatgut "  or "") ..
            (HAS_ANIMALIA and "und Animalia-Tier-Eier" or "") .. "."
    end
    core.chat_send_player(player:get_player_name(),
        "Sonnenhof: Startausruestung erhalten - Sonnenhof-Logbuch, Kamera, Zauber-Giesskanne, " ..
        "Weizen-Samen, Tierfutter + Korn, Bau-Bloecke (inkl. Zaubermuehle & Futtertrog) und " ..
        "Spawn-Eier." .. extra ..
        " Tipp: '/sonnenhof_scheune' baut dir einen ganzen Bauernhof. Viel Spass auf dem Sonnenhof!")
end

core.register_on_joinplayer(function(player)
    if not core.settings:get_bool("lernwelt_sonnenhof_starter_kit", true) then return end
    local meta = player:get_meta()
    if meta:get_int("lernwelt_sonnenhof:starter_given") == 1 then return end
    meta:set_int("lernwelt_sonnenhof:starter_given", 1)
    -- slight delay so the inventory exists and the message is seen
    core.after(1.5, function()
        if player and player:is_player() then give_starter_kit(player) end
    end)
end)

-- ------------------------------------------------------------
--  I) CREATURE LAND SPAWNER  (a living farm)
--  The engine's built-in spawner only places water creatures, so
--  this small, backend-agnostic spawner brings the land animals to
--  life: every so often it adds one non-rare land creature on solid
--  ground near a player, capped so the farm never gets crowded.
--  Turn off with the setting "lernwelt_spawn_creatures".
-- ------------------------------------------------------------
local function ground_spawn_list()
    local list  = {}
    local world = lernwelt.worlds[WORLD_ID]
    for _, c in ipairs((world or {}).creatures or {}) do
        if not c.rare and not c.swims then list[#list + 1] = L(c.id) end
    end
    return list
end

local gs_timer = 0
core.register_globalstep(function(dtime)
    if not lernwelt.mobs.available() then return end
    if not core.settings:get_bool("lernwelt_spawn_creatures", true) then return end

    gs_timer = gs_timer + dtime
    if gs_timer < 13 then return end
    gs_timer = 0

    local list = ground_spawn_list()
    if #list == 0 then return end

    for _, player in ipairs(core.get_connected_players()) do
        if math.random() < 0.6 then
            local pp   = player:get_pos()
            local ang  = math.random() * math.pi * 2
            local dist = 8 + math.random(0, 14)
            local cx   = math.floor(pp.x + math.cos(ang) * dist)
            local cz   = math.floor(pp.z + math.sin(ang) * dist)

            local spawn_pos
            for dy = 3, -6, -1 do
                local p     = { x = cx, y = math.floor(pp.y) + dy, z = cz }
                local here  = core.get_node(p).name
                local above = core.get_node({ x = p.x, y = p.y + 1, z = p.z }).name
                local def   = core.registered_nodes[here]
                if def and def.walkable ~= false and here ~= "air"
                   and here ~= "ignore" and above == "air" then
                    spawn_pos = { x = p.x, y = p.y + 1, z = p.z }
                    break
                end
            end

            if spawn_pos then
                local count, prefix = 0, WORLD_ID .. ":"
                for _, obj in ipairs(core.get_objects_inside_radius(spawn_pos, 24)) do
                    local le = obj:get_luaentity()
                    if le and le.name and le.name:sub(1, #prefix) == prefix then
                        count = count + 1
                    end
                end
                if count < 5 then
                    core.add_entity(spawn_pos, list[math.random(#list)])
                end
            end
        end
    end
end)

-- ------------------------------------------------------------
--  J) EXTRA: BASE COMMANDS  (Scheune, test station)
--  Ready-made builds in front of you. All need the "server"
--  privilege (automatic in single-player).
-- ------------------------------------------------------------
local BOARDS = {
    L("tafel_felder"),
    L("tafel_tiergehege"),
    L("tafel_muehle"),
}

-- The signature base: a roomy SCHEUNE (barn) with red-board walls,
-- a tiled roof, a straw floor, the three learning boards, a small
-- ploughed FIELD already sown with weizen, a fenced TIERGEHEGE, the
-- Zaubermuehle and a Futtertrog - the whole farm in one command.
core.register_chatcommand("sonnenhof_scheune", {
    description = "Baut einen ganzen Bauernhof vor dir (Scheune, 3 Lern-Tafeln, " ..
                  "Weizen-Feld, Tiergehege mit Zaun, Zaubermuehle, Futtertrog)",
    privs = { server = true },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then return false, "Dieser Befehl funktioniert nur im Spiel." end
        local b    = vector.round(player:get_pos())
        local fy   = b.y - 1
        local z0   = b.z + 2
        local W    = 5                -- half-width (x: -5..5)
        local DEEP = 9                -- depth (z: 0..9)
        local floor = L("stroh")
        local wall  = L("scheunenwand")
        local roof  = L("scheunendach")

        -- barn shell
        for dx = -W, W do
            for dz = 0, DEEP do
                local x, z = b.x + dx, z0 + dz
                core.set_node({ x = x, y = fy, z = z }, { name = floor })
                local edge = (dx == -W or dx == W or dz == 0 or dz == DEEP)
                for dy = 1, 4 do
                    local door = (dz == 0 and dx == 0 and dy <= 2)   -- doorway
                    if edge and not door then
                        local mat = (dy == 4) and roof or wall
                        core.set_node({ x = x, y = fy + dy, z = z }, { name = mat })
                    elseif dy == 4 then
                        core.set_node({ x = x, y = fy + dy, z = z }, { name = roof }) -- ceiling
                    end
                end
            end
        end

        -- timber-frame pillars in the four corners
        for _, c in ipairs({ { -W, 0 }, { W, 0 }, { -W, DEEP }, { W, DEEP } }) do
            for dy = 1, 3 do
                core.set_node({ x = b.x + c[1], y = fy + dy, z = z0 + c[2] },
                    { name = L("holzbalken") })
            end
        end

        -- three learning boards along the back wall (inside)
        local xs = { -3, 0, 3 }
        for i, board in ipairs(BOARDS) do
            if core.registered_nodes[board] then
                core.set_node({ x = b.x + xs[i], y = fy + 1, z = z0 + DEEP - 1 },
                    { name = board, param2 = 2 })
            end
        end

        -- a small ploughed FIELD on the left, already sown with weizen
        for dx = -W + 1, -W + 3 do
            for dz = 2, 5 do
                local fp = { x = b.x + dx, y = fy, z = z0 + dz }
                core.set_node(fp, { name = L("ackererde") })
                local sp = { x = fp.x, y = fp.y + 1, z = fp.z }
                core.set_node(sp, { name = L("weizen_1") })
                core.get_node_timer(sp):start(WEIZEN_GROWTIME)
            end
        end

        -- a fenced TIERGEHEGE on the right (open square of weidezaun)
        local gx0, gz0, GSZ = b.x + 2, z0 + 2, 3
        for d = 0, GSZ do
            core.set_node({ x = gx0 + d,   y = fy + 1, z = gz0 },       { name = L("weidezaun") })
            core.set_node({ x = gx0 + d,   y = fy + 1, z = gz0 + GSZ }, { name = L("weidezaun") })
            core.set_node({ x = gx0,       y = fy + 1, z = gz0 + d },   { name = L("weidezaun") })
            core.set_node({ x = gx0 + GSZ, y = fy + 1, z = gz0 + d },   { name = L("weidezaun") })
        end

        -- the Zaubermuehle (front-middle) and a Futtertrog (in the pen)
        core.set_node({ x = b.x, y = fy + 1, z = z0 + 2 }, { name = L("muehle") })
        core.set_node({ x = gx0 + 1, y = fy + 1, z = gz0 + 1 }, { name = L("futtertrog") })

        -- a hay bale, a lantern and a couple of sunflowers for flair
        core.set_node({ x = b.x - 1, y = fy + 1, z = z0 + 1 }, { name = L("strohballen") })
        core.set_node({ x = b.x + 1, y = fy + 4, z = z0 + 4 }, { name = L("hoflaterne") })
        core.set_node({ x = b.x - W + 4, y = fy + 1, z = z0 + 6 }, { name = L("sonnenblume") })
        core.set_node({ x = b.x - W + 4, y = fy + 1, z = z0 + 7 }, { name = L("sonnenblume") })

        return true, "Bauernhof gebaut! Links das Weizen-Feld (giesse es mit der " ..
                     "Zauber-Giesskanne!), in der Mitte die Zaubermuehle, rechts das " ..
                     "Tiergehege mit Futtertrog, hinten die drei Lern-Tafeln. Setze " ..
                     "Spawn-Eier ins Gehege und leg los: vom Samen zum Brot!"
    end,
})

-- A small test station: a straw floor, the three boards, a field, a
-- mill, a trough and a sunflower.
core.register_chatcommand("sonnenhof_teststation", {
    description = "Baut eine kleine Test-Station vor dir (Boden, 3 Lern-Tafeln, " ..
                  "Weizen-Feld, Zaubermuehle, Futtertrog)",
    privs = { server = true },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then return false, "Dieser Befehl funktioniert nur im Spiel." end
        local base    = vector.round(player:get_pos())
        local floor_y = base.y - 1

        for dx = -3, 3 do
            for dz = 2, 6 do
                core.set_node({ x = base.x + dx, y = floor_y, z = base.z + dz },
                    { name = L("stroh") })
            end
        end

        -- the three learning boards, panels facing back to you
        local xs = { -2, 0, 2 }
        for i, board in ipairs(BOARDS) do
            if core.registered_nodes[board] then
                core.set_node({ x = base.x + xs[i], y = floor_y + 1, z = base.z + 6 },
                    { name = board, param2 = 2 })
            end
        end

        -- a little field, the mill, a trough and a sunflower
        for dz = 2, 3 do
            local fp = { x = base.x - 2, y = floor_y, z = base.z + dz }
            core.set_node(fp, { name = L("ackererde") })
            local sp = { x = fp.x, y = fp.y + 1, z = fp.z }
            core.set_node(sp, { name = L("weizen_1") })
            core.get_node_timer(sp):start(WEIZEN_GROWTIME)
        end
        core.set_node({ x = base.x,     y = floor_y + 1, z = base.z + 4 }, { name = L("muehle") })
        core.set_node({ x = base.x + 2, y = floor_y + 1, z = base.z + 3 }, { name = L("futtertrog") })
        core.set_node({ x = base.x + 2, y = floor_y + 1, z = base.z + 5 }, { name = L("sonnenblume") })

        return true, "Test-Station gebaut! Drei Lern-Tafeln, ein Weizen-Feld, die " ..
                     "Zaubermuehle, ein Futtertrog und eine Sonnenblume stehen vor dir " ..
                     "(Richtung +Z)."
    end,
})

-- ------------------------------------------------------------
--  K) EXTRA: AMBIENT-SOUND  (rooster crow / gentle farm sounds)
--  Plays a gentle farm sound to each player now and then. The
--  .ogg files are optional (missing = silent, only a warning).
-- ------------------------------------------------------------
local amb_timer, amb_next = 0, 45
core.register_globalstep(function(dtime)
    amb_timer = amb_timer + dtime
    if amb_timer < amb_next then return end
    amb_timer = 0
    amb_next = 35 + math.random(0, 40)
    for _, player in ipairs(core.get_connected_players()) do
        local snd = (math.random() < 0.5) and "_hahn" or "_ambient"
        core.sound_play(WORLD_ID .. snd, { to_player = player:get_player_name(), gain = 0.4 })
    end
end)

core.log("action", "[lernwelt_sonnenhof] Theme 'Sonnenhof' registered (on lernwelt engine). " ..
    "Farming Redo: " .. tostring(HAS_FARMING) .. ", Animalia: " .. tostring(HAS_ANIMALIA) .. ".")
