-- ============================================================
--  THEME:  SCHRAUBER-WERKSTATT  (robots & simple logic)
--  A brand-free "tinkerer's workshop" learning world built ON
--  TOP of the reusable "lernwelt" engine. Almost everything is
--  one declarative register_world{...} call - blocks, learning
--  zones, repairable robots, logbook, ranks and badges all come
--  from the engine.
--
--  The theme's heart is SIMPLE LOGIC and CAUSE & EFFECT - the
--  direct bridge to MESECONS. Kids wire up a self-contained
--  signal system (Schalter -> Leitung -> Lampe -> Tuer) and watch
--  cause produce effect ("wenn-dann"). If the optional Mesecons
--  mod is installed, the same switch and lamp ALSO talk to real
--  Mesecons wires - so this world is a gentle on-ramp to it.
--  (Lehrplan 21: Medien & Informatik - Informatik-Grundlagen.)
--
--  Things the engine cannot express live as small pieces of
--  custom code after register_world:
--    A) the signal system (switch/button/wire/lamp/door) + the
--       optional Mesecons bridge
--    B) building a ROBOT in the right ORDER (an algorithm:
--       Beine -> Koerper -> Arme -> Kopf), which then walks &
--       follows you
--    C) a FLIESSBAND (conveyor) that pushes you and things along
--       (cause & effect you can stand on)
--    D) a RECYCLER + scrap heaps (Materialkreislauf: scrap ->
--       new robot parts)
--    E) a starter kit handed out on first join (quick testing)
--    F) a robot land-spawner so robots appear to be repaired
--    ...plus test/base commands, ambient sound and letter blocks.
--
--  The mod name equals the world id ("lernwelt_schrauber"), so
--  all nodes/items live in the "lernwelt_schrauber:" namespace.
--
--  Content is authored in German (ASCII: ae/oe/ue), like the
--  other example themes. The engine's own UI is translated
--  separately via lernwelt/locale/*.tr.
-- ============================================================

local WORLD_ID = "lernwelt_schrauber"
local function L(suffix) return WORLD_ID .. ":" .. suffix end

-- ------------------------------------------------------------
--  A) THE WHOLE LEARNING WORLD AS ONE DECLARATIVE TABLE
-- ------------------------------------------------------------
lernwelt.register_world({

    -- internal prefix; kept identical to the mod name so all
    -- nodes/items live in the "lernwelt_schrauber:" namespace
    id    = WORLD_ID,
    title = "Schrauber-Werkstatt",

    -- --- 1) Peaceful, child-friendly world ---
    config = {
        damage      = false,   -- no damage / no dying
        creative    = true,    -- unlimited blocks
        peaceful    = true,    -- no monsters
        freeze_time = "day",   -- always bright (a tidy, lit workshop)
        no_weather  = true,
    },

    -- --- 2) Workshop blocks (no PNG needed, procedural patterns) ---
    blocks = {
        -- A real workbench (per-face: tools on top, plain steel sides).
        { suffix = "werkbank", name = "Werkbank",
          top    = "[fill:16x16:#8d6e3a^[fill:14x2:1,4:#5d4037^[fill:4x4:2,8:#7f8c8d" ..
                   "^[fill:6x2:8,9:#566573^[fill:2x6:12,6:#95a5a6",
          side   = "[fill:16x16:#7e5109^[fill:16x2:0,5:#5d4037^[fill:16x2:0,11:#5d4037",
          bottom = "[fill:16x16:#5d4037" },

        { suffix = "stahlplatte", name = "Stahlplatte", color = "#95a5a6" },
        { suffix = "riffelblech", name = "Riffelblech",
          texture = "[fill:16x16:#7f8c8d^[fill:3x3:1,1:#95a5a6^[fill:3x3:7,4:#95a5a6" ..
                    "^[fill:3x3:13,1:#95a5a6^[fill:3x3:4,9:#95a5a6^[fill:3x3:10,9:#95a5a6" ..
                    "^[fill:3x3:1,13:#95a5a6^[fill:3x3:13,13:#95a5a6" },
        { suffix = "schraubenkiste", name = "Schraubenkiste",
          texture = "[fill:16x16:#566573^[fill:3x3:2,2:#bdc3c7^[fill:3x3:7,2:#bdc3c7" ..
                    "^[fill:3x3:12,2:#bdc3c7^[fill:3x3:2,7:#bdc3c7^[fill:3x3:7,7:#bdc3c7" ..
                    "^[fill:3x3:12,7:#bdc3c7^[fill:3x3:2,12:#bdc3c7^[fill:3x3:7,12:#bdc3c7" ..
                    "^[fill:3x3:12,12:#bdc3c7" },
        { suffix = "zahnrad_block", name = "Zahnrad-Block",
          texture = "[fill:16x16:#34495e^[fill:8x8:4,4:#95a5a6^[fill:4x4:6,1:#95a5a6" ..
                    "^[fill:4x4:6,11:#95a5a6^[fill:4x4:1,6:#95a5a6^[fill:4x4:11,6:#95a5a6" ..
                    "^[fill:4x4:6,6:#34495e" },
        { suffix = "warnband", name = "Warnband (gelb-schwarz)",
          texture = "[fill:16x16:#f1c40f^[fill:4x16:0,0:#1a1a1a^[fill:4x16:8,0:#1a1a1a" },
        { suffix = "bodenfliese", name = "Bodenfliese",
          texture = "[fill:16x16:#95a5a6^[fill:8x8:0,0:#7f8c8d^[fill:8x8:8,8:#7f8c8d" },
        { suffix = "kabelkanal", name = "Kabelkanal",
          texture = "[fill:16x16:#2c3e50^[fill:4x16:2,0:#e74c3c^[fill:4x16:7,0:#f1c40f" ..
                    "^[fill:4x16:12,0:#3498db" },
        { suffix = "glaswand", name = "Glaswand", color = "#aed6f1", glass = true },

        -- A glowing energy block for the Energieraum.
        { suffix = "energie_block", name = "Energie-Block",
          texture = "[fill:16x16:#1b4f72^[fill:8x8:4,4:#5dade2^[fill:4x4:6,6:#aed6f1",
          glow = 10 },

        -- Coloured robot sheet metal (build your own robots & machines).
        { suffix = "roboblech_blau", name = "Roboterblech (blau)",
          texture = "[fill:16x16:#2980b9^[fill:3x3:2,2:#1f618d^[fill:3x3:11,2:#1f618d" ..
                    "^[fill:3x3:2,11:#1f618d^[fill:3x3:11,11:#1f618d" },
        { suffix = "roboblech_rot", name = "Roboterblech (rot)",
          texture = "[fill:16x16:#c0392b^[fill:3x3:2,2:#922b21^[fill:3x3:11,2:#922b21" ..
                    "^[fill:3x3:2,11:#922b21^[fill:3x3:11,11:#922b21" },
        { suffix = "roboblech_gelb", name = "Roboterblech (gelb)",
          texture = "[fill:16x16:#f1c40f^[fill:3x3:2,2:#b7950b^[fill:3x3:11,2:#b7950b" ..
                    "^[fill:3x3:2,11:#b7950b^[fill:3x3:11,11:#b7950b" },

        -- Eigenes gemaltes Bild als Block? Lege eine PNG (16x16 oder 32x32)
        -- "lernwelt_schrauber_meinbild.png" in den textures/-Ordner und entferne
        -- die zwei Minuszeichen vor der naechsten Zeile:
        -- { suffix = "meinbild", name = "Mein Bild", texture = "lernwelt_schrauber_meinbild.png" },
    },

    -- --- 3) Learning zones (each gets a placeable learning board) ---
    -- Zone titles double as the "habitat" shown in the logbook.
    zones = {
        {
            id = "fliessband", title = "Fliessband", color = "#e67e22",
            activity = "Am Fliessband bewegt sich alles weiter - eine Maschine wirkt. " ..
                       "Lerne Ursache & Wirkung und baue einen Roboter in der richtigen " ..
                       "Reihenfolge zusammen (das ist ein kleiner Algorithmus).",
            lehrplan = { "MI.1", "MI.3", "TTG.2" },
            tasks = {
                { type = "quiz",
                  question = "Was macht ein Fliessband? Es ... Dinge.",
                  options = { "bewegt", "isst", "singt" }, answer = 1,
                  done = "Richtig! Ein Fliessband bewegt Dinge weiter - Ursache und Wirkung." },
                { type = "pattern",
                  -- The robot build order as colours: Beine - Koerper - Arme.
                  sequence = { "#2980b9", "#7f8c8d", "#e67e22" },
                  palette  = { { "#2980b9", "Beine" }, { "#7f8c8d", "Koerper" },
                               { "#e67e22", "Arme" } },
                  done = "Super! Reihenfolge: Beine - Koerper - Arme. Das ist ein Algorithmus." },
                { type = "rescue", creature = "rollbot", count = 2,
                  done = "Stark! Zwei Rollbots repariert." },
            },
        },
        {
            id = "energieraum", title = "Energieraum", color = "#3498db",
            activity = "Hier fliesst der Strom: Schalter -> Leitung -> Lampe -> Tuer. " ..
                       "Leg den Schalter um und sieh, was passiert (wenn-dann). " ..
                       "Das ist die Bruecke zu Mesecons!",
            lehrplan = { "MI.1", "MI.2" },
            tasks = {
                { type = "quiz",
                  question = "Du legst den Schalter um. Was passiert mit der Lampe?",
                  options = { "Sie geht an", "Sie verschwindet", "Nichts, nie" }, answer = 1,
                  done = "Genau! Schalter an -> Lampe an. Ursache und Wirkung (wenn-dann)." },
                { type = "quiz",
                  question = "Schalter -> Lampe -> Tuer. Was steuert hier die Tuer?",
                  options = { "Der Schalter", "Die Sonne", "Der Hunger" }, answer = 1,
                  done = "Richtig! Der Schalter steuert ueber die Leitung Lampe und Tuer." },
                { type = "rescue", creature = "funkenbot", count = 1,
                  done = "Toll! Den Funkenbot wieder zum Leuchten gebracht." },
            },
        },
        {
            id = "recyclinghof", title = "Recyclinghof", color = "#27ae60",
            activity = "Aus Alt mach Neu: Schrott in den Recycler stecken und ein " ..
                       "neues Bauteil herausholen. So schliesst sich der Materialkreislauf.",
            lehrplan = { "MI.1", "NMG.4", "TTG.2" },
            tasks = {
                { type = "quiz",
                  question = "Du steckst Schrott in den Recycler. Was kommt heraus?",
                  options = { "Ein Bauteil", "Wasser", "Ein Lied" }, answer = 1,
                  done = "Richtig! Aus Schrott wird ein neues Bauteil - Ursache und Wirkung." },
                { type = "quiz",
                  question = "Warum recyceln wir Material?",
                  options = { "Zum Wiederverwenden", "Zum Spass kaputtmachen", "Gar nicht noetig" },
                  answer = 1,
                  done = "Genau! Recyceln spart Material - der Kreislauf beginnt von vorn." },
                { type = "rescue", creature = "sammelbot", count = 2,
                  done = "Klasse! Zwei Sammelbots repariert." },
            },
        },
    },

    -- --- 4) Repairable robots (peaceful; right-click = repair) ---
    --  Reusing the engine's gentle "rescue" loop: a right-click
    --  fixes the robot, gives sparks, a sound, a counter entry and
    --  a rank. (Themed as "reparieren".)
    creatures = {
        {
            id = "rollbot", name = "Rollbot", zone = "fliessband",
            color = "#2980b9", size = 0.8, speed = 1.2,
            food = "Strom", power = "Rollt auf Raedern ueber das Fliessband",
            heart = "#5dade2",
            rescue_text = "Du ziehst eine Schraube nach - der Rollbot rollt wieder los!",
        },
        {
            id = "greifbot", name = "Greifbot", zone = "fliessband",
            color = "#e67e22", size = 0.9, speed = 0.9, family = 1,
            food = "Schmieroel", power = "Greift Bauteile mit dem Arm",
            heart = "#f8c471",
            rescue_text = "Geoelt und repariert - der Greifbot greift wieder zu.",
        },
        {
            id = "sortierbot", name = "Sortierbot", zone = "fliessband",
            color = "#16a085", size = 0.8, speed = 1.0,
            food = "Strom", power = "Sortiert Teile in die richtige Kiste",
            heart = "#76d7c4",
            rescue_text = "Der Sortierbot piept zufrieden und sortiert weiter.",
        },
        {
            id = "funkenbot", name = "Funkenbot", zone = "energieraum",
            color = "#f1c40f", size = 0.9, speed = 1.0, glow = 9,
            food = "Strom", power = "Schweisst mit warmen (harmlosen) Funken",
            heart = "#fff2a8",
            rescue_text = "Der Funkenbot leuchtet wieder hell - repariert!",
        },
        {
            id = "lampenbot", name = "Lampenbot", zone = "energieraum",
            color = "#f39c12", size = 0.7, speed = 1.1, glow = 11,
            food = "Strom", power = "Eine wandelnde Lampe",
            heart = "#fdebd0",
            rescue_text = "Klick - der Lampenbot geht wieder an.",
        },
        {
            id = "schaltbot", name = "Schaltbot", zone = "energieraum",
            color = "#3498db", size = 0.8, speed = 1.0, family = 1,
            food = "Strom", power = "Schaltet kleine Stromkreise",
            heart = "#aed6f1",
            rescue_text = "Der Schaltbot macht klick-klick und laeuft wieder.",
        },
        {
            id = "sammelbot", name = "Sammelbot", zone = "recyclinghof",
            color = "#27ae60", size = 0.9, speed = 0.9,
            food = "Strom", power = "Sammelt Schrott ein",
            heart = "#82e0aa",
            rescue_text = "Der Sammelbot brummt und sammelt wieder Schrott.",
        },
        {
            id = "pressbot", name = "Pressbot", zone = "recyclinghof",
            color = "#7f8c8d", size = 1.1, speed = 0.6,
            food = "Schmieroel", power = "Presst Schrott zu kleinen Wuerfeln",
            heart = "#d6dbdf",
            rescue_text = "Der grosse Pressbot stampft wieder - repariert!",
        },
        {
            id = "putzbot", name = "Putzbot", zone = "recyclinghof",
            color = "#9b59b6", size = 0.7, speed = 1.3,
            food = "Strom", power = "Haelt den Hof sauber",
            heart = "#d2b4ff",
            rescue_text = "Der Putzbot surrt los und wischt wieder.",
        },
        {
            -- legendary, rare: never auto-spawns (egg/manual only)
            id = "meisterbot", name = "Meisterbot", zone = "energieraum",
            color = "#f9e79f", size = 1.2, speed = 0.9, glow = 13, rare = true,
            food = "Gold-Strom", power = "Der seltene, goldene Meisterroboter",
            heart = "#fff2a8",
            rescue_text = "Der legendaere Meisterbot verneigt sich - du bist Robotermeister!",
        },
    },

    -- --- 5) Ranks (3rd field = colour -> creates a badge item) ---
    ranks = {
        { 0,  "Schrauber-Lehrling" },
        { 5,  "Bastler" },
        { 10, "Techniker",      "#3498db" },
        { 25, "Ingenieur",      "#27ae60" },
        { 50, "Robotermeister", "#f1c40f" },
    },

    -- --- 6) Logbook item ---
    logbook = { title = "Roboter-Katalog", item_color = "#3498db" },

    -- --- 7) Plain texts for curriculum codes (for /lernplan & boards) ---
    kompetenzen = {
        ["MI.1"]  = "Informatik-Grundlagen: Ursache und Wirkung erkennen (wenn-dann)",
        ["MI.2"]  = "Einfache Logik: Schalter steuert Lampe und Tuer (Signal)",
        ["MI.3"]  = "Algorithmus: Schritte in der richtigen Reihenfolge ausfuehren",
        ["TTG.2"] = "Technik: Bauteile erkennen und zusammenbauen",
        ["NMG.4"] = "Materialkreislauf: wiederverwerten und recyceln",
    },
})

-- ============================================================
--  THEME EXTRAS  (self-contained Lua the engine cannot express)
-- ============================================================

local HAS_MESECON = core.global_exists("mesecon")

-- ------------------------------------------------------------
--  A) THE SIGNAL SYSTEM  (Schalter -> Leitung -> Lampe -> Tuer)
--  A small, self-contained "mini-Mesecons" so the world works on
--  its own AND teaches the idea before the real thing. A network
--  is any connected run of logic nodes (6-neighbour). It is
--  "powered" if ANY switch/button in it is ON; then every lamp
--  lights, every door opens and the wire glows. Flip the switch
--  back and everything turns off again - pure cause & effect.
--
--  MESECONS BRIDGE: if the Mesecons mod is installed, the switch
--  also acts as a real Mesecons receptor and the lamp/door as
--  real effectors - so they interoperate with real Mesecons wire.
--  Without Mesecons, none of that loads and the mini-system runs
--  on its own.
-- ------------------------------------------------------------
local recompute   -- forward declaration

local LOGIC = {}  -- full nodename -> true (member of the signal network)
local function add_logic(suffix) LOGIC[L(suffix)] = true end
for _, s in ipairs({ "schalter_aus", "schalter_an", "taster_aus", "taster_an",
                     "leitung", "leitung_an", "lampe_aus", "lampe_an",
                     "tuer_zu", "tuer_auf" }) do
    add_logic(s)
end
local function is_source(name) return name == L("schalter_an") or name == L("taster_an") end

local DIRS = {
    { 1, 0, 0 }, { -1, 0, 0 }, { 0, 1, 0 }, { 0, -1, 0 }, { 0, 0, 1 }, { 0, 0, -1 },
}

-- Flood-fill the connected network from "start", decide if it is
-- powered, then update every lamp/door/wire to match.
recompute = function(start)
    local seen, comp = {}, {}
    local stack = { { x = start.x, y = start.y, z = start.z } }
    local function key(p) return p.x .. "," .. p.y .. "," .. p.z end
    seen[key(start)] = true
    while #stack > 0 do
        local p    = table.remove(stack)
        local name = core.get_node(p).name
        if LOGIC[name] then
            comp[#comp + 1] = { pos = p, name = name }
            if #comp > 600 then break end   -- safety cap
            for _, d in ipairs(DIRS) do
                local np = { x = p.x + d[1], y = p.y + d[2], z = p.z + d[3] }
                local k  = key(np)
                if not seen[k] then seen[k] = true; stack[#stack + 1] = np end
            end
        end
    end

    local powered = false
    for _, e in ipairs(comp) do
        if is_source(e.name) then powered = true; break end
    end

    for _, e in ipairs(comp) do
        local p2   = core.get_node(e.pos).param2
        local want
        if e.name == L("lampe_an") or e.name == L("lampe_aus") then
            want = powered and L("lampe_an") or L("lampe_aus")
        elseif e.name == L("tuer_auf") or e.name == L("tuer_zu") then
            want = powered and L("tuer_auf") or L("tuer_zu")
        elseif e.name == L("leitung") or e.name == L("leitung_an") then
            want = powered and L("leitung_an") or L("leitung")
        end
        if want and e.name ~= want then
            core.swap_node(e.pos, { name = want, param2 = p2 })
        end
    end
end

-- Recompute after placing/removing a logic node, so building or
-- breaking a wire instantly updates the circuit.
local function logic_after_place(pos) recompute(pos) end
local function logic_after_dig(pos)
    for _, d in ipairs(DIRS) do
        local np = { x = pos.x + d[1], y = pos.y + d[2], z = pos.z + d[3] }
        if LOGIC[core.get_node(np).name] then recompute(np) end
    end
end

-- Toggle a switch (and, if present, drive real Mesecons too).
local function set_switch(pos, on)
    local p2 = core.get_node(pos).param2
    core.swap_node(pos, { name = on and L("schalter_an") or L("schalter_aus"), param2 = p2 })
    if HAS_MESECON then
        if on then mesecon.receptor_on(pos, mesecon.rules.alldirs)
        else       mesecon.receptor_off(pos, mesecon.rules.alldirs) end
    end
    recompute(pos)
end

-- A small helper so the optional Mesecons fields are only added
-- when Mesecons is actually installed. The builder is a function
-- (only called when Mesecons exists), so the "mesecon.*" lookups
-- inside it never run on a game without Mesecons.
local function with_mesecon(def, builder)
    if HAS_MESECON then def.mesecons = builder() end
    return def
end

-- --- Schalter (switch): right-click toggles, stays put ---
core.register_node(L("schalter_aus"), with_mesecon({
    description       = "Schalter\nRechtsklick: ein-/ausschalten",
    tiles             = { "[fill:16x16:#34495e^[fill:8x8:4,4:#566573^[fill:4x6:6,8:#c0392b" },
    paramtype2        = "facedir",
    groups            = { cracky = 3, oddly_breakable_by_hand = 2 },
    is_ground_content = false,
    on_rightclick     = function(pos) set_switch(pos, true) end,
    after_place_node  = function(pos) logic_after_place(pos) end,
    after_dig_node    = function(pos) logic_after_dig(pos) end,
}, function() return { receptor = { state = mesecon.state.off, rules = mesecon.rules.alldirs } } end))

core.register_node(L("schalter_an"), with_mesecon({
    description       = "Schalter (an)",
    tiles             = { "[fill:16x16:#34495e^[fill:8x8:4,4:#566573^[fill:4x6:6,2:#27ae60" },
    paramtype         = "light",
    paramtype2        = "facedir",
    light_source      = 4,
    groups            = { cracky = 3, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1 },
    drop              = L("schalter_aus"),
    is_ground_content = false,
    on_rightclick     = function(pos) set_switch(pos, false) end,
    after_place_node  = function(pos) logic_after_place(pos) end,
    after_dig_node    = function(pos) logic_after_dig(pos) end,
}, function() return { receptor = { state = mesecon.state.on, rules = mesecon.rules.alldirs } } end))

-- --- Taster (push button): pulses ON for a few seconds ---
local TASTER_TIME = 3

core.register_node(L("taster_aus"), with_mesecon({
    description       = "Taster (Druckknopf)\nRechtsklick: kurzer Strom-Impuls",
    tiles             = { "[fill:16x16:#34495e^[fill:10x10:3,3:#7f8c8d^[fill:6x6:5,5:#c0392b" },
    paramtype2        = "facedir",
    groups            = { cracky = 3, oddly_breakable_by_hand = 2 },
    is_ground_content = false,
    on_rightclick     = function(pos)
        local p2 = core.get_node(pos).param2
        core.swap_node(pos, { name = L("taster_an"), param2 = p2 })
        if HAS_MESECON then mesecon.receptor_on(pos, mesecon.rules.alldirs) end
        core.get_node_timer(pos):start(TASTER_TIME)
        recompute(pos)
    end,
    after_place_node  = function(pos) logic_after_place(pos) end,
    after_dig_node    = function(pos) logic_after_dig(pos) end,
}, function() return { receptor = { state = mesecon.state.off, rules = mesecon.rules.alldirs } } end))

core.register_node(L("taster_an"), with_mesecon({
    description       = "Taster (gedrueckt)",
    tiles             = { "[fill:16x16:#34495e^[fill:10x10:3,3:#7f8c8d^[fill:6x6:5,5:#2ecc71" },
    paramtype         = "light",
    paramtype2        = "facedir",
    light_source      = 4,
    groups            = { cracky = 3, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1 },
    drop              = L("taster_aus"),
    is_ground_content = false,
    on_timer          = function(pos)
        local p2 = core.get_node(pos).param2
        core.swap_node(pos, { name = L("taster_aus"), param2 = p2 })
        if HAS_MESECON then mesecon.receptor_off(pos, mesecon.rules.alldirs) end
        recompute(pos)
        return false
    end,
    after_place_node  = function(pos) logic_after_place(pos) end,
    after_dig_node    = function(pos) logic_after_dig(pos) end,
}, function() return { receptor = { state = mesecon.state.on, rules = mesecon.rules.alldirs } } end))

-- --- Leitung (wire): a flat track that carries the signal ---
local WIRE_BOX = { type = "fixed", fixed = { -0.5, -0.5, -0.5, 0.5, -0.4, 0.5 } }

core.register_node(L("leitung"), {
    description         = "Leitung (Strom-Kabel)\nVerbindet Schalter mit Lampe und Tuer",
    drawtype            = "nodebox",
    node_box            = WIRE_BOX,
    selection_box       = WIRE_BOX,
    tiles               = { "[fill:16x16:#2c3e50^[fill:16x4:0,6:#566573" },
    paramtype           = "light",
    sunlight_propagates = true,
    groups              = { cracky = 3, oddly_breakable_by_hand = 2 },
    is_ground_content   = false,
    after_place_node    = function(pos) logic_after_place(pos) end,
    after_dig_node      = function(pos) logic_after_dig(pos) end,
})

core.register_node(L("leitung_an"), {
    description         = "Leitung (unter Strom)",
    drawtype            = "nodebox",
    node_box            = WIRE_BOX,
    selection_box       = WIRE_BOX,
    tiles               = { "[fill:16x16:#2c3e50^[fill:16x4:0,6:#f1c40f" },
    paramtype           = "light",
    light_source        = 5,
    sunlight_propagates = true,
    groups              = { cracky = 3, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1 },
    drop                = L("leitung"),
    is_ground_content   = false,
    after_place_node    = function(pos) logic_after_place(pos) end,
    after_dig_node      = function(pos) logic_after_dig(pos) end,
})

-- --- Lampe (lamp): the classic effect of a switch ---
local function lamp_set(pos, on)   -- used by the Mesecons effector
    local p2 = core.get_node(pos).param2
    core.swap_node(pos, { name = on and L("lampe_an") or L("lampe_aus"), param2 = p2 })
end

core.register_node(L("lampe_aus"), with_mesecon({
    description       = "Lampe\nLeuchtet, wenn Strom anliegt",
    tiles             = { "[fill:16x16:#566573^[fill:10x10:3,3:#7f8c8d" },
    groups            = { cracky = 3, oddly_breakable_by_hand = 2 },
    is_ground_content = false,
    after_place_node  = function(pos) logic_after_place(pos) end,
    after_dig_node    = function(pos) logic_after_dig(pos) end,
}, function() return { effector = { action_on = function(pos) lamp_set(pos, true) end,
                  rules = mesecon.rules.alldirs } } end))

core.register_node(L("lampe_an"), with_mesecon({
    description       = "Lampe (an)",
    tiles             = { "[fill:16x16:#f7dc6f^[fill:10x10:3,3:#fff2a8" },
    paramtype         = "light",
    light_source      = 13,
    groups            = { cracky = 3, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1 },
    drop              = L("lampe_aus"),
    is_ground_content = false,
    after_place_node  = function(pos) logic_after_place(pos) end,
    after_dig_node    = function(pos) logic_after_dig(pos) end,
}, function() return { effector = { action_off = function(pos) lamp_set(pos, false) end,
                  rules = mesecon.rules.alldirs } } end))

-- --- Tuer (door): a metal door that opens when powered ---
local function door_set(pos, on)   -- used by the Mesecons effector
    local p2 = core.get_node(pos).param2
    core.swap_node(pos, { name = on and L("tuer_auf") or L("tuer_zu"), param2 = p2 })
end

local DOOR_FRAME = {
    type = "fixed",
    fixed = {
        { -0.5, -0.5, -0.1, -0.4, 0.5, 0.1 },
        {  0.4, -0.5, -0.1,  0.5, 0.5, 0.1 },
        { -0.5,  0.4, -0.1,  0.5, 0.5, 0.1 },
    },
}

core.register_node(L("tuer_zu"), with_mesecon({
    description       = "Tuer\nOeffnet sich, wenn Strom anliegt",
    paramtype2        = "facedir",
    tiles             = { "[fill:16x16:#5d4037^[fill:12x14:2,1:#7f8c8d^[fill:3x3:11,7:#f1c40f" },
    groups            = { cracky = 3, oddly_breakable_by_hand = 2 },
    is_ground_content = false,
    after_place_node  = function(pos) logic_after_place(pos) end,
    after_dig_node    = function(pos) logic_after_dig(pos) end,
}, function() return { effector = { action_on = function(pos) door_set(pos, true) end,
                  rules = mesecon.rules.alldirs } } end))

core.register_node(L("tuer_auf"), with_mesecon({
    description         = "Tuer (offen)",
    drawtype            = "nodebox",
    node_box            = DOOR_FRAME,
    selection_box       = { type = "fixed", fixed = { -0.5, -0.5, -0.1, 0.5, 0.5, 0.1 } },
    paramtype           = "light",
    paramtype2          = "facedir",
    sunlight_propagates = true,
    walkable            = false,
    tiles               = { "[fill:16x16:#5d4037^[fill:6x6:5,5:#7f8c8d" },
    groups              = { cracky = 3, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1 },
    drop                = L("tuer_zu"),
    is_ground_content   = false,
    after_place_node    = function(pos) logic_after_place(pos) end,
    after_dig_node      = function(pos) logic_after_dig(pos) end,
}, function() return { effector = { action_off = function(pos) door_set(pos, false) end,
                  rules = mesecon.rules.alldirs } } end))

-- ------------------------------------------------------------
--  B) ROBOTER ZUSAMMENBAUEN  (an algorithm: parts in order)
--  The theme's signature MI feature. Place a "Roboter-Bausatz"
--  to drop a robot frame, then add the parts in the RIGHT ORDER
--  (Beine -> Koerper -> Arme -> Kopf). A wrong part is refused
--  with a hint - the order IS the algorithm. After all four parts
--  the robot powers on, glows and follows you. Fully self-
--  contained, so it works even without any mob API.
-- ------------------------------------------------------------
local ROBOT_COLORS = { "#2980b9", "#e67e22", "#16a085", "#9b59b6", "#c0392b", "#7f8c8d" }

-- Build order. Each entry: { item suffix, friendly name }.
local PARTS = {
    { "teil_beine",   "Beine" },
    { "teil_koerper", "Koerper" },
    { "teil_arme",    "Arme" },
    { "teil_kopf",    "Kopf" },
}

local function robot_textures(step, col)
    col = col or "#7f8c8d"
    local s = "[fill:16x16:" .. col
    local face
    if step >= 4 then
        -- a friendly robot face once the head is on
        face = "[fill:16x16:" .. col .. "^[fill:10x4:3,3:#1a1a1a^[fill:3x3:4,4:#5dade2" ..
               "^[fill:3x3:9,4:#5dade2^[fill:8x2:4,11:#1a1a1a"
    else
        face = s
    end
    return { s, s, s, s, face, s }
end

local function robot_size(step)
    local v = 0.4 + 0.12 * step   -- grows as parts are added
    return { x = v, y = v, z = v }
end

core.register_entity(L("roboter"), {
    initial_properties = {
        physical = true, collide_with_objects = false,
        collisionbox = { -0.3, -0.3, -0.3, 0.3, 0.3, 0.3 },
        visual = "cube", visual_size = robot_size(0),
        textures = robot_textures(0, "#7f8c8d"),
        static_save = true,
    },
    _step = 0, _active = false, _owner = nil, _color = "#7f8c8d", _wander = 0,

    on_activate = function(self, staticdata)
        if staticdata and staticdata ~= "" then
            local d = core.deserialize(staticdata)
            if type(d) == "table" then
                self._step   = d.step or 0
                self._active = d.active or false
                self._owner  = d.owner
                self._color  = d.color or "#7f8c8d"
            end
        end
        self.object:set_properties({
            textures    = robot_textures(self._step, self._color),
            visual_size = robot_size(self._step),
            glow        = self._active and 8 or 0,
        })
        self.object:set_acceleration({ x = 0, y = -8, z = 0 })
    end,

    get_staticdata = function(self)
        return core.serialize({
            step = self._step, active = self._active,
            owner = self._owner, color = self._color,
        })
    end,

    on_rightclick = function(self, clicker)
        if not (clicker and clicker:is_player()) then return end
        local name = clicker:get_player_name()

        if self._active then
            core.chat_send_player(name, self._owner == name
                and "Dein Roboter ist fertig und folgt dir!"
                or  "Dieser Roboter gehoert schon zu " .. (self._owner or "jemandem") .. ".")
            return
        end

        local nextpart = PARTS[self._step + 1]
        local wielded  = clicker:get_wielded_item()
        if wielded:get_name() ~= L(nextpart[1]) then
            core.chat_send_player(name,
                "Reihenfolge beachten! Als Naechstes kommt: " .. nextpart[2] ..
                ". Nimm das Bauteil '" .. nextpart[2] .. "' in die Hand und mach Rechtsklick. (" ..
                self._step .. "/4 montiert)")
            return
        end

        -- Correct next part: attach it.
        self._step = self._step + 1
        if not core.is_creative_enabled(name) then
            wielded:take_item(); clicker:set_wielded_item(wielded)
        end
        self.object:set_properties({
            textures    = robot_textures(self._step, self._color),
            visual_size = robot_size(self._step),
        })
        local pos = self.object:get_pos()
        if pos then
            core.add_particlespawner({
                amount = 10, time = 0.3,
                minpos = vector.subtract(pos, 0.4), maxpos = vector.add(pos, 0.4),
                minvel = { x = -0.6, y = 1, z = -0.6 }, maxvel = { x = 0.6, y = 2, z = 0.6 },
                minexptime = 0.4, maxexptime = 0.9, minsize = 1, maxsize = 3,
                texture = "[fill:8x8:#f1c40f",
            })
        end
        core.sound_play("lernwelt_rescue", { to_player = name, gain = 0.7 })

        if self._step >= 4 then
            self._active = true
            self._owner  = name
            self.object:set_properties({ glow = 8 })
            local meta = clicker:get_meta()
            local n = meta:get_int("lernwelt_schrauber:gebaut") + 1
            meta:set_int("lernwelt_schrauber:gebaut", n)
            core.sound_play("lernwelt_rankup", { to_player = name, gain = 1.0 })
            core.chat_send_player(name,
                "Fertig zusammengebaut! Du hast die Reihenfolge Beine -> Koerper -> Arme -> " ..
                "Kopf eingehalten (ein Algorithmus). Der Roboter schaltet sich ein und folgt " ..
                "dir! Gebaute Roboter: " .. n)
        else
            core.chat_send_player(name,
                nextpart[2] .. " montiert (" .. self._step .. "/4). Als Naechstes kommt: " ..
                PARTS[self._step + 1][2] .. ".")
        end
    end,

    on_step = function(self, dtime)
        self._wander = (self._wander or 0) + dtime

        -- A finished robot follows its builder.
        if self._active and self._owner then
            local owner = core.get_player_by_name(self._owner)
            if owner then
                local p, op = self.object:get_pos(), owner:get_pos()
                if p and op then
                    local d = vector.distance(p, op)
                    if d > 2.5 and d < 30 then
                        local dir = vector.direction(p, op)
                        local v   = self.object:get_velocity()
                        self.object:set_velocity({ x = dir.x * 2, y = v.y, z = dir.z * 2 })
                        self.object:set_yaw(math.atan2(dir.z, dir.x) - math.pi / 2)
                        return
                    end
                end
            end
        end

        -- Otherwise idle: a little wander.
        if self._wander > 2 then
            self._wander = 0
            local v = self.object:get_velocity()
            self.object:set_velocity({ x = math.random(-1, 1), y = v.y, z = math.random(-1, 1) })
        end
    end,
})

-- The "Roboter-Bausatz": place it to drop a fresh robot frame.
core.register_craftitem(L("roboter_bausatz"), {
    description     = "Roboter-Bausatz (Rahmen)\nSetzen, dann der Reihe nach Bauteile " ..
                      "anbauen: Beine -> Koerper -> Arme -> Kopf",
    inventory_image = "[fill:16x16:#7f8c8d^[fill:10x10:3,3:#566573^[fill:3x3:4,5:#5dade2" ..
                      "^[fill:3x3:9,5:#5dade2",
    on_place = function(itemstack, placer, pointed_thing)
        if pointed_thing.type ~= "node" or not (placer and placer:is_player()) then
            return itemstack
        end
        local pos = pointed_thing.above
        pos.y = pos.y + 0.3
        local obj = core.add_entity(pos, L("roboter"))
        local le  = obj and obj:get_luaentity()
        if le then
            le._color = ROBOT_COLORS[math.random(#ROBOT_COLORS)]
            obj:set_properties({ textures = robot_textures(0, le._color) })
        end
        core.chat_send_player(placer:get_player_name(),
            "Roboter-Rahmen aufgestellt. Baue ihn der Reihe nach zusammen: zuerst die Beine.")
        if not core.is_creative_enabled(placer:get_player_name()) then
            itemstack:take_item()
        end
        return itemstack
    end,
})

-- The four robot parts (just items you assemble in order).
local PART_IMAGES = {
    teil_beine   = "[fill:16x16:#34495e^[fill:4x10:3,5:#2980b9^[fill:4x10:9,5:#2980b9",
    teil_koerper = "[fill:16x16:#34495e^[fill:10x10:3,3:#7f8c8d^[fill:4x4:6,6:#566573",
    teil_arme    = "[fill:16x16:#34495e^[fill:3x10:1,3:#e67e22^[fill:3x10:12,3:#e67e22",
    teil_kopf    = "[fill:16x16:#34495e^[fill:10x8:3,3:#bdc3c7^[fill:3x3:4,5:#5dade2^[fill:3x3:9,5:#5dade2",
}
for _, p in ipairs(PARTS) do
    core.register_craftitem(L(p[1]), {
        description     = "Roboter-Bauteil: " .. p[2],
        inventory_image = PART_IMAGES[p[1]],
        groups          = { robot_part = 1 },
    })
end

-- ------------------------------------------------------------
--  C) FLIESSBAND  (conveyor: cause & effect you can stand on)
--  A floor node that pushes whatever stands on it - players and
--  items/robots alike - in the direction of its top arrow. Move
--  the player; nudge nearby objects too. Pure cause & effect.
-- ------------------------------------------------------------
-- A full-height block so standing on it is detected like any floor.
-- The top arrow rotates with the node's facedir, showing the push direction.
core.register_node(L("fliessband"), {
    description       = "Fliessband\nSchiebt alles in Pfeilrichtung weiter",
    paramtype2        = "facedir",
    -- tiles order: top, bottom, sides (sides repeat the 3rd entry)
    tiles = {
        "[fill:16x16:#34495e^[fill:6x3:5,2:#f1c40f^[fill:10x3:3,6:#f1c40f" ..
            "^[fill:6x3:5,10:#f1c40f",
        "[fill:16x16:#2c3e50",
        "[fill:16x16:#34495e^[fill:16x2:0,3:#7f8c8d^[fill:16x2:0,11:#7f8c8d",
    },
    groups            = { cracky = 3, oddly_breakable_by_hand = 2 },
    is_ground_content = false,
})

local BAND_SPEED = 3
local band_timer = 0
core.register_globalstep(function(dtime)
    band_timer = band_timer + dtime
    if band_timer < 0.25 then return end
    band_timer = 0

    for _, player in ipairs(core.get_connected_players()) do
        local pp   = player:get_pos()
        local foot = { x = math.floor(pp.x + 0.5), y = math.floor(pp.y - 0.5),
                       z = math.floor(pp.z + 0.5) }
        local node = core.get_node(foot)
        if node.name == L("fliessband") then
            local dir = core.facedir_to_dir(node.param2)
            -- only horizontal push
            player:add_velocity({ x = dir.x * BAND_SPEED, y = 0, z = dir.z * BAND_SPEED })
            -- carry items / robots standing on the same belt, too
            for _, obj in ipairs(core.get_objects_inside_radius(
                                     { x = foot.x, y = foot.y + 1, z = foot.z }, 1.2)) do
                if not obj:is_player() then
                    local v = obj:get_velocity()
                    if v then
                        obj:set_velocity({ x = dir.x * BAND_SPEED, y = v.y, z = dir.z * BAND_SPEED })
                    end
                end
            end
        end
    end
end)

-- ------------------------------------------------------------
--  D) RECYCLINGHOF  (Materialkreislauf: scrap -> new part)
--  A scrap heap you dig for "Schrott", and a Recycler that turns
--  scrap (held in hand, right-click) into a random robot part.
--  Cause & effect plus the recycling idea (NMG.4).
-- ------------------------------------------------------------
core.register_craftitem(L("schrott"), {
    description     = "Schrott (Altmetall)\nIn den Recycler stecken (Rechtsklick) = neues Bauteil",
    inventory_image = "[fill:16x16:#566573^[fill:5x4:2,3:#7f8c8d^[fill:4x5:9,2:#95a5a6" ..
                      "^[fill:5x4:3,9:#95a5a6^[fill:4x4:10,9:#7f8c8d",
    groups          = { scrap = 1 },
})

-- A scrap heap: dig it to get a few pieces of scrap.
core.register_node(L("schrotthaufen"), {
    description       = "Schrotthaufen\nAbbauen = Schrott sammeln",
    tiles = { "[fill:16x16:#566573^[fill:4x4:2,9:#7f8c8d^[fill:4x4:8,10:#95a5a6" ..
              "^[fill:4x4:11,8:#7f8c8d^[fill:4x4:5,5:#95a5a6^[fill:3x3:9,4:#7f8c8d" },
    groups            = { cracky = 3, oddly_breakable_by_hand = 3 },
    drop              = L("schrott") .. " 3",
    is_ground_content = false,
})

-- The Recycler: right-click while holding scrap -> a robot part.
core.register_node(L("recycler"), {
    description       = "Recycler\nSchrott in die Hand nehmen, Rechtsklick = neues Bauteil",
    tiles = {
        "[fill:16x16:#2c3e50^[fill:10x3:3,2:#27ae60^[fill:8x8:4,6:#566573",
        "[fill:16x16:#2c3e50",
        "[fill:16x16:#2c3e50^[fill:12x12:2,2:#34495e^[fill:6x2:5,4:#27ae60" ..
            "^[fill:4x4:6,8:#95a5a6",
    },
    paramtype         = "light",
    paramtype2        = "facedir",
    groups            = { cracky = 2 },
    light_source      = 3,
    is_ground_content = false,
    on_rightclick = function(pos, node, clicker)
        if not (clicker and clicker:is_player()) then return end
        local name    = clicker:get_player_name()
        local wielded = clicker:get_wielded_item()
        if wielded:get_name() ~= L("schrott") then
            core.chat_send_player(name,
                "Der Recycler braucht Schrott. Nimm 'Schrott' in die Hand und mach Rechtsklick. " ..
                "(Schrott bekommst du aus einem Schrotthaufen.)")
            return
        end
        if not core.is_creative_enabled(name) then
            wielded:take_item(); clicker:set_wielded_item(wielded)
        end
        -- out comes a random robot part
        local part = PARTS[math.random(#PARTS)][1]
        local inv  = clicker:get_inventory()
        local left = inv:add_item("main", L(part))
        if not left:is_empty() then
            core.add_item(pos, left)
        end
        core.add_particlespawner({
            amount = 12, time = 0.3,
            minpos = vector.subtract(pos, 0.4), maxpos = vector.add(pos, 0.4),
            minvel = { x = -0.6, y = 1, z = -0.6 }, maxvel = { x = 0.6, y = 2, z = 0.6 },
            minexptime = 0.4, maxexptime = 0.9, minsize = 1, maxsize = 3,
            texture = "[fill:8x8:#2ecc71",
        })
        core.sound_play("lernwelt_rescue", { to_player = name, gain = 0.6 })
        local meta = clicker:get_meta()
        local n = meta:get_int("lernwelt_schrauber:recycelt") + 1
        meta:set_int("lernwelt_schrauber:recycelt", n)
        core.chat_send_player(name,
            "Recycelt! Aus Schrott wurde ein neues Bauteil. Recycelt: " .. n)
    end,
})

-- ------------------------------------------------------------
--  E) STARTER KIT  (handed out once on first join)
--  Makes the world testable right away: logbook, camera, the
--  whole logic kit (switch, button, wire, lamp, door), a
--  conveyor, a recycler + scrap, robot parts + a robot kit, a
--  stack of build blocks, and one spawn egg per robot (the engine
--  registers those when a mob API is present; missing items are
--  simply skipped). Turn off via "lernwelt_schrauber_starter_kit".
-- ------------------------------------------------------------
local STARTER_BLOCKS = {
    "werkbank", "stahlplatte", "riffelblech", "schraubenkiste", "zahnrad_block",
    "warnband", "bodenfliese", "glaswand", "energie_block",
    "roboblech_blau", "roboblech_rot", "roboblech_gelb",
    "schalter_aus", "taster_aus", "leitung", "lampe_aus", "tuer_zu",
    "fliessband", "recycler", "schrotthaufen",
}
local STARTER_EGGS = {
    "rollbot", "greifbot", "sortierbot", "funkenbot", "lampenbot",
    "schaltbot", "sammelbot", "pressbot", "putzbot", "meisterbot",
}

-- Add an item only if it is actually registered (robust across
-- games with or without a mob API).
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
    give_if_exists(inv, L("roboter_bausatz") .. " 3")
    give_if_exists(inv, L("teil_beine") .. " 5")
    give_if_exists(inv, L("teil_koerper") .. " 5")
    give_if_exists(inv, L("teil_arme") .. " 5")
    give_if_exists(inv, L("teil_kopf") .. " 5")
    give_if_exists(inv, L("schrott") .. " 10")
    for _, suffix in ipairs(STARTER_BLOCKS) do
        give_if_exists(inv, L(suffix) .. " 10")
    end
    for _, cid in ipairs(STARTER_EGGS) do
        give_if_exists(inv, L(cid))
    end
    core.chat_send_player(player:get_player_name(),
        "Schrauber-Werkstatt: Startausruestung erhalten - Roboter-Katalog, Kamera, " ..
        "Roboter-Bausaetze + Bauteile, Logik-Kit (Schalter, Taster, Leitung, Lampe, Tuer), " ..
        "Fliessband, Recycler + Schrott, Bau-Bloecke und Spawn-Eier. Tipp: '/schrauber_logik' " ..
        "baut dir eine fertige Schalter-Lampe-Tuer-Schaltung. Viel Spass beim Tueffteln!")
end

core.register_on_joinplayer(function(player)
    if not core.settings:get_bool("lernwelt_schrauber_starter_kit", true) then return end
    local meta = player:get_meta()
    if meta:get_int("lernwelt_schrauber:starter_given") == 1 then return end
    meta:set_int("lernwelt_schrauber:starter_given", 1)
    -- slight delay so the inventory exists and the message is seen
    core.after(1.5, function()
        if player and player:is_player() then give_starter_kit(player) end
    end)
end)

-- ------------------------------------------------------------
--  F) ROBOT LAND SPAWNER  (a living workshop)
--  The engine's built-in spawner only places water animals, so
--  this small, backend-agnostic spawner brings the robots to
--  life: every so often it tries to add one non-rare robot on
--  solid ground with air above, near a player, capped so the
--  workshop never gets crowded. Turn off with the setting
--  "lernwelt_spawn_creatures".
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
--  G) EXTRA: LOGIK-DEMO  (a ready-made Schalter -> Lampe -> Tuer)
--  "/schrauber_logik" builds a small, working circuit in front of
--  you so the cause & effect is visible immediately: a switch, a
--  wire run, a lamp and a door. Flip the switch to see it work.
--  Priv: server.
-- ------------------------------------------------------------
core.register_chatcommand("schrauber_logik", {
    description = "Baut eine fertige Schalter -> Leitung -> Lampe -> Tuer-Schaltung vor dir",
    privs = { server = true },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then return false, "Dieser Befehl funktioniert nur im Spiel." end
        local b  = vector.round(player:get_pos())
        local fy = b.y - 1
        local z0 = b.z + 2

        -- a little metal floor
        for dx = -1, 4 do
            for dz = 0, 1 do
                core.set_node({ x = b.x + dx, y = fy, z = z0 + dz }, { name = L("bodenfliese") })
            end
        end
        -- switch -> wire -> wire -> lamp, and a door at the end
        core.set_node({ x = b.x,     y = fy + 1, z = z0 }, { name = L("schalter_aus") })
        core.set_node({ x = b.x + 1, y = fy + 1, z = z0 }, { name = L("leitung") })
        core.set_node({ x = b.x + 2, y = fy + 1, z = z0 }, { name = L("leitung") })
        core.set_node({ x = b.x + 3, y = fy + 1, z = z0 }, { name = L("lampe_aus") })
        core.set_node({ x = b.x + 4, y = fy + 1, z = z0 }, { name = L("leitung") })
        core.set_node({ x = b.x + 4, y = fy + 2, z = z0 }, { name = L("tuer_zu") })
        recompute({ x = b.x + 1, y = fy + 1, z = z0 })

        return true, "Schaltung gebaut! Klicke den Schalter (Rechtsklick): Lampe geht an und " ..
                     "die Tuer oeffnet sich. Schalter wieder aus -> alles geht aus. Das ist " ..
                     "Ursache und Wirkung - und die Bruecke zu Mesecons."
    end,
})

-- ------------------------------------------------------------
--  H) EXTRA: TEST STATION  (chat command for quick setup)
--  "/schrauber_teststation" builds a small ready-made spot: a
--  floor, the three learning boards, the logic demo, a conveyor
--  strip and a robot frame. Priv: server.
-- ------------------------------------------------------------
local STATION_BOARDS = {
    L("tafel_fliessband"),
    L("tafel_energieraum"),
    L("tafel_recyclinghof"),
}

core.register_chatcommand("schrauber_teststation", {
    description = "Baut eine kleine Werkstatt-Test-Station vor dir " ..
                  "(Boden, 3 Lern-Tafeln, Logik-Demo, Fliessband, Roboter-Rahmen)",
    privs = { server = true },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then return false, "Dieser Befehl funktioniert nur im Spiel." end
        local base    = vector.round(player:get_pos())
        local floor_y = base.y - 1
        local floor   = L("bodenfliese")

        for dx = -3, 3 do
            for dz = 2, 6 do
                core.set_node({ x = base.x + dx, y = floor_y, z = base.z + dz }, { name = floor })
            end
        end

        -- the three learning boards, panels facing back to you
        local xs = { -2, 0, 2 }
        for i, board in ipairs(STATION_BOARDS) do
            if core.registered_nodes[board] then
                core.set_node({ x = base.x + xs[i], y = floor_y + 1, z = base.z + 6 },
                    { name = board, param2 = 2 })
            end
        end

        -- a small logic demo: switch -> wire -> lamp
        core.set_node({ x = base.x - 2, y = floor_y + 1, z = base.z + 2 }, { name = L("schalter_aus") })
        core.set_node({ x = base.x - 1, y = floor_y + 1, z = base.z + 2 }, { name = L("leitung") })
        core.set_node({ x = base.x,     y = floor_y + 1, z = base.z + 2 }, { name = L("lampe_aus") })
        recompute({ x = base.x - 1, y = floor_y + 1, z = base.z + 2 })

        -- a short conveyor strip pointing +Z
        for dz = 3, 5 do
            core.set_node({ x = base.x + 2, y = floor_y + 1, z = base.z + dz },
                { name = L("fliessband"), param2 = 0 })
        end

        -- a robot frame to assemble
        local obj = core.add_entity({ x = base.x, y = floor_y + 1.5, z = base.z + 4 }, L("roboter"))
        local le  = obj and obj:get_luaentity()
        if le then
            le._color = ROBOT_COLORS[math.random(#ROBOT_COLORS)]
            obj:set_properties({ textures = robot_textures(0, le._color) })
        end

        return true, "Test-Station gebaut! Drei Lern-Tafeln, eine Schalter-Lampe-Demo, ein " ..
                     "Fliessband und ein Roboter-Rahmen stehen vor dir (Richtung +Z)."
    end,
})

-- ------------------------------------------------------------
--  I) EXTRA: WERKSTATT  (the signature base)
--  "/schrauber_werkstatt" builds a real workshop room: a tiled
--  floor, warning-stripe walls, the three learning boards, a
--  working logic circuit (switch -> lamp -> door you can walk
--  through), a conveyor lane, a recycler with a scrap heap and a
--  robot frame to assemble. Priv: server.
-- ------------------------------------------------------------
core.register_chatcommand("schrauber_werkstatt", {
    description = "Baut eine ganze Schrauber-Werkstatt vor dir (Raum, Tafeln, Logik, " ..
                  "Fliessband, Recycler, Roboter)",
    privs = { server = true },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then return false, "Dieser Befehl funktioniert nur im Spiel." end
        local b    = vector.round(player:get_pos())
        local fy   = b.y - 1
        local z0   = b.z + 2
        local W    = 5                -- half-width (x: -5..5)
        local DEEP = 12               -- depth (z: 0..12)

        -- tiled floor + a low warning-stripe wall around the edge
        for dx = -W, W do
            for dz = 0, DEEP do
                local x, z = b.x + dx, z0 + dz
                core.set_node({ x = x, y = fy, z = z }, { name = L("bodenfliese") })
                local edge = (dx == -W or dx == W or dz == 0 or dz == DEEP)
                if edge then
                    core.set_node({ x = x, y = fy + 1, z = z }, { name = L("warnband") })
                    core.set_node({ x = x, y = fy + 2, z = z }, { name = L("stahlplatte") })
                end
            end
        end

        -- three learning boards along the back wall (inside)
        local boards = { "tafel_fliessband", "tafel_energieraum", "tafel_recyclinghof" }
        local xs = { -3, 0, 3 }
        for i, bd in ipairs(boards) do
            local nn = L(bd)
            if core.registered_nodes[nn] then
                core.set_node({ x = b.x + xs[i], y = fy + 1, z = z0 + DEEP - 1 },
                    { name = nn, param2 = 2 })
            end
        end

        -- a working logic circuit on the left: switch -> wires -> lamp + a door
        local lz = z0 + 2
        core.set_node({ x = b.x - 4, y = fy + 1, z = lz }, { name = L("schalter_aus") })
        core.set_node({ x = b.x - 3, y = fy + 1, z = lz }, { name = L("leitung") })
        core.set_node({ x = b.x - 2, y = fy + 1, z = lz }, { name = L("leitung") })
        core.set_node({ x = b.x - 1, y = fy + 1, z = lz }, { name = L("lampe_aus") })
        core.set_node({ x = b.x - 1, y = fy + 2, z = lz }, { name = L("energie_block") })
        core.set_node({ x = b.x - 3, y = fy + 1, z = lz + 1 }, { name = L("leitung") })
        core.set_node({ x = b.x - 3, y = fy + 1, z = lz + 2 }, { name = L("tuer_zu") })
        recompute({ x = b.x - 3, y = fy + 1, z = lz })

        -- a conveyor lane down the middle (pointing back, +Z)
        for dz = 2, DEEP - 2 do
            core.set_node({ x = b.x, y = fy + 1, z = z0 + dz }, { name = L("fliessband"), param2 = 0 })
        end
        core.set_node({ x = b.x, y = fy + 1, z = z0 + 1 }, { name = L("werkbank") })

        -- a recycler + scrap heap on the right
        core.set_node({ x = b.x + 3, y = fy + 1, z = z0 + 2 }, { name = L("recycler") })
        core.set_node({ x = b.x + 4, y = fy + 1, z = z0 + 2 }, { name = L("schrotthaufen") })
        core.set_node({ x = b.x + 4, y = fy + 1, z = z0 + 3 }, { name = L("schrotthaufen") })

        -- a robot frame ready to assemble
        local obj = core.add_entity({ x = b.x + 3, y = fy + 1.5, z = z0 + 4 }, L("roboter"))
        local le  = obj and obj:get_luaentity()
        if le then
            le._color = ROBOT_COLORS[math.random(#ROBOT_COLORS)]
            obj:set_properties({ textures = robot_textures(0, le._color) })
        end

        return true, "Werkstatt gebaut! Links eine Schalter-Lampe-Tuer-Schaltung (Schalter " ..
                     "umlegen!), in der Mitte ein Fliessband, rechts ein Recycler mit " ..
                     "Schrotthaufen und ein Roboter-Rahmen. Drei Lern-Tafeln stehen hinten."
    end,
})

-- ------------------------------------------------------------
--  J) EXTRA: ROBOTER SPAWNEN  (for testing assembly)
--  "/schrauber_roboter" drops a fresh robot frame in front of you
--  to assemble in order. Priv: server.
-- ------------------------------------------------------------
core.register_chatcommand("schrauber_roboter", {
    description = "Setzt einen Roboter-Rahmen vor dir aus (zum Zusammenbauen testen)",
    privs = { server = true },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then return false, "Dieser Befehl funktioniert nur im Spiel." end
        local pos = player:get_pos()
        local dir = player:get_look_dir()
        local sp  = { x = pos.x + dir.x * 2, y = pos.y + 1, z = pos.z + dir.z * 2 }
        local obj = core.add_entity(sp, L("roboter"))
        local le  = obj and obj:get_luaentity()
        if le then
            le._color = ROBOT_COLORS[math.random(#ROBOT_COLORS)]
            obj:set_properties({ textures = robot_textures(0, le._color) })
        end
        return true, "Ein Roboter-Rahmen wartet vor dir. Baue ihn der Reihe nach zusammen: " ..
                     "Beine -> Koerper -> Arme -> Kopf (Bauteil in die Hand, Rechtsklick)."
    end,
})

-- ------------------------------------------------------------
--  K) EXTRA: AMBIENT-SOUND  (gentle workshop hum / beeps)
--  Plays a soft machine sound to each player now and then. The
--  .ogg files are optional (missing = silent, only a warning).
-- ------------------------------------------------------------
local amb_timer, amb_next = 0, 45
core.register_globalstep(function(dtime)
    amb_timer = amb_timer + dtime
    if amb_timer < amb_next then return end
    amb_timer = 0
    amb_next = 35 + math.random(0, 40)
    for _, player in ipairs(core.get_connected_players()) do
        local snd = (math.random() < 0.5) and "_maschine" or "_ambient"
        core.sound_play(WORLD_ID .. snd, { to_player = player:get_player_name(), gain = 0.4 })
    end
end)

-- ------------------------------------------------------------
--  L) EXTRA: BUCHSTABEN-BLOECKE  (A-Z, zum Beschriften)
--  A tiny 5x7 pixel font rendered into each block's texture with
--  layered "[fill" - no image files. Nice for labelling machines
--  and lockers (DE: benennen). (For Umlauts use AE/OE/UE.)
-- ------------------------------------------------------------
local FONT5x7 = {
    A = { ".###.", "#...#", "#...#", "#####", "#...#", "#...#", "#...#" },
    B = { "####.", "#...#", "#...#", "####.", "#...#", "#...#", "####." },
    C = { ".####", "#....", "#....", "#....", "#....", "#....", ".####" },
    D = { "####.", "#...#", "#...#", "#...#", "#...#", "#...#", "####." },
    E = { "#####", "#....", "#....", "####.", "#....", "#....", "#####" },
    F = { "#####", "#....", "#....", "####.", "#....", "#....", "#...." },
    G = { ".####", "#....", "#....", "#..##", "#...#", "#...#", ".####" },
    H = { "#...#", "#...#", "#...#", "#####", "#...#", "#...#", "#...#" },
    I = { "#####", "..#..", "..#..", "..#..", "..#..", "..#..", "#####" },
    J = { "..###", "...#.", "...#.", "...#.", "#..#.", "#..#.", ".##.." },
    K = { "#...#", "#..#.", "#.#..", "##...", "#.#..", "#..#.", "#...#" },
    L = { "#....", "#....", "#....", "#....", "#....", "#....", "#####" },
    M = { "#...#", "##.##", "#.#.#", "#.#.#", "#...#", "#...#", "#...#" },
    N = { "#...#", "##..#", "#.#.#", "#.#.#", "#..##", "#...#", "#...#" },
    O = { ".###.", "#...#", "#...#", "#...#", "#...#", "#...#", ".###." },
    P = { "####.", "#...#", "#...#", "####.", "#....", "#....", "#...." },
    Q = { ".###.", "#...#", "#...#", "#...#", "#.#.#", "#..#.", ".##.#" },
    R = { "####.", "#...#", "#...#", "####.", "#.#..", "#..#.", "#...#" },
    S = { ".####", "#....", "#....", ".###.", "....#", "....#", "####." },
    T = { "#####", "..#..", "..#..", "..#..", "..#..", "..#..", "..#.." },
    U = { "#...#", "#...#", "#...#", "#...#", "#...#", "#...#", ".###." },
    V = { "#...#", "#...#", "#...#", "#...#", "#...#", ".#.#.", "..#.." },
    W = { "#...#", "#...#", "#...#", "#.#.#", "#.#.#", "##.##", "#...#" },
    X = { "#...#", "#...#", ".#.#.", "..#..", ".#.#.", "#...#", "#...#" },
    Y = { "#...#", "#...#", ".#.#.", "..#..", "..#..", "..#..", "..#.." },
    Z = { "#####", "....#", "...#.", "..#..", ".#...", "#....", "#####" },
}

local function letter_texture(rows)
    local t = { "[fill:16x16:#bdc3c7" }
    for r = 1, #rows do
        local row = rows[r]
        for c = 1, #row do
            if row:sub(c, c) == "#" then
                t[#t + 1] = ("^[fill:2x2:%d,%d:#2c3e50"):format(3 + (c - 1) * 2, 1 + (r - 1) * 2)
            end
        end
    end
    return table.concat(t)
end

for letter, rows in pairs(FONT5x7) do
    core.register_node(L("buchstabe_" .. letter:lower()), {
        description = "Buchstabe " .. letter,
        tiles = { letter_texture(rows) },
        groups = { cracky = 3, oddly_breakable_by_hand = 2 },
        is_ground_content = false,
    })
end

core.log("action", "[lernwelt_schrauber] Theme 'Schrauber-Werkstatt' registered (on lernwelt engine)" ..
    (HAS_MESECON and " with Mesecons bridge." or " (Mesecons not installed - mini-logic only)."))
