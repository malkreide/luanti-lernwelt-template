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

        -- Patterned decoration blocks (procedural, no image files needed).
        -- The "texture" field is a Luanti texture-modifier string: a base
        -- "[fill" plus overlaid "^[fill:WxH:X,Y:#colour" rectangles.
        { suffix = "muster_streifen", name = "Streifen-Koralle",
          texture = "[fill:16x16:#e74c3c^[fill:3x16:3,0:#ffffff^[fill:3x16:10,0:#ffffff" },
        { suffix = "muster_punkte", name = "Punkte-Block",
          texture = "[fill:16x16:#3498db^[fill:3x3:2,2:#ffffff^[fill:3x3:11,2:#ffffff" ..
                    "^[fill:3x3:2,11:#ffffff^[fill:3x3:11,11:#ffffff^[fill:3x3:6,6:#ffffff" },
        { suffix = "muster_schach", name = "Schachbrett-Block",
          texture = "[fill:16x16:#f1c40f^[fill:8x8:0,0:#34495e^[fill:8x8:8,8:#34495e" },
        { suffix = "muster_rahmen", name = "Rahmen-Block",
          texture = "[fill:16x16:#1e8449^[fill:12x12:2,2:#2ecc71" },
        { suffix = "schatzkiste", name = "Schatzkiste",
          texture = "[fill:16x16:#8d6e3a^[fill:16x3:0,3:#f1c40f^[fill:16x3:0,10:#f1c40f" ..
                    "^[fill:4x4:6,6:#4a2f15" },
        { suffix = "sand_muschel", name = "Sand mit Muschel",
          texture = "[fill:16x16:#f4e3c1^[fill:5x4:6,8:#e8a0b0^[fill:3x2:7,6:#d98aa0" },
        { suffix = "wellen", name = "Wellen-Block",
          texture = "[fill:16x16:#5dade2^[fill:16x2:0,4:#2980b9^[fill:16x2:0,11:#2980b9" },
        { suffix = "fischschuppen", name = "Fischschuppen-Block",
          texture = "[fill:16x16:#3498db^[fill:3x3:1,1:#85c1e9^[fill:3x3:7,1:#85c1e9" ..
                    "^[fill:3x3:13,1:#85c1e9^[fill:3x3:4,5:#85c1e9^[fill:3x3:10,5:#85c1e9" ..
                    "^[fill:3x3:1,9:#85c1e9^[fill:3x3:7,9:#85c1e9^[fill:3x3:13,9:#85c1e9" },
        { suffix = "anker", name = "Anker-Block",
          texture = "[fill:16x16:#5dade2^[fill:2x10:7,3:#34495e^[fill:4x2:6,2:#34495e" ..
                    "^[fill:8x2:4,6:#34495e^[fill:3x2:3,11:#34495e^[fill:3x2:10,11:#34495e" ..
                    "^[fill:2x2:4,13:#34495e^[fill:2x2:10,13:#34495e" },
        { suffix = "steuerrad", name = "Steuerrad-Block",
          texture = "[fill:16x16:#5dade2^[fill:12x12:2,2:#7e5109^[fill:8x8:4,4:#5dade2" ..
                    "^[fill:2x12:7,2:#7e5109^[fill:12x2:2,7:#7e5109^[fill:4x4:6,6:#7e5109" ..
                    "^[fill:2x2:7,0:#7e5109^[fill:2x2:7,14:#7e5109^[fill:2x2:0,7:#7e5109" ..
                    "^[fill:2x2:14,7:#7e5109" },

        -- Per-face block: a real treasure chest (lid on top, wood on the sides).
        { suffix = "truhe", name = "Schatztruhe",
          top    = "[fill:16x16:#8d6e3a^[fill:16x2:0,0:#f1c40f^[fill:16x2:0,14:#f1c40f^[fill:2x2:7,7:#4a2f15",
          side   = "[fill:16x16:#8d6e3a^[fill:16x3:0,6:#f1c40f^[fill:4x5:6,6:#4a2f15",
          bottom = "[fill:16x16:#6e552c" },

        -- Eigenes gemaltes Bild als Block? Lege eine PNG (16x16 oder 32x32)
        -- "lernwelt_tiefsee_meinbild.png" in den textures/-Ordner und entferne
        -- die zwei Minuszeichen vor der naechsten Zeile:
        -- { suffix = "meinbild", name = "Mein Bild", texture = "lernwelt_tiefsee_meinbild.png" },
    },

    -- --- 3) Learning zones (each gets a placeable learning board) ---
    -- Zone titles double as the "habitat" shown in the logbook.
    zones = {
        {
            id = "riff", title = "Korallenriff", color = "#e67e22",
            activity = "Fische und Korallen nach Farben sortieren, " ..
                       "Tiere zaehlen und benennen.",
            lehrplan = { "MA.1", "NMG.2", "D.2" },
            tasks = {
                { type = "quiz", question = "Welche Farbe hat ein Clownfisch meistens?",
                  options = { "Orange", "Lila", "Grau" }, answer = 1,
                  done = "Richtig! Clownfische sind orange-weiss." },
                { type = "rescue", creature = "clownfisch", count = 2,
                  done = "Stark! Zwei Clownfische gerettet." },
                { type = "quiz", question = "Womit beginnt das Wort 'Krabbe'?",
                  options = { "K", "B", "T" }, answer = 1,
                  done = "Richtig! 'Krabbe' beginnt mit K." },
            },
        },
        {
            id = "offenes_meer", title = "Offenes Meer", color = "#2980b9",
            activity = "Grosse und kleine Tiere vergleichen, Groessen " ..
                       "ordnen, mutig hinausschwimmen.",
            lehrplan = { "MA.2", "NMG.2", "BS.2" },
            tasks = {
                { type = "quiz", question = "Wer ist groesser?",
                  options = { "Blauwal", "Hai" }, answer = 1,
                  done = "Genau! Der Blauwal ist riesig." },
                { type = "rescue", creature = "blauwal", count = 1,
                  done = "Toll! Den grossen Blauwal gerettet." },
            },
        },
        {
            id = "tiefsee", title = "Dunkle Tiefsee", color = "#283747",
            activity = "Im Dunkeln leuchtende Tiere suchen, hell und " ..
                       "dunkel unterscheiden, ruhig erkunden.",
            lehrplan = { "NMG.3", "NMG.2" },
            tasks = {
                { type = "quiz", question = "Welches Tier leuchtet in der Tiefe?",
                  options = { "Anglerfisch", "Schildkroete", "Krabbe" }, answer = 1,
                  done = "Richtig! Der Anglerfisch leuchtet." },
            },
        },
        {
            id = "meeresboden", title = "Meeresboden", color = "#16a085",
            activity = "Muster legen (rot-gelb-rot-gelb), Formen erkennen, " ..
                       "Tiere am Boden entdecken.",
            lehrplan = { "MA.2", "NMG.2", "MI.1" },
            tasks = {
                { type = "quiz", question = "Wie viele Arme hat ein Seestern?",
                  options = { "5", "3", "8" }, answer = 1,
                  done = "Richtig! Ein Seestern hat 5 Arme." },
                { type = "rescue", creature = "seestern", count = 2,
                  done = "Klasse! Zwei Seesterne gerettet." },
                { type = "pattern",
                  sequence = { "#e74c3c", "#f1c40f", "#e74c3c" },
                  palette  = { { "#e74c3c", "Rot" }, { "#f1c40f", "Gelb" }, { "#3498db", "Blau" } },
                  done = "Super! Muster rot-gelb-rot gelegt." },
            },
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
            color = "#27ae60", size = 0.8, speed = 0.7, swims = true, family = 2,
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
        {
            id = "seepferdchen", name = "Seepferdchen", zone = "riff",
            color = "#f5b041", size = 0.4, speed = 0.5, swims = true,
            food = "Plankton", power = "Schwimmt aufrecht",
            heart = "#fad7a0",
            rescue_text = "Gerettet! Das Seepferdchen schaukelt davon.",
        },
        {
            id = "krabbe", name = "Krabbe", zone = "riff",
            color = "#e74c3c", size = 0.4, speed = 0.5, swims = true,
            food = "Algen", power = "Laeuft seitwaerts",
            heart = "#f5b7b1",
            rescue_text = "Gerettet! Die Krabbe krabbelt seitwaerts ins Riff.",
        },
        {
            id = "delfin", name = "Delfin", zone = "offenes_meer",
            color = "#5dade2", size = 1.2, speed = 2.0, swims = true, family = 2,
            food = "Fische", power = "Springt und klickt",
            heart = "#aed6f1",
            rescue_text = "Gerettet! Der Delfin springt vor Freude.",
        },
        {
            id = "rochen", name = "Rochen", zone = "meeresboden",
            color = "#34495e", size = 1.0, speed = 0.8, swims = true,
            food = "Muscheln", power = "Gleitet wie ein Drachen",
            heart = "#d6dbdf",
            rescue_text = "Gerettet! Der Rochen gleitet lautlos davon.",
        },
        {
            id = "seekuh", name = "Seekuh", zone = "meeresboden",
            color = "#95a5a6", size = 1.3, speed = 0.4, swims = true, family = 1,
            food = "Seegras", power = "Ganz sanft und langsam",
            heart = "#d7dbdd",
            rescue_text = "Gerettet! Die Seekuh schwimmt gemuetlich weiter.",
        },
        {
            -- legendary, rare: never auto-spawns (egg/manual only)
            id = "goldwal", name = "Goldener Wal", zone = "offenes_meer",
            color = "#f1c40f", size = 2.4, speed = 0.5, swims = true,
            glow = 6, rare = true,
            food = "Sonnenlicht", power = "Sehr selten und magisch",
            heart = "#fff2a8",
            rescue_text = "Der legendaere Goldene Wal schenkt dir ein Leuchten!",
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
    _driver = nil, _passenger = nil, _motor = nil, _bubble = 0,

    on_rightclick = function(self, clicker)
        if not (clicker and clicker:is_player()) then return end
        local name = clicker:get_player_name()
        if self._driver == name then
            clicker:set_detach()
            clicker:set_eye_offset({ x = 0, y = 0, z = 0 }, { x = 0, y = 0, z = 0 })
            self._driver = nil
            self.object:set_properties({ glow = 0 })
            if self._motor then core.sound_stop(self._motor); self._motor = nil end
            core.chat_send_player(name, "Du steigst aus der Tauchkapsel aus.")
        elseif self._passenger == name then
            clicker:set_detach()
            clicker:set_eye_offset({ x = 0, y = 0, z = 0 }, { x = 0, y = 0, z = 0 })
            self._passenger = nil
            core.chat_send_player(name, "Du steigst als Mitfahrer aus.")
        elseif not self._driver then
            clicker:set_attach(self.object, "", { x = 0, y = 4, z = 0 }, { x = 0, y = 0, z = 0 })
            self._driver = name
            self.object:set_properties({ glow = 9 })   -- Scheinwerfer
            self._motor = core.sound_play(WORLD_ID .. "_motor",
                { object = self.object, loop = true, gain = 0.5 })
            core.chat_send_player(name,
                "Tauchkapsel gestartet! W/S fahren, A/D lenken, Springen = hoch, " ..
                "Schleichen = runter, Rechtsklick = aussteigen. " ..
                "(Ein zweiter Spieler kann mitfahren!)")
        elseif not self._passenger then
            clicker:set_attach(self.object, "", { x = -4, y = 4, z = 0 }, { x = 0, y = 0, z = 0 })
            self._passenger = name
            core.chat_send_player(name, "Du faehrst als Mitfahrer mit! Rechtsklick = aussteigen.")
        end
    end,

    on_step = function(self, dtime)
        self.object:set_acceleration({ x = 0, y = 0, z = 0 })
        local driver = self._driver and core.get_player_by_name(self._driver)
        if not driver then
            self.object:set_velocity({ x = 0, y = 0, z = 0 })
            if self._motor then core.sound_stop(self._motor); self._motor = nil end
            self.object:set_properties({ glow = 0 })
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

        -- bubble trail while moving
        if fwd ~= 0 or vy ~= 0 then
            self._bubble = (self._bubble or 0) + dtime
            if self._bubble > 0.25 then
                self._bubble = 0
                local p = self.object:get_pos()
                core.add_particlespawner({
                    amount = 6, time = 0.2,
                    minpos = vector.subtract(p, 0.5), maxpos = vector.add(p, 0.5),
                    minvel = { x = -0.2, y = 0.4, z = -0.2 },
                    maxvel = { x = 0.2,  y = 1.0, z = 0.2 },
                    minexptime = 0.6, maxexptime = 1.2, minsize = 1, maxsize = 2,
                    texture = "[fill:8x8:#cfeffd",
                })
            end
        end
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
    "seepferdchen", "krabbe", "delfin", "rochen", "seekuh", "goldwal",
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
    give_if_exists(inv, WORLD_ID .. ":kamera")
    give_if_exists(inv, WORLD_ID .. ":tauchkapsel")
    give_if_exists(inv, WORLD_ID .. ":koralle_setzling 5")
    for _, suffix in ipairs(STARTER_BLOCKS) do
        give_if_exists(inv, WORLD_ID .. ":" .. suffix .. " 10")
    end
    for _, cid in ipairs(STARTER_EGGS) do
        give_if_exists(inv, WORLD_ID .. ":" .. cid)
    end
    core.chat_send_player(player:get_player_name(),
        "Tiefsee-Retter: Startausruestung erhalten - Logbuch, Kamera, Tauchkapsel, " ..
        "Korallen, Setzlinge und Spawn-Eier sind in deinem Inventar. Viel Spass!")
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

    -- a few litter pieces for the ocean-cleanup mini-game
    local litter = { "muell_flasche", "muell_dose", "muell_tuete" }
    local spots  = { { -2, 2 }, { 0, 4 }, { 2, 2 }, { -1, 5 }, { 1, 4 } }
    for _, s in ipairs(spots) do
        core.set_node({ x = base.x + s[1], y = floor_y + 1, z = base.z + s[2] },
            { name = WORLD_ID .. ":" .. litter[math.random(#litter)] })
    end
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
                     "(+Z): Glasboden, vier Lern-Tafeln, eine Tauchkapsel und " ..
                     "etwas Muell zum Aufraeumen."
    end,
})

-- ------------------------------------------------------------
--  E) EXTRA: MEER AUFRAEUMEN  (ocean-cleanup mini-game)
--  Litter nodes you can break to clean the sea. Each piece adds
--  to a personal cleanup counter with small milestones. Place
--  test litter with "/tiefsee_muell" (priv: server) or via the
--  test station. Fits the theme's motto: "Bewahren".
-- ------------------------------------------------------------
local TRASH = {
    { suffix = "muell_flasche", name = "Plastikflasche (Muell)", color = "#5dade2" },
    { suffix = "muell_dose",    name = "Blechdose (Muell)",      color = "#b2babb" },
    { suffix = "muell_tuete",   name = "Plastiktuete (Muell)",   color = "#d5f5e3" },
}

local CLEAN_MILESTONES = {
    [5]  = "Meeres-Putzer",
    [15] = "Riff-Retter",
    [30] = "Ozean-Held",
}

local function collect_trash(player)
    if not (player and player:is_player()) then return end
    local meta = player:get_meta()
    local n = meta:get_int("lernwelt_tiefsee:muell") + 1
    meta:set_int("lernwelt_tiefsee:muell", n)
    local name = player:get_player_name()
    core.sound_play("lernwelt_rescue", { to_player = name, gain = 0.8 })
    core.chat_send_player(name, "Muell eingesammelt! Sauberes Meer: " .. n .. " Stueck.")
    local title = CLEAN_MILESTONES[n]
    if title then
        core.sound_play("lernwelt_rankup", { to_player = name, gain = 1.0 })
        core.chat_send_player(name, "Toll! Du bist jetzt: " .. title .. "!")
    end
end

for _, t in ipairs(TRASH) do
    core.register_node(WORLD_ID .. ":" .. t.suffix, {
        description = t.name .. "\nAbbauen = Meer saeubern",
        drawtype = "nodebox",
        node_box = { type = "fixed", fixed = { -0.25, -0.5, -0.25, 0.25, -0.05, 0.25 } },
        tiles = { "[fill:16x16:" .. t.color },
        paramtype = "light",
        sunlight_propagates = true,
        walkable = false,
        floodable = false,
        groups = { oddly_breakable_by_hand = 3, dig_immediate = 3 },
        drop = "",
        after_dig_node = function(pos, oldnode, oldmeta, digger)
            collect_trash(digger)
        end,
    })
end

-- nodes the litter-scatter command may replace (air or water)
local CLEAN_SPACE = {
    ["air"] = true,
    ["default:water_source"] = true, ["default:water_flowing"] = true,
    ["mcl_core:water_source"] = true, ["mcl_core:water_flowing"] = true,
    ["mcla:water_source"] = true, ["mcla:water_flowing"] = true,
}

core.register_chatcommand("tiefsee_muell", {
    description = "Verteilt etwas Muell zum Aufraeumen um dich herum (zum Testen)",
    privs = { server = true },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then return false, "Dieser Befehl funktioniert nur im Spiel." end
        local base, placed = vector.round(player:get_pos()), 0
        for _ = 1, 12 do
            local x = base.x + math.random(-6, 6)
            local z = base.z + math.random(-6, 6)
            for dy = 2, -4, -1 do
                local q     = { x = x, y = base.y + dy, z = z }
                local here  = core.get_node(q).name
                local below = core.get_node({ x = x, y = q.y - 1, z = z }).name
                if CLEAN_SPACE[here] and below ~= "air" and below ~= "ignore" then
                    local t = TRASH[math.random(#TRASH)]
                    core.set_node(q, { name = WORLD_ID .. ":" .. t.suffix })
                    placed = placed + 1
                    break
                end
            end
        end
        if placed == 0 then
            return true, "Kein passender Platz gefunden - geh ans/ins Wasser und versuch es nochmal."
        end
        return true, placed .. " Stueck Muell verteilt - sammle sie ein (abbauen)!"
    end,
})

-- ------------------------------------------------------------
--  F) EXTRA: KORALLEN PFLANZEN  (plant & grow a reef)
--  A coral sapling you place; after a while it grows into a
--  random coral block. Each grown coral adds to a personal
--  "reef" counter. Fits the motto: "Bewahren".
-- ------------------------------------------------------------
local CORAL_GROWN = {
    "koralle_rot", "koralle_blau", "koralle_gelb", "koralle_pink", "koralle_gruen",
}
local GROW_TIME = 20

core.register_node(WORLD_ID .. ":koralle_setzling", {
    description = "Korallen-Setzling\nSetzen - waechst zu einer Koralle",
    drawtype = "plantlike",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    floodable = false,
    tiles = { "[fill:16x16:#1abc9c^[fill:6x10:5,3:#16a085" },
    inventory_image = "[fill:16x16:#1abc9c^[fill:6x10:5,3:#16a085",
    selection_box = { type = "fixed", fixed = { -0.3, -0.5, -0.3, 0.3, 0.2, 0.3 } },
    groups = { dig_immediate = 3, oddly_breakable_by_hand = 3 },
    after_place_node = function(pos, placer)
        if placer and placer:is_player() then
            core.get_meta(pos):set_string("planter", placer:get_player_name())
        end
        core.get_node_timer(pos):start(GROW_TIME)
    end,
    on_timer = function(pos)
        local planter = core.get_meta(pos):get_string("planter")
        core.set_node(pos, { name = WORLD_ID .. ":" .. CORAL_GROWN[math.random(#CORAL_GROWN)] })
        if planter ~= "" then
            local p = core.get_player_by_name(planter)
            if p then
                local meta = p:get_meta()
                local n = meta:get_int("lernwelt_tiefsee:korallen") + 1
                meta:set_int("lernwelt_tiefsee:korallen", n)
                core.sound_play("lernwelt_rescue", { to_player = planter, gain = 0.6 })
                core.chat_send_player(planter, "Eine Koralle ist gewachsen! Riff-Korallen: " .. n)
            end
        end
        return false
    end,
})

-- ------------------------------------------------------------
--  G) EXTRA: GROSSE TIEFSEE-BASIS  (chat command)
--  "/tiefsee_basis" builds a bigger glass-dome station in front
--  of you: coral floor, glass shell with a doorway, the four
--  learning boards, a Tauchkapsel and some litter. Priv: server.
-- ------------------------------------------------------------
core.register_chatcommand("tiefsee_basis", {
    description = "Baut eine groessere Tiefsee-Basis vor dir (Glaskuppel, Tafeln, Tauchkapsel)",
    privs = { server = true },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then return false, "Dieser Befehl funktioniert nur im Spiel." end
        local b     = vector.round(player:get_pos())
        local glass = WORLD_ID .. ":stationsglas"
        local floor = WORLD_ID .. ":koralle_blau"
        local R, fy = 5, b.y - 1
        local z0    = b.z + 2
        for dx = -R, R do
            for dz = 0, 2 * R do
                local x, z = b.x + dx, z0 + dz
                core.set_node({ x = x, y = fy, z = z }, { name = floor })
                for dy = 1, 4 do
                    local door = (dz == 0 and dx == 0 and dy <= 2)
                    local edge = (dx == -R or dx == R or dz == 0 or dz == 2 * R or dy == 4)
                    core.set_node({ x = x, y = fy + dy, z = z },
                        { name = (edge and not door) and glass or "air" })
                end
            end
        end
        local boards = { "tafel_riff", "tafel_offenes_meer", "tafel_tiefsee", "tafel_meeresboden" }
        local xs = { -3, -1, 1, 3 }
        for i, bd in ipairs(boards) do
            local nn = WORLD_ID .. ":" .. bd
            if core.registered_nodes[nn] then
                core.set_node({ x = b.x + xs[i], y = fy + 1, z = z0 + 1 }, { name = nn, param2 = 2 })
            end
        end
        core.add_entity({ x = b.x, y = fy + 1.5, z = z0 + R }, WORLD_ID .. ":tauchkapsel")
        for _, s in ipairs({ { -2, 2 }, { 2, 3 }, { 0, 5 }, { -1, 7 } }) do
            core.set_node({ x = b.x + s[1], y = fy + 1, z = z0 + s[2] },
                { name = WORLD_ID .. ":muell_dose" })
        end
        return true, "Tiefsee-Basis gebaut! Glaskuppel mit Tuer, Tafeln, Tauchkapsel und etwas Muell."
    end,
})

-- ------------------------------------------------------------
--  H) EXTRA: AMBIENT-SOUND  (whale song / bubbles)
--  Plays a gentle underwater sound to each player now and then.
--  The .ogg files are optional (missing = silent, only a warning).
-- ------------------------------------------------------------
local amb_timer, amb_next = 0, 45
core.register_globalstep(function(dtime)
    amb_timer = amb_timer + dtime
    if amb_timer < amb_next then return end
    amb_timer = 0
    amb_next = 35 + math.random(0, 40)
    for _, player in ipairs(core.get_connected_players()) do
        local snd = (math.random() < 0.5) and "_whale" or "_ambient"
        core.sound_play(WORLD_ID .. snd, { to_player = player:get_player_name(), gain = 0.4 })
    end
end)

-- ------------------------------------------------------------
--  I) EXTRA: BUCHSTABEN-BLOECKE  (A-Z, zum Woerterlegen)
--  A tiny 5x7 pixel font rendered into each block's texture with
--  layered "[fill" - no image files. Nice for "Deutsch / benennen":
--  lay out names and simple words from letter blocks.
--  (For Umlauts use AE/OE/UE.)
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
    local t = { "[fill:16x16:#f4e3c1" }
    for r = 1, #rows do
        local row = rows[r]
        for c = 1, #row do
            if row:sub(c, c) == "#" then
                t[#t + 1] = ("^[fill:2x2:%d,%d:#34495e"):format(3 + (c - 1) * 2, 1 + (r - 1) * 2)
            end
        end
    end
    return table.concat(t)
end

for letter, rows in pairs(FONT5x7) do
    core.register_node(WORLD_ID .. ":buchstabe_" .. letter:lower(), {
        description = "Buchstabe " .. letter,
        tiles = { letter_texture(rows) },
        groups = { cracky = 3, oddly_breakable_by_hand = 2 },
        is_ground_content = false,
    })
end

-- ------------------------------------------------------------
--  J) BACKWARDS COMPATIBILITY
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
