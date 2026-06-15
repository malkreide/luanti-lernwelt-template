-- ============================================================
--  THEME:  TIEFSEE-RETTER  (deep-sea rescue team)
--  A brand-free underwater learning world built ON TOP of the
--  reusable "lernwelt" engine. Almost everything below is one
--  declarative register_world{...} call - blocks, learning
--  zones, rescuable animals, logbook, ranks and badges all come
--  from the engine.
--
--  Two things the engine cannot express live as small pieces of
--  custom code after register_world:
--    B) the drivable "Tauchkapsel" (submarine vehicle)
--    C) a starter kit handed out on first join (for quick
--       testing: logbook, submarine, coral blocks, spawn eggs)
--
--  The mod name equals the world id ("lernwelt_tiefsee"), so all
--  nodes/items live in the "lernwelt_tiefsee:" namespace.
--
--  Content is authored in German (ASCII: ae/oe/ue), like the
--  other example theme. The engine's own UI is translated
--  separately via lernwelt/locale/*.tr.
-- ============================================================

local WORLD_ID = "lernwelt_tiefsee"

-- ------------------------------------------------------------
--  A) THE WHOLE LEARNING WORLD AS ONE DECLARATIVE TABLE
-- ------------------------------------------------------------
lernwelt.register_world({

    -- internal prefix; kept identical to the mod name so all
    -- nodes/items live in the "lernwelt_tiefsee:" namespace
    id    = WORLD_ID,
    title = "Tiefsee-Retter",

    -- --- 1) Peaceful, child-friendly world ---
    config = {
        damage      = false,   -- no damage / no dying
        creative    = true,    -- unlimited blocks
        peaceful    = true,    -- no monsters
        freeze_time = "day",   -- always bright (no scary nights)
        no_weather  = true,
    },

    -- --- 2) Colourful coral blocks + station glass (no PNG) ---
    blocks = {
        { suffix = "koralle_rot",   name = "Koralle (rot)",   color = "#e74c3c", glow = 5 },
        { suffix = "koralle_blau",  name = "Koralle (blau)",  color = "#3498db", glow = 5 },
        { suffix = "koralle_gelb",  name = "Koralle (gelb)",  color = "#f1c40f", glow = 5 },
        { suffix = "koralle_pink",  name = "Koralle (pink)",  color = "#e84393", glow = 5 },
        { suffix = "koralle_gruen", name = "Koralle (gruen)", color = "#2ecc71", glow = 5 },
        { suffix = "stationsglas",  name = "Stations-Glas",   color = "#aaddff", glass = true },
    },

    -- --- 3) Learning zones (each gets a placeable learning board) ---
    -- Zone titles double as the "habitat" shown in the logbook.
    zones = {
        {
            id = "riff", title = "Korallenriff", color = "#e67e22",
            activity = "Fische und Korallen nach Farben sortieren, " ..
                       "Tiere zaehlen und benennen.",
            lehrplan = { "MA.1", "NMG.2", "D.2" },
        },
        {
            id = "offenes_meer", title = "Offenes Meer", color = "#2980b9",
            activity = "Grosse und kleine Tiere vergleichen, Groessen " ..
                       "ordnen, mutig hinausschwimmen.",
            lehrplan = { "MA.2", "NMG.2", "BS.2" },
        },
        {
            id = "tiefsee", title = "Dunkle Tiefsee", color = "#283747",
            activity = "Im Dunkeln leuchtende Tiere suchen, hell und " ..
                       "dunkel unterscheiden, ruhig erkunden.",
            lehrplan = { "NMG.3", "NMG.2" },
        },
        {
            id = "meeresboden", title = "Meeresboden", color = "#16a085",
            activity = "Muster legen (rot-gelb-rot-gelb), Formen erkennen, " ..
                       "Tiere am Boden entdecken.",
            lehrplan = { "MA.2", "NMG.2", "MI.1" },
        },
    },

    -- --- 4) Rescuable animals (peaceful; right-click = rescue) ---
    creatures = {
        {
            id = "clownfisch", name = "Clownfisch", zone = "riff",
            color = "#e67e22", size = 0.5, speed = 1.0, swims = true,
            food = "Algen", power = "Wohnt in Anemonen",
            heart = "#ff5fa2",
            rescue_text = "Gerettet! Der Clownfisch schwimmt gluecklich nach Hause.",
        },
        {
            id = "schildkroete", name = "Schildkroete", zone = "riff",
            color = "#27ae60", size = 0.8, speed = 0.7, swims = true,
            food = "Seegras", power = "Lebt sehr lange",
            heart = "#82e0aa",
            rescue_text = "Gerettet! Die Schildkroete paddelt gemuetlich davon.",
        },
        {
            id = "blauwal", name = "Blauwal", zone = "offenes_meer",
            color = "#2980b9", size = 2.0, speed = 0.6, swims = true,
            food = "Krill", power = "Riesengross und laut",
            heart = "#aed6f1",
            rescue_text = "Gerettet! Der grosse Blauwal taucht zufrieden ab. WOOOSH!",
        },
        {
            id = "hai", name = "Hai", zone = "offenes_meer",
            color = "#7f8c8d", size = 1.4, speed = 1.8, swims = true,
            food = "Fische", power = "Super-Geruchssinn",
            heart = "#d6eaf8",
            rescue_text = "Gerettet! Der freundliche Hai flitzt davon. Schwupp!",
        },
        {
            id = "anglerfisch", name = "Anglerfisch", zone = "tiefsee",
            color = "#34495e", size = 0.6, speed = 0.8, swims = true, glow = 14,
            food = "kleine Fische", power = "Leuchtet im Dunkeln",
            heart = "#f9e79f",
            rescue_text = "Gerettet! Der Anglerfisch leuchtet dir dankbar nach.",
        },
        {
            id = "krake", name = "Krake", zone = "tiefsee",
            color = "#9b59b6", size = 0.7, speed = 1.5, swims = true,
            food = "Krabben", power = "Spritzt Tinte",
            heart = "#9b59b6",
            rescue_text = "Die Krake spritzt eine grosse Tintenwolke und flitzt davon!",
        },
        {
            id = "seestern", name = "Seestern", zone = "meeresboden",
            color = "#e67e22", size = 0.6, speed = 0.3, swims = true,
            food = "Muscheln", power = "Arme wachsen nach",
            heart = "#f8c471",
            rescue_text = "Gerettet! Der Seestern kriecht langsam zurueck ins Riff.",
        },
        {
            id = "qualle", name = "Qualle", zone = "meeresboden",
            color = "#1abc9c", size = 0.6, speed = 0.4, swims = true, glow = 8,
            food = "Plankton", power = "Glibberig und leuchtet",
            heart = "#a3e4d7",
            rescue_text = "Gerettet! Die Qualle schwebt sanft davon.",
        },
    },

    -- --- 5) Ranks (3rd field = colour -> creates a badge item) ---
    ranks = {
        { 0,  "Frischling" },
        { 5,  "Tauchschueler" },
        { 10, "Junior-Retter", "#3498db" },
        { 25, "Meeresheld",    "#27ae60" },
        { 50, "Kapitaen",      "#f1c40f" },
    },

    -- --- 6) Logbook item ---
    logbook = { title = "Meeres-Logbuch", item_color = "#f1c40f" },

    -- --- 7) Plain texts for curriculum codes (for /lernplan & boards) ---
    kompetenzen = {
        ["MA.1"]  = "Mengen erfassen und zaehlen",
        ["MA.2"]  = "Muster, Reihen und Groessen ordnen",
        ["D.2"]   = "Tiere benennen und beschreiben",
        ["NMG.2"] = "Tiere und Lebensraeume im Meer erkunden",
        ["NMG.3"] = "Hell und dunkel erleben, sich orientieren",
        ["MI.1"]  = "Einfache Ablaeufe und Muster planen",
        ["BS.2"]  = "Sich mutig und geschickt bewegen",
    },
})

-- ------------------------------------------------------------
--  B) EXTRA: TAUCHKAPSEL  (drivable submarine)
--  Not part of the engine - a self-contained vehicle the theme
--  adds on its own. Lives in the same "lernwelt_tiefsee:"
--  namespace. Controls: place -> right-click to board -> W/S
--  drive, A/D steer, jump = up, sneak = down, right-click = exit.
-- ------------------------------------------------------------
local SUB_SPEED = 5

core.register_entity(WORLD_ID .. ":tauchkapsel", {
    initial_properties = {
        physical = true, collide_with_objects = true,
        collisionbox = { -0.6, -0.4, -0.6, 0.6, 0.4, 0.6 },
        visual = "cube", visual_size = { x = 1.1, y = 0.9, z = 1.5 },
        textures = {
            "[fill:16x16:#f1c40f", "[fill:16x16:#e67e22",
            "[fill:16x16:#f1c40f", "[fill:16x16:#f1c40f",
            "[fill:16x16:#5dade2", "[fill:16x16:#f1c40f",
        },
    },
    _driver = nil, _motor = nil,

    on_rightclick = function(self, clicker)
        if not (clicker and clicker:is_player()) then return end
        local name = clicker:get_player_name()
        if self._driver == name then
            clicker:set_detach()
            clicker:set_eye_offset({ x = 0, y = 0, z = 0 }, { x = 0, y = 0, z = 0 })
            self._driver = nil
            if self._motor then core.sound_stop(self._motor); self._motor = nil end
        elseif not self._driver then
            clicker:set_attach(self.object, "", { x = 0, y = 4, z = 0 }, { x = 0, y = 0, z = 0 })
            self._driver = name
            self._motor = core.sound_play(WORLD_ID .. "_motor",
                { object = self.object, loop = true, gain = 0.5 })
            core.chat_send_player(name,
                "Tauchkapsel gestartet! W/S fahren, A/D lenken, " ..
                "Springen = hoch, Schleichen = runter, Rechtsklick = aussteigen.")
        end
    end,

    on_step = function(self, dtime)
        self.object:set_acceleration({ x = 0, y = 0, z = 0 })
        local driver = self._driver and core.get_player_by_name(self._driver)
        if not driver then
            self.object:set_velocity({ x = 0, y = 0, z = 0 })
            if self._motor then core.sound_stop(self._motor); self._motor = nil end
            self._driver = nil
            return
        end
        local ctrl = driver:get_player_control()
        local yaw  = self.object:get_yaw()
        if ctrl.left  then yaw = yaw + 0.05 end
        if ctrl.right then yaw = yaw - 0.05 end
        self.object:set_yaw(yaw)
        local dir = core.yaw_to_dir(yaw)
        local fwd = (ctrl.up and SUB_SPEED) or (ctrl.down and -SUB_SPEED * 0.5) or 0
        local vy  = (ctrl.jump and SUB_SPEED * 0.6) or (ctrl.sneak and -SUB_SPEED * 0.6) or 0
        self.object:set_velocity({ x = dir.x * fwd, y = vy, z = dir.z * fwd })
    end,
})

core.register_craftitem(WORLD_ID .. ":tauchkapsel", {
    description = "Tauchkapsel (Fahrzeug)\nPlatzieren, dann Rechtsklick zum Einsteigen",
    inventory_image = "[fill:16x16:#f1c40f^[fill:8x8:4,4:#5dade2",
    liquids_pointable = true,
    on_place = function(itemstack, placer, pointed_thing)
        if pointed_thing.type ~= "node" or not (placer and placer:is_player()) then
            return itemstack
        end
        local pos = pointed_thing.above
        pos.y = pos.y + 0.5
        core.add_entity(pos, WORLD_ID .. ":tauchkapsel")
        if not core.is_creative_enabled(placer:get_player_name()) then
            itemstack:take_item()
        end
        return itemstack
    end,
})

-- ------------------------------------------------------------
--  C) EXTRA: STARTER KIT  (handed out once on first join)
--  Makes the world testable right away: the logbook, the
--  submarine, a stack of each coral block + station glass, and
--  one spawn egg per sea animal (the engine registers the eggs
--  when a mob API is present; missing items are simply skipped).
--  Turn off via the setting "lernwelt_tiefsee_starter_kit".
-- ------------------------------------------------------------
local STARTER_BLOCKS = {
    "koralle_rot", "koralle_blau", "koralle_gelb",
    "koralle_pink", "koralle_gruen", "stationsglas",
}
-- Spawn-egg item names match the creature ids (world_id:creature_id)
local STARTER_EGGS = {
    "clownfisch", "schildkroete", "blauwal", "hai",
    "anglerfisch", "krake", "seestern", "qualle",
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
    give_if_exists(inv, WORLD_ID .. ":logbuch")
    give_if_exists(inv, WORLD_ID .. ":tauchkapsel")
    for _, suffix in ipairs(STARTER_BLOCKS) do
        give_if_exists(inv, WORLD_ID .. ":" .. suffix .. " 10")
    end
    for _, cid in ipairs(STARTER_EGGS) do
        give_if_exists(inv, WORLD_ID .. ":" .. cid)
    end
    core.chat_send_player(player:get_player_name(),
        "Tiefsee-Retter: Startausruestung erhalten - Logbuch, Tauchkapsel, " ..
        "Korallen und Spawn-Eier sind in deinem Inventar. Viel Spass beim Testen!")
end

core.register_on_joinplayer(function(player)
    if not core.settings:get_bool("lernwelt_tiefsee_starter_kit", true) then return end
    local meta = player:get_meta()
    if meta:get_int("lernwelt_tiefsee:starter_given") == 1 then return end
    meta:set_int("lernwelt_tiefsee:starter_given", 1)
    -- slight delay so the inventory exists and the message is seen
    core.after(1.5, function()
        if player and player:is_player() then give_starter_kit(player) end
    end)
end)

-- ------------------------------------------------------------
--  D) EXTRA: TEST STATION  (chat command for quick setup)
--  "/tiefsee_teststation" builds a small ready-made station in
--  front of you: a glass floor, the four learning boards and a
--  Tauchkapsel. Handy for testing or for an adult to prepare the
--  world. It overwrites the nodes where it builds, so it needs
--  the "server" privilege.
-- ------------------------------------------------------------
local STATION_BOARDS = {
    WORLD_ID .. ":tafel_riff",
    WORLD_ID .. ":tafel_offenes_meer",
    WORLD_ID .. ":tafel_tiefsee",
    WORLD_ID .. ":tafel_meeresboden",
}

local function build_test_station(player)
    local base    = vector.round(player:get_pos())
    local floor_y = base.y - 1
    local glass   = WORLD_ID .. ":stationsglas"

    -- 7 wide (x: -3..3) x 4 deep (z: +2..+5) glass floor in front of you
    for dx = -3, 3 do
        for dz = 2, 5 do
            core.set_node({ x = base.x + dx, y = floor_y, z = base.z + dz }, { name = glass })
        end
    end

    -- the four learning boards on the floor, panels facing back to you
    local xs = { -3, -1, 1, 3 }
    for i, board in ipairs(STATION_BOARDS) do
        if core.registered_nodes[board] then
            core.set_node({ x = base.x + xs[i], y = floor_y + 1, z = base.z + 3 },
                { name = board, param2 = 2 })
        end
    end

    -- a Tauchkapsel ready to board
    core.add_entity({ x = base.x, y = floor_y + 1.5, z = base.z + 5 },
        WORLD_ID .. ":tauchkapsel")
end

core.register_chatcommand("tiefsee_teststation", {
    description = "Baut eine kleine Tiefsee-Test-Station vor dir " ..
                  "(Glasboden, 4 Lern-Tafeln, Tauchkapsel)",
    privs = { server = true },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then
            return false, "Dieser Befehl funktioniert nur im Spiel."
        end
        build_test_station(player)
        return true, "Test-Station gebaut! Sie steht vor dir Richtung Norden " ..
                     "(+Z): Glasboden, vier Lern-Tafeln und eine Tauchkapsel."
    end,
})

-- ------------------------------------------------------------
--  E) BACKWARDS COMPATIBILITY
--  Redirect nodes/items that were built/held with the OLD,
--  standalone "tiefsee:" mod (before it became a theme on the
--  engine) to their new "lernwelt_tiefsee:" names. Without this,
--  existing builds would turn into unknown nodes after the
--  rename. Aliases are harmless if those old names never existed.
-- ------------------------------------------------------------
local legacy_aliases = {
    -- placeable blocks
    ["tiefsee:coral_rot"]     = WORLD_ID .. ":koralle_rot",
    ["tiefsee:coral_blau"]    = WORLD_ID .. ":koralle_blau",
    ["tiefsee:coral_gelb"]    = WORLD_ID .. ":koralle_gelb",
    ["tiefsee:coral_pink"]    = WORLD_ID .. ":koralle_pink",
    ["tiefsee:coral_gruen"]   = WORLD_ID .. ":koralle_gruen",
    ["tiefsee:station_glass"] = WORLD_ID .. ":stationsglas",
    -- held items
    ["tiefsee:logbuch"]       = WORLD_ID .. ":logbuch",
    ["tiefsee:tauchkapsel"]   = WORLD_ID .. ":tauchkapsel",
    -- spawn eggs (old English ids -> new German ids)
    ["tiefsee:clownfish"]     = WORLD_ID .. ":clownfisch",
    ["tiefsee:whale"]         = WORLD_ID .. ":blauwal",
    ["tiefsee:octopus"]       = WORLD_ID .. ":krake",
    ["tiefsee:anglerfish"]    = WORLD_ID .. ":anglerfisch",
    ["tiefsee:turtle"]        = WORLD_ID .. ":schildkroete",
    ["tiefsee:shark"]         = WORLD_ID .. ":hai",
    ["tiefsee:starfish"]      = WORLD_ID .. ":seestern",
    -- honour badges (old fixed names -> new threshold-based names)
    ["tiefsee:badge_junior"]  = WORLD_ID .. ":badge_10",
    ["tiefsee:badge_held"]    = WORLD_ID .. ":badge_25",
    ["tiefsee:badge_captain"] = WORLD_ID .. ":badge_50",
}
for old, new in pairs(legacy_aliases) do
    core.register_alias(old, new)
end

core.log("action", "[lernwelt_tiefsee] Theme 'Tiefsee-Retter' registered (on lernwelt engine).")
