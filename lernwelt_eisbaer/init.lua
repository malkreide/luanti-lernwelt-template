-- ============================================================
--  THEME:  EISBAER-BUCHT  (polar world / cold animals)
--  A brand-free polar learning world built ON TOP of the
--  reusable "lernwelt" engine. Almost everything below is one
--  declarative register_world{...} call - blocks, learning
--  zones, rescuable animals, logbook, ranks and badges all come
--  from the engine.
--
--  The theme's heart is COLD ANIMALS & THEIR HABITATS (penguin,
--  seal, polar bear ...) and BLUE-WHITE PATTERNS. The base is an
--  Iglu / Eispalast (igloo / ice palace) and the world has three
--  zones: a frozen lake, a snow forest and an aurora cave.
--  (Lehrplan 21: NMG.2 Tiere & Lebensraeume.)
--
--  Things the engine cannot express live as small pieces of
--  custom code after register_world:
--    B) a drivable "Schlitten" (sled that glides over snow & ice)
--    C) the "Polarlicht" (aurora: nodes that slowly cycle colour)
--    D) a first-join starter kit (quick testing)
--    E) "Tiere fuettern" (a feeding station + caring counter)
--    F) "Eisblumen pflanzen" (plant & grow blue-white patterns)
--    G) a land spawner so the cold land animals come alive
--    H) base commands (Iglu, Eispalast, test station)
--    ...plus ambient sound and letter blocks.
--
--  The mod name equals the world id ("lernwelt_eisbaer"), so all
--  nodes/items live in the "lernwelt_eisbaer:" namespace.
--
--  Content is authored in German (ASCII: ae/oe/ue), like the
--  other example themes. The engine's own UI is translated
--  separately via lernwelt/locale/*.tr.
-- ============================================================

local WORLD_ID = "lernwelt_eisbaer"
local function L(suffix) return WORLD_ID .. ":" .. suffix end

-- ------------------------------------------------------------
--  A) THE WHOLE LEARNING WORLD AS ONE DECLARATIVE TABLE
-- ------------------------------------------------------------
lernwelt.register_world({

    -- internal prefix; kept identical to the mod name so all
    -- nodes/items live in the "lernwelt_eisbaer:" namespace
    id    = WORLD_ID,
    title = "Eisbaer-Bucht",

    -- --- 1) Peaceful, child-friendly world ---
    config = {
        damage      = false,   -- no damage / no dying (no freezing!)
        creative    = true,    -- unlimited blocks
        peaceful    = true,    -- no monsters
        freeze_time = "day",   -- always bright (no scary polar nights)
        no_weather  = true,
    },

    -- --- 2) Snow & ice blocks + lots of blue-white patterns ---
    --  The "texture" field is a Luanti texture-modifier string: a
    --  base "[fill" plus overlaid "^[fill:WxH:X,Y:#colour" rectangles.
    blocks = {
        { suffix = "schnee",   name = "Schnee",        color = "#ecf6ff" },
        { suffix = "packeis",  name = "Packeis",       color = "#aed6f1" },
        { suffix = "blaueis",  name = "Blaues Eis",    color = "#5dade2" },
        { suffix = "klareis",  name = "Klares Eis",    color = "#d6eaf8", glass = true },

        -- Brick-style building blocks for the iglu / ice palace.
        { suffix = "iglu_block", name = "Iglu-Block (Schneeziegel)",
          texture = "[fill:16x16:#ecf6ff^[fill:16x1:0,5:#cddef0^[fill:16x1:0,11:#cddef0" ..
                    "^[fill:1x5:8,0:#cddef0^[fill:1x6:4,6:#cddef0^[fill:1x6:12,6:#cddef0" },
        { suffix = "eisziegel", name = "Eisziegel",
          texture = "[fill:16x16:#aed6f1^[fill:16x1:0,5:#7fb3d5^[fill:16x1:0,11:#7fb3d5" ..
                    "^[fill:1x5:8,0:#7fb3d5^[fill:1x6:4,6:#7fb3d5^[fill:1x6:12,6:#7fb3d5" },

        -- BLUE-WHITE PATTERNS (the theme's art focus): build with these
        -- and copy them at the learning boards (Muster nachlegen).
        { suffix = "muster_streifen", name = "Streifen (blau-weiss)",
          texture = "[fill:16x16:#3498db^[fill:3x16:3,0:#ffffff^[fill:3x16:10,0:#ffffff" },
        { suffix = "muster_punkte", name = "Punkte (blau-weiss)",
          texture = "[fill:16x16:#5dade2^[fill:3x3:2,2:#ffffff^[fill:3x3:11,2:#ffffff" ..
                    "^[fill:3x3:2,11:#ffffff^[fill:3x3:11,11:#ffffff^[fill:3x3:6,6:#ffffff" },
        { suffix = "muster_schach", name = "Schachbrett (blau-weiss)",
          texture = "[fill:16x16:#ffffff^[fill:8x8:0,0:#3498db^[fill:8x8:8,8:#3498db" },
        { suffix = "muster_welle", name = "Wellen (blau-weiss)",
          texture = "[fill:16x16:#5dade2^[fill:16x2:0,4:#ffffff^[fill:16x2:0,11:#ffffff" },
        { suffix = "schneeflocke_block", name = "Schneeflocken-Block",
          texture = "[fill:16x16:#ffffff^[fill:2x12:7,2:#5dade2^[fill:12x2:2,7:#5dade2" ..
                    "^[fill:2x2:3,3:#5dade2^[fill:2x2:11,3:#5dade2^[fill:2x2:3,11:#5dade2" ..
                    "^[fill:2x2:11,11:#5dade2" },

        -- A glowing ice crystal (for the cave and decoration).
        { suffix = "eiskristall", name = "Eiskristall",
          texture = "[fill:16x16:#85c1e9^[fill:8x8:4,4:#d6eaf8^[fill:4x4:6,6:#ffffff",
          glow = 11 },

        -- Snowy rock (the bay's cliffs and cave walls).
        { suffix = "fels_schnee", name = "Verschneiter Fels",
          texture = "[fill:16x16:#566573^[fill:16x5:0,0:#ecf6ff^[fill:4x3:2,7:#ecf6ff" ..
                    "^[fill:3x2:10,8:#ecf6ff^[fill:3x2:6,11:#ecf6ff" },

        -- A warm, glowing campfire (warmth in a cold world).
        { suffix = "lagerfeuer", name = "Lagerfeuer",
          texture = "[fill:16x16:#5d4037^[fill:12x4:2,11:#7e5109^[fill:8x8:4,3:#e67e22" ..
                    "^[fill:4x6:6,4:#f1c40f^[fill:2x3:7,5:#fff2a8",
          glow = 13 },

        -- Per-face block: a real supply crate (lid on top, wood sides).
        { suffix = "proviantkiste", name = "Proviantkiste",
          top    = "[fill:16x16:#8d6e3a^[fill:16x2:0,0:#7fb3d5^[fill:16x2:0,14:#7fb3d5^[fill:2x2:7,7:#4a2f15",
          side   = "[fill:16x16:#8d6e3a^[fill:16x3:0,6:#7fb3d5^[fill:4x5:6,6:#4a2f15",
          bottom = "[fill:16x16:#6e552c" },

        -- Eigenes gemaltes Bild als Block? Lege eine PNG (16x16 oder 32x32)
        -- "lernwelt_eisbaer_meinbild.png" in den textures/-Ordner und entferne
        -- die zwei Minuszeichen vor der naechsten Zeile:
        -- { suffix = "meinbild", name = "Mein Bild", texture = "lernwelt_eisbaer_meinbild.png" },
    },

    -- --- 3) Learning zones (each gets a placeable learning board) ---
    -- Zone titles double as the "habitat" shown in the logbook.
    zones = {
        {
            id = "gefrorener_see", title = "Gefrorener See", color = "#5dade2",
            activity = "Auf und unter dem Eis: Tiere der kalten Bucht entdecken, " ..
                       "benennen und zaehlen (Pinguin, Robbe, Walross, Eisbaer). " ..
                       "Wer lebt im Wasser, wer auf dem Eis?",
            lehrplan = { "NMG.2", "MA.1", "BS.2" },
            tasks = {
                { type = "quiz",
                  question = "Welches Tier kann am besten schwimmen und taucht unter das Eis?",
                  options = { "Robbe", "Schneehase", "Rentier" }, answer = 1,
                  done = "Richtig! Die Robbe taucht unter dem Eis nach Fischen." },
                { type = "quiz",
                  question = "Der Pinguin lebt am liebsten ...",
                  options = { "im kalten Eis-Meer", "in der heissen Wueste", "im Vulkan" },
                  answer = 1,
                  done = "Genau! Pinguine lieben es kalt - das Eis-Meer ist ihr Zuhause." },
                { type = "rescue", creature = "pinguin", count = 2,
                  done = "Stark! Zwei Pinguinen geholfen." },
            },
        },
        {
            id = "schneewald", title = "Schneewald", color = "#85c1e9",
            activity = "Im verschneiten Wald leben flinke Tiere mit dickem, weissem " ..
                       "Fell (Schneehase, Polarfuchs, Rentier, Schneeeule). Spuren " ..
                       "lesen, Tiere benennen und Groessen ordnen.",
            lehrplan = { "NMG.2", "D.2", "MA.2" },
            tasks = {
                { type = "quiz",
                  question = "Warum ist der Polarfuchs im Winter weiss?",
                  options = { "Zum Tarnen im Schnee", "Weil er friert", "Aus Langeweile" },
                  answer = 1,
                  done = "Richtig! Weisses Fell tarnt den Polarfuchs im Schnee." },
                { type = "pattern",
                  -- a simple blue-white pattern to copy (Blau-Weiss-Muster)
                  sequence = { "#3498db", "#ffffff", "#3498db" },
                  palette  = { { "#3498db", "Blau" }, { "#ffffff", "Weiss" }, { "#2ecc71", "Gruen" } },
                  done = "Super! Muster blau-weiss-blau gelegt." },
                { type = "rescue", creature = "schneehase", count = 2,
                  done = "Klasse! Zwei Schneehasen geholfen." },
            },
        },
        {
            id = "polarlicht_hoehle", title = "Polarlicht-Hoehle", color = "#9b59b6",
            activity = "Eine ruhige Eishoehle mit leuchtendem Polarlicht (Aurora). " ..
                       "Hier hat der Eisbaer seine Hoehle. Hell und dunkel erleben, " ..
                       "die Farben des Polarlichts beobachten und Muster legen.",
            lehrplan = { "NMG.3", "NMG.2", "BG.1" },
            tasks = {
                { type = "quiz",
                  question = "Welche Farben hat ein Polarlicht oft?",
                  options = { "Gruen und blau", "Nur schwarz", "Rot-kariert" }, answer = 1,
                  done = "Richtig! Polarlichter leuchten oft gruen und blau." },
                { type = "pattern",
                  -- the aurora's colours as a pattern (NMG.3 / BG.1)
                  sequence = { "#5dade2", "#2ecc71", "#9b59b6" },
                  palette  = { { "#5dade2", "Blau" }, { "#2ecc71", "Gruen" }, { "#9b59b6", "Violett" } },
                  done = "Toll! Das Polarlicht-Muster blau-gruen-violett gelegt." },
                { type = "rescue", creature = "eisbaer", count = 1,
                  done = "Wunderbar! Dem grossen Eisbaer geholfen." },
            },
        },
    },

    -- --- 4) Rescuable animals (peaceful; right-click = help) ---
    --  Reusing the engine's gentle "rescue" loop: a right-click
    --  helps the animal, gives hearts, a sound, a counter entry and
    --  a rank. Swimming animals auto-spawn in water (engine); the
    --  land animals come alive via the theme's own land spawner (G).
    creatures = {
        {
            id = "pinguin", name = "Pinguin", zone = "gefrorener_see",
            color = "#2c3e50", size = 0.6, speed = 0.8,
            food = "Fische", power = "Watschelt und rutscht auf dem Bauch",
            heart = "#aed6f1",
            rescue_text = "Geholfen! Der Pinguin watschelt froehlich uebers Eis.",
        },
        {
            id = "robbe", name = "Robbe", zone = "gefrorener_see",
            color = "#7f8c8d", size = 0.9, speed = 1.1, swims = true, family = 1,
            food = "Fische", power = "Taucht unter dem Eis",
            heart = "#d6eaf8",
            rescue_text = "Geholfen! Die Robbe gleitet ins Wasser zurueck. Platsch!",
        },
        {
            id = "walross", name = "Walross", zone = "gefrorener_see",
            color = "#a04000", size = 1.4, speed = 0.5, family = 1,
            food = "Muscheln", power = "Hat zwei grosse Stosszaehne",
            heart = "#f5cba7",
            rescue_text = "Geholfen! Das Walross robbt zufrieden ins Wasser.",
        },
        {
            id = "beluga", name = "Beluga-Wal", zone = "gefrorener_see",
            color = "#eaf2f8", size = 1.6, speed = 0.8, swims = true,
            food = "Fische", power = "Ein weisser Wal, der singt",
            heart = "#d6eaf8",
            rescue_text = "Geholfen! Der weisse Beluga taucht singend ab.",
        },
        {
            id = "narwal", name = "Narwal", zone = "gefrorener_see",
            color = "#85c1e9", size = 1.5, speed = 1.0, swims = true,
            food = "Fische", power = "Das 'Einhorn des Meeres' mit langem Zahn",
            heart = "#d6eaf8",
            rescue_text = "Geholfen! Der Narwal mit dem langen Zahn gleitet davon.",
        },
        {
            id = "schneehase", name = "Schneehase", zone = "schneewald",
            color = "#ecf6ff", size = 0.5, speed = 1.5, family = 2,
            food = "Rinde und Moos", power = "Springt schnell durch den Schnee",
            heart = "#d6eaf8",
            rescue_text = "Geholfen! Der Schneehase hoppelt flink davon.",
        },
        {
            id = "polarfuchs", name = "Polarfuchs", zone = "schneewald",
            color = "#fbfcfc", size = 0.6, speed = 1.3,
            food = "kleine Tiere", power = "Weisses Fell zum Tarnen im Schnee",
            heart = "#d6eaf8",
            rescue_text = "Geholfen! Der Polarfuchs huscht durch den Schnee.",
        },
        {
            id = "rentier", name = "Rentier", zone = "schneewald",
            color = "#7e5109", size = 1.2, speed = 1.0, family = 2,
            food = "Flechten", power = "Grosses Geweih, zieht durch den Schnee",
            heart = "#f5cba7",
            rescue_text = "Geholfen! Das Rentier trabt zur Herde zurueck.",
        },
        {
            id = "schneeeule", name = "Schneeeule", zone = "schneewald",
            color = "#f7f9f9", size = 0.7, speed = 1.0,
            food = "Maeuse", power = "Fliegt lautlos, sieht alles",
            heart = "#d6eaf8",
            rescue_text = "Geholfen! Die Schneeeule fliegt lautlos in den Wald.",
        },
        {
            id = "eisbaer", name = "Eisbaer", zone = "polarlicht_hoehle",
            color = "#fbfcfc", size = 1.6, speed = 0.9, family = 1,
            food = "Robben und Fische", power = "Der grosse, starke Koenig des Eises",
            heart = "#d6eaf8",
            rescue_text = "Geholfen! Der grosse Eisbaer brummt zufrieden und tapst davon.",
        },
        {
            id = "leuchtfuchs", name = "Polarlicht-Fuchs", zone = "polarlicht_hoehle",
            color = "#a569bd", size = 0.6, speed = 1.4, glow = 9,
            food = "Sternenstaub", power = "Leuchtet in den Farben des Polarlichts",
            heart = "#d2b4ff",
            rescue_text = "Geholfen! Der Polarlicht-Fuchs leuchtet dir dankbar nach.",
        },
        {
            -- legendary, rare: never auto-spawns (egg/manual only)
            id = "polarlicht_baer", name = "Polarlicht-Baer", zone = "polarlicht_hoehle",
            color = "#a9cce3", size = 1.8, speed = 0.8, glow = 12, rare = true,
            food = "Polarlicht", power = "Ein sehr seltener, leuchtender Eisbaer",
            heart = "#eaf6ff",
            rescue_text = "Der legendaere Polarlicht-Baer schenkt dir ein magisches Leuchten!",
        },
    },

    -- --- 5) Ranks (3rd field = colour -> creates a badge item) ---
    ranks = {
        { 0,  "Schnee-Frischling" },
        { 5,  "Spurenleser" },
        { 10, "Polar-Forscher", "#3498db" },
        { 25, "Eisbaer-Freund", "#27ae60" },
        { 50, "Polar-Held",     "#f1c40f" },
    },

    -- --- 6) Logbook item ---
    logbook = { title = "Polar-Logbuch", item_color = "#aaddff" },

    -- --- 7) Plain texts for curriculum codes (for /lernplan & boards) ---
    kompetenzen = {
        ["NMG.2"] = "Tiere und Lebensraeume in der Kaelte erkunden",
        ["NMG.3"] = "Hell und dunkel erleben, das Polarlicht beobachten",
        ["MA.1"]  = "Mengen erfassen und Tiere zaehlen",
        ["MA.2"]  = "Muster, Reihen und Groessen ordnen",
        ["D.2"]   = "Tiere benennen und beschreiben",
        ["BS.2"]  = "Sich sicher auf Eis und Schnee bewegen",
        ["BG.1"]  = "Farben und Muster gestalten (blau-weiss)",
    },
})

-- ============================================================
--  THEME EXTRAS  (self-contained Lua the engine cannot express)
-- ============================================================

-- ------------------------------------------------------------
--  B) EXTRA: SCHLITTEN  (drivable sled)
--  Not part of the engine - a self-contained vehicle the theme
--  adds on its own. A sled that glides over snow and ice. Lives
--  in the same "lernwelt_eisbaer:" namespace. Controls: place ->
--  right-click to board -> W/S drive, A/D steer, jump = small hop,
--  right-click = exit. A second player can ride along.
-- ------------------------------------------------------------
local SLED_SPEED = 6

core.register_entity(L("schlitten"), {
    initial_properties = {
        physical = true, collide_with_objects = true,
        collisionbox = { -0.6, -0.3, -0.6, 0.6, 0.3, 0.6 },
        visual = "cube", visual_size = { x = 1.2, y = 0.5, z = 1.5 },
        textures = {
            "[fill:16x16:#5dade2", "[fill:16x16:#7e5109",
            "[fill:16x16:#8d6e3a", "[fill:16x16:#8d6e3a",
            "[fill:16x16:#aed6f1", "[fill:16x16:#aed6f1",
        },
    },
    _driver = nil, _passenger = nil, _snow = 0,

    on_rightclick = function(self, clicker)
        if not (clicker and clicker:is_player()) then return end
        local name = clicker:get_player_name()
        if self._driver == name then
            clicker:set_detach()
            clicker:set_eye_offset({ x = 0, y = 0, z = 0 }, { x = 0, y = 0, z = 0 })
            self._driver = nil
            core.chat_send_player(name, "Du steigst vom Schlitten ab.")
        elseif self._passenger == name then
            clicker:set_detach()
            clicker:set_eye_offset({ x = 0, y = 0, z = 0 }, { x = 0, y = 0, z = 0 })
            self._passenger = nil
            core.chat_send_player(name, "Du steigst als Mitfahrer ab.")
        elseif not self._driver then
            clicker:set_attach(self.object, "", { x = 0, y = 4, z = 0 }, { x = 0, y = 0, z = 0 })
            self._driver = name
            core.chat_send_player(name,
                "Schlitten los! W/S fahren, A/D lenken, Springen = kleiner Hops, " ..
                "Rechtsklick = absteigen. (Ein zweiter Spieler kann mitfahren!)")
        elseif not self._passenger then
            clicker:set_attach(self.object, "", { x = -4, y = 4, z = 0 }, { x = 0, y = 0, z = 0 })
            self._passenger = name
            core.chat_send_player(name, "Du faehrst als Mitfahrer mit! Rechtsklick = absteigen.")
        end
    end,

    on_step = function(self, dtime)
        -- gravity keeps the sled on the ground (it is no submarine)
        self.object:set_acceleration({ x = 0, y = -9, z = 0 })
        local driver = self._driver and core.get_player_by_name(self._driver)
        if not driver then
            local v = self.object:get_velocity()
            self.object:set_velocity({ x = 0, y = v and v.y or 0, z = 0 })
            self._driver = nil
            return
        end
        local ctrl = driver:get_player_control()
        local yaw  = self.object:get_yaw()
        if ctrl.left  then yaw = yaw + 0.05 end
        if ctrl.right then yaw = yaw - 0.05 end
        self.object:set_yaw(yaw)
        local dir = core.yaw_to_dir(yaw)
        local fwd = (ctrl.up and SLED_SPEED) or (ctrl.down and -SLED_SPEED * 0.5) or 0
        local v   = self.object:get_velocity()
        local vy  = v and v.y or 0
        if ctrl.jump and math.abs(vy) < 0.1 then vy = 4 end   -- a small hop
        self.object:set_velocity({ x = dir.x * fwd, y = vy, z = dir.z * fwd })

        -- a little snow spray while moving
        if fwd ~= 0 then
            self._snow = (self._snow or 0) + dtime
            if self._snow > 0.2 then
                self._snow = 0
                local p = self.object:get_pos()
                core.add_particlespawner({
                    amount = 6, time = 0.2,
                    minpos = vector.subtract(p, 0.5), maxpos = vector.add(p, 0.5),
                    minvel = { x = -0.4, y = 0.3, z = -0.4 },
                    maxvel = { x = 0.4,  y = 1.0, z = 0.4 },
                    minexptime = 0.4, maxexptime = 0.9, minsize = 1, maxsize = 2,
                    texture = "[fill:8x8:#ffffff",
                })
            end
        end
    end,
})

core.register_craftitem(L("schlitten"), {
    description     = "Schlitten (Fahrzeug)\nPlatzieren, dann Rechtsklick zum Aufsteigen",
    inventory_image = "[fill:16x16:#5dade2^[fill:12x4:2,9:#7e5109^[fill:3x6:3,3:#aed6f1",
    on_place = function(itemstack, placer, pointed_thing)
        if pointed_thing.type ~= "node" or not (placer and placer:is_player()) then
            return itemstack
        end
        local pos = pointed_thing.above
        pos.y = pos.y + 0.5
        core.add_entity(pos, L("schlitten"))
        if not core.is_creative_enabled(placer:get_player_name()) then
            itemstack:take_item()
        end
        return itemstack
    end,
})

-- ------------------------------------------------------------
--  C) EXTRA: POLARLICHT  (aurora that slowly cycles colour)
--  A self-contained light show for the Polarlicht-Hoehle: each
--  aurora node has a node timer and, every few seconds, swaps to
--  the next colour in the cycle (blau -> tuerkis -> gruen ->
--  violett -> weiss -> ...). Beautiful AND a gentle lesson about
--  colours/patterns (NMG.3 / BG.1). Place the base "polarlicht"
--  block; the coloured variants appear on their own.
-- ------------------------------------------------------------
local AURORA = {
    { "polarlicht",          "#5dade2" },   -- base (in creative inventory)
    { "polarlicht_tuerkis",  "#1abc9c" },
    { "polarlicht_gruen",    "#2ecc71" },
    { "polarlicht_violett",  "#9b59b6" },
    { "polarlicht_weiss",    "#eaf6ff" },
}
local AURORA_TIME = 4

for i, a in ipairs(AURORA) do
    local suffix    = a[1]
    local colour    = a[2]
    local is_base   = (i == 1)
    local nextname  = L(AURORA[(i % #AURORA) + 1][1])
    local groups    = { cracky = 3, oddly_breakable_by_hand = 2 }
    if not is_base then groups.not_in_creative_inventory = 1 end

    core.register_node(L(suffix), {
        description = is_base
            and "Polarlicht (Aurora)\nLeuchtet und wechselt langsam die Farbe"
            or  "Polarlicht (" .. colour .. ")",
        drawtype            = "glasslike",
        paramtype           = "light",
        sunlight_propagates = true,
        tiles = { "[fill:16x16:" .. colour .. "^[fill:16x3:0,3:#ffffff^[fill:16x2:0,10:#ffffff" },
        light_source        = 12,
        groups              = groups,
        drop                = L("polarlicht"),
        is_ground_content   = false,
        after_place_node    = function(pos)
            core.get_node_timer(pos):start(AURORA_TIME)
        end,
        on_timer = function(pos)
            local p2 = core.get_node(pos).param2
            core.swap_node(pos, { name = nextname, param2 = p2 })
            core.get_node_timer(pos):start(AURORA_TIME)
            return false
        end,
    })
end

-- ------------------------------------------------------------
--  D) EXTRA: STARTER KIT  (handed out once on first join)
--  Makes the world testable right away: the logbook, the camera,
--  the sled, a polarlicht block, a feeding station + fish, ice
--  flower saplings, a stack of each snow/ice/pattern block, and
--  one spawn egg per cold animal (the engine registers the eggs
--  when a mob API is present; missing items are simply skipped).
--  Turn off via the setting "lernwelt_eisbaer_starter_kit".
-- ------------------------------------------------------------
local STARTER_BLOCKS = {
    "schnee", "packeis", "blaueis", "klareis", "iglu_block", "eisziegel",
    "muster_streifen", "muster_punkte", "muster_schach", "muster_welle",
    "schneeflocke_block", "eiskristall", "fels_schnee", "lagerfeuer",
    "proviantkiste", "polarlicht",
}
-- Spawn-egg item names match the creature ids (world_id:creature_id)
local STARTER_EGGS = {
    "pinguin", "robbe", "walross", "beluga", "narwal",
    "schneehase", "polarfuchs", "rentier", "schneeeule",
    "eisbaer", "leuchtfuchs", "polarlicht_baer",
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
    give_if_exists(inv, L("schlitten"))
    give_if_exists(inv, L("fisch") .. " 20")
    give_if_exists(inv, L("futterstelle") .. " 2")
    give_if_exists(inv, L("eisblume_setzling") .. " 5")
    for _, suffix in ipairs(STARTER_BLOCKS) do
        give_if_exists(inv, L(suffix) .. " 10")
    end
    for _, cid in ipairs(STARTER_EGGS) do
        give_if_exists(inv, L(cid))
    end
    core.chat_send_player(player:get_player_name(),
        "Eisbaer-Bucht: Startausruestung erhalten - Polar-Logbuch, Kamera, Schlitten, " ..
        "Fisch + Futterstelle, Eisblumen-Setzlinge, Schnee-/Eis-/Muster-Bloecke und " ..
        "Spawn-Eier. Tipp: '/eisbaer_eispalast' baut dir einen ganzen Eispalast. " ..
        "Viel Spass in der Kaelte!")
end

core.register_on_joinplayer(function(player)
    if not core.settings:get_bool("lernwelt_eisbaer_starter_kit", true) then return end
    local meta = player:get_meta()
    if meta:get_int("lernwelt_eisbaer:starter_given") == 1 then return end
    meta:set_int("lernwelt_eisbaer:starter_given", 1)
    -- slight delay so the inventory exists and the message is seen
    core.after(1.5, function()
        if player and player:is_player() then give_starter_kit(player) end
    end)
end)

-- ------------------------------------------------------------
--  E) EXTRA: TIERE FUETTERN  (feeding station + caring counter)
--  Caring for cold animals: hold a "Fisch" (food) and right-click
--  a "Futterstelle" to feed. Each feed adds to a personal counter
--  with small milestones. Fits the theme's motto: "Bewahren".
-- ------------------------------------------------------------
core.register_craftitem(L("fisch"), {
    description     = "Fisch (Tierfutter)\nFisch in die Hand nehmen und eine Futterstelle " ..
                      "mit Rechtsklick fuettern",
    inventory_image = "[fill:16x16:#85c1e9^[fill:9x5:3,6:#5dade2^[fill:4x4:11,6:#5dade2" ..
                      "^[fill:2x2:5,7:#2c3e50",
    groups          = { food = 1 },
})

local FEED_MILESTONES = {
    [5]  = "Tier-Freund",
    [15] = "Polar-Pfleger",
    [30] = "Kaelte-Kuemmerer",
}

core.register_node(L("futterstelle"), {
    description = "Futterstelle\nFisch in die Hand nehmen, Rechtsklick = Tiere fuettern",
    tiles = {
        "[fill:16x16:#8d6e3a^[fill:12x12:2,2:#aed6f1^[fill:5x4:3,4:#5dade2^[fill:4x4:9,7:#5dade2",
        "[fill:16x16:#6e552c",
        "[fill:16x16:#8d6e3a^[fill:16x3:0,6:#7fb3d5",
    },
    paramtype2        = "facedir",
    groups            = { cracky = 2, oddly_breakable_by_hand = 2 },
    is_ground_content = false,
    on_rightclick = function(pos, node, clicker)
        if not (clicker and clicker:is_player()) then return end
        local name    = clicker:get_player_name()
        local wielded = clicker:get_wielded_item()
        if wielded:get_name() ~= L("fisch") then
            core.chat_send_player(name,
                "Die Futterstelle braucht Fisch. Nimm 'Fisch' in die Hand und mach Rechtsklick.")
            return
        end
        if not core.is_creative_enabled(name) then
            wielded:take_item(); clicker:set_wielded_item(wielded)
        end
        core.add_particlespawner({
            amount = 12, time = 0.3,
            minpos = vector.subtract(pos, 0.4), maxpos = vector.add(pos, 0.4),
            minvel = { x = -0.6, y = 1, z = -0.6 }, maxvel = { x = 0.6, y = 2, z = 0.6 },
            minexptime = 0.4, maxexptime = 0.9, minsize = 1, maxsize = 3,
            texture = "[fill:8x8:#aed6f1",
        })
        core.sound_play("lernwelt_rescue", { to_player = name, gain = 0.6 })
        local meta = clicker:get_meta()
        local n = meta:get_int("lernwelt_eisbaer:gefuettert") + 1
        meta:set_int("lernwelt_eisbaer:gefuettert", n)
        core.chat_send_player(name, "Tiere gefuettert! Satte Tiere: " .. n)
        local title = FEED_MILESTONES[n]
        if title then
            core.sound_play("lernwelt_rankup", { to_player = name, gain = 1.0 })
            core.chat_send_player(name, "Toll! Du bist jetzt: " .. title .. "!")
        end
    end,
})

-- ------------------------------------------------------------
--  F) EXTRA: EISBLUMEN PFLANZEN  (plant & grow blue-white patterns)
--  A sapling you place; after a while it grows into a random
--  blue-white pattern block. Each grown flower adds to a personal
--  counter. Reinforces the theme's art focus (Blau-Weiss-Muster).
-- ------------------------------------------------------------
local FLOWER_GROWN = {
    "muster_streifen", "muster_punkte", "muster_schach",
    "muster_welle", "schneeflocke_block",
}
local GROW_TIME = 20

core.register_node(L("eisblume_setzling"), {
    description = "Eisblumen-Setzling\nSetzen - waechst zu einem blau-weissen Muster-Block",
    drawtype = "plantlike",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    floodable = false,
    tiles = { "[fill:16x16:#aed6f1^[fill:6x10:5,3:#ffffff^[fill:4x4:6,2:#5dade2" },
    inventory_image = "[fill:16x16:#aed6f1^[fill:6x10:5,3:#ffffff^[fill:4x4:6,2:#5dade2",
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
        core.set_node(pos, { name = L(FLOWER_GROWN[math.random(#FLOWER_GROWN)]) })
        if planter ~= "" then
            local p = core.get_player_by_name(planter)
            if p then
                local meta = p:get_meta()
                local n = meta:get_int("lernwelt_eisbaer:eisblumen") + 1
                meta:set_int("lernwelt_eisbaer:eisblumen", n)
                core.sound_play("lernwelt_rescue", { to_player = planter, gain = 0.6 })
                core.chat_send_player(planter, "Eine Eisblume ist gewachsen! Muster-Bloecke: " .. n)
            end
        end
        return false
    end,
})

-- ------------------------------------------------------------
--  G) ANIMAL LAND SPAWNER  (a living bay)
--  The engine's built-in spawner only places water animals, so
--  this small, backend-agnostic spawner brings the land animals
--  to life: every so often it tries to add one non-rare land
--  animal on solid ground with air above, near a player, capped
--  so the bay never gets crowded. Turn off with the setting
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
--  H) EXTRA: BASE COMMANDS  (Iglu, Eispalast, test station)
--  Ready-made builds in front of you. All need the "server"
--  privilege (automatic in single-player).
-- ------------------------------------------------------------
local BOARDS = {
    L("tafel_gefrorener_see"),
    L("tafel_schneewald"),
    L("tafel_polarlicht_hoehle"),
}

-- A small igloo: a snow-brick dome with a doorway, a warm fire
-- inside and one learning board.
core.register_chatcommand("eisbaer_iglu", {
    description = "Baut ein kleines Iglu vor dir (Schnee-Kuppel, Lagerfeuer, eine Lern-Tafel)",
    privs = { server = true },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then return false, "Dieser Befehl funktioniert nur im Spiel." end
        local b    = vector.round(player:get_pos())
        local fy   = b.y - 1
        local cz   = b.z + 4          -- centre of the dome
        local R    = 3
        local snow = L("iglu_block")

        for dx = -R, R do
            for dz = -R, R do
                for dy = 0, R do
                    local d = math.sqrt(dx * dx + dy * dy + dz * dz)
                    local x, y, z = b.x + dx, fy + dy, cz + dz
                    if dy == 0 then
                        core.set_node({ x = x, y = y, z = z }, { name = snow })   -- floor
                    elseif d >= R - 0.5 and d <= R + 0.5 then
                        -- a doorway on the near (-z) side
                        local door = (dx == 0 and dz == -R and dy <= 1)
                        core.set_node({ x = x, y = y, z = z },
                            { name = door and "air" or snow })
                    end
                end
            end
        end
        -- a warm fire and a board inside
        core.set_node({ x = b.x, y = fy + 1, z = cz }, { name = L("lagerfeuer") })
        if core.registered_nodes[L("tafel_gefrorener_see")] then
            core.set_node({ x = b.x, y = fy + 1, z = cz + R - 1 },
                { name = L("tafel_gefrorener_see"), param2 = 2 })
        end
        return true, "Iglu gebaut! Geh durch den Eingang - drinnen waermt ein Lagerfeuer " ..
                     "und eine Lern-Tafel wartet."
    end,
})

-- The signature base: a roomy ICE PALACE with clear-ice walls, the
-- three learning boards, a glowing aurora wall, a warm fire, a sled,
-- a feeding station and some ice-flower saplings.
core.register_chatcommand("eisbaer_eispalast", {
    description = "Baut einen ganzen Eispalast vor dir (Halle, 3 Tafeln, Polarlicht-Wand, " ..
                  "Schlitten, Futterstelle)",
    privs = { server = true },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then return false, "Dieser Befehl funktioniert nur im Spiel." end
        local b    = vector.round(player:get_pos())
        local fy   = b.y - 1
        local z0   = b.z + 2
        local W    = 5                -- half-width (x: -5..5)
        local DEEP = 12               -- depth (z: 0..12)
        local floor = L("blaueis")
        local wall  = L("eisziegel")
        local glass = L("klareis")

        for dx = -W, W do
            for dz = 0, DEEP do
                local x, z = b.x + dx, z0 + dz
                core.set_node({ x = x, y = fy, z = z }, { name = floor })
                local edge = (dx == -W or dx == W or dz == 0 or dz == DEEP)
                for dy = 1, 4 do
                    -- a doorway on the near (z0) side
                    local door = (dz == 0 and dx == 0 and dy <= 2)
                    if edge and not door then
                        local mat = (dy == 4) and glass or wall
                        core.set_node({ x = x, y = fy + dy, z = z }, { name = mat })
                    elseif dy == 4 then
                        core.set_node({ x = x, y = fy + dy, z = z }, { name = glass })  -- ceiling
                    end
                end
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

        -- a glowing aurora wall on the left (start each node's colour timer,
        -- since set_node does not call after_place_node), a warm fire and crystals
        for dy = 1, 3 do
            for _, zz in ipairs({ z0 + 3, z0 + 4 }) do
                local ap = { x = b.x - W + 1, y = fy + dy, z = zz }
                core.set_node(ap, { name = L("polarlicht") })
                core.get_node_timer(ap):start(4)
            end
        end
        core.set_node({ x = b.x, y = fy + 1, z = z0 + 2 }, { name = L("lagerfeuer") })
        core.set_node({ x = b.x + W - 1, y = fy + 1, z = z0 + 3 }, { name = L("eiskristall") })

        -- a feeding station + a couple of ice-flower saplings on the right
        core.set_node({ x = b.x + W - 1, y = fy + 1, z = z0 + 5 }, { name = L("futterstelle") })
        core.set_node({ x = b.x + W - 2, y = fy + 1, z = z0 + 6 }, { name = L("eisblume_setzling") })
        core.get_node_timer({ x = b.x + W - 2, y = fy + 1, z = z0 + 6 }):start(GROW_TIME)

        -- a sled ready to board, near the entrance
        core.add_entity({ x = b.x, y = fy + 1.5, z = z0 + 1 }, L("schlitten"))

        return true, "Eispalast gebaut! Drinnen leuchtet links eine Polarlicht-Wand, in der " ..
                     "Mitte waermt ein Lagerfeuer, rechts stehen Futterstelle und Eisblume. " ..
                     "Vorne wartet ein Schlitten, hinten die drei Lern-Tafeln."
    end,
})

-- A small test station: a snow floor, the three boards, a sled, a
-- polarlicht block and a few ice-flower saplings.
core.register_chatcommand("eisbaer_teststation", {
    description = "Baut eine kleine Test-Station vor dir (Schneeboden, 3 Lern-Tafeln, " ..
                  "Schlitten, Polarlicht)",
    privs = { server = true },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then return false, "Dieser Befehl funktioniert nur im Spiel." end
        local base    = vector.round(player:get_pos())
        local floor_y = base.y - 1
        local floor   = L("schnee")

        for dx = -3, 3 do
            for dz = 2, 6 do
                core.set_node({ x = base.x + dx, y = floor_y, z = base.z + dz }, { name = floor })
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

        -- a small glowing polarlicht and an ice-flower sapling
        core.set_node({ x = base.x - 2, y = floor_y + 1, z = base.z + 2 }, { name = L("polarlicht") })
        core.get_node_timer({ x = base.x - 2, y = floor_y + 1, z = base.z + 2 }):start(4)
        core.set_node({ x = base.x + 2, y = floor_y + 1, z = base.z + 2 },
            { name = L("eisblume_setzling") })
        core.get_node_timer({ x = base.x + 2, y = floor_y + 1, z = base.z + 2 }):start(GROW_TIME)

        -- a sled ready to board
        core.add_entity({ x = base.x, y = floor_y + 1.5, z = base.z + 4 }, L("schlitten"))

        return true, "Test-Station gebaut! Drei Lern-Tafeln, ein leuchtendes Polarlicht, eine " ..
                     "Eisblume und ein Schlitten stehen vor dir (Richtung +Z)."
    end,
})

-- ------------------------------------------------------------
--  I) EXTRA: AMBIENT-SOUND  (wind / whale song)
--  Plays a gentle polar sound to each player now and then. The
--  .ogg files are optional (missing = silent, only a warning).
-- ------------------------------------------------------------
local amb_timer, amb_next = 0, 45
core.register_globalstep(function(dtime)
    amb_timer = amb_timer + dtime
    if amb_timer < amb_next then return end
    amb_timer = 0
    amb_next = 35 + math.random(0, 40)
    for _, player in ipairs(core.get_connected_players()) do
        local snd = (math.random() < 0.5) and "_wind" or "_ambient"
        core.sound_play(WORLD_ID .. snd, { to_player = player:get_player_name(), gain = 0.4 })
    end
end)

-- ------------------------------------------------------------
--  J) EXTRA: BUCHSTABEN-BLOECKE  (A-Z, zum Woerterlegen)
--  A tiny 5x7 pixel font rendered into each block's texture with
--  layered "[fill" - no image files. Nice for "Deutsch / benennen":
--  lay out animal names and simple words from letter blocks.
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
    local t = { "[fill:16x16:#eaf6ff" }
    for r = 1, #rows do
        local row = rows[r]
        for c = 1, #row do
            if row:sub(c, c) == "#" then
                t[#t + 1] = ("^[fill:2x2:%d,%d:#2980b9"):format(3 + (c - 1) * 2, 1 + (r - 1) * 2)
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

core.log("action", "[lernwelt_eisbaer] Theme 'Eisbaer-Bucht' registered (on lernwelt engine).")
