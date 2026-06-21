-- ============================================================
--  THEME:  NASCHWERK-TAL  (sweets / candy world)
--  A brand-free candy learning world built ON TOP of the
--  reusable "lernwelt" engine. Almost everything below is one
--  declarative register_world{...} call - blocks, learning
--  zones, helpable candy creatures, logbook, ranks and badges
--  all come from the engine.
--
--  The theme's heart is EARLY MATHS: counting quantities
--  (MA.1), recognising and continuing PATTERNS (rot-gelb-rot ...)
--  and naming COLOURS - wrapped in an extremely appealing candy
--  world that little children love. The base is a "Lebkuchenhaus"
--  (gingerbread house) and the valley has three zones: a
--  Schoko-Fluss (chocolate river), a Lolli-Wald (lollipop forest)
--  and Gummi-Huegel (gummy hills).
--  (Lehrplan 21: MA.1 Mengen & Zahlen, MA.2 Muster, BG.1 Farben.)
--
--  Things the engine cannot express live as small pieces of
--  custom code after register_world:
--    B) a drivable "Naschwagen" (candy cart that sprays sprinkles)
--    C) the "Regenbogen-Lolli" (a candy block that cycles colour)
--    D) a first-join starter kit (quick testing)
--    E) the "Zaehl-Naschtisch" (an interactive counting game, MA.1)
--    F) "Naschtiere fuettern" (a candy bowl + caring counter)
--    G) "Lollis pflanzen" (plant & grow colourful candy blocks)
--    H) a land spawner so the candy creatures come alive
--    I) base commands (Lebkuchenhaus, test station)
--    ...plus ambient sound and letter blocks.
--
--  The mod name equals the world id ("lernwelt_naschwerk"), so all
--  nodes/items live in the "lernwelt_naschwerk:" namespace.
--
--  Content is authored in German (ASCII: ae/oe/ue), like the
--  other example themes. The engine's own UI is translated
--  separately via lernwelt/locale/*.tr.
-- ============================================================

local WORLD_ID = "lernwelt_naschwerk"
local function L(suffix) return WORLD_ID .. ":" .. suffix end

-- ------------------------------------------------------------
--  A) THE WHOLE LEARNING WORLD AS ONE DECLARATIVE TABLE
-- ------------------------------------------------------------
lernwelt.register_world({

    -- internal prefix; kept identical to the mod name so all
    -- nodes/items live in the "lernwelt_naschwerk:" namespace
    id    = WORLD_ID,
    title = "Naschwerk-Tal",

    -- --- 1) Peaceful, child-friendly world ---
    config = {
        damage      = false,   -- no damage / no dying
        creative    = true,    -- unlimited blocks
        peaceful    = true,    -- no monsters
        freeze_time = "day",   -- always bright and sunny
        no_weather  = true,
    },

    -- --- 2) Lots of bright, colourful candy blocks ---
    --  The "texture" field is a Luanti texture-modifier string: a
    --  base "[fill" plus overlaid "^[fill:WxH:X,Y:#colour" rectangles.
    blocks = {
        -- Building blocks for the gingerbread house (the base).
        { suffix = "lebkuchen", name = "Lebkuchen",
          texture = "[fill:16x16:#b06a32^[fill:3x3:2,2:#fff8e7^[fill:3x3:11,2:#fff8e7" ..
                    "^[fill:3x3:2,11:#fff8e7^[fill:3x3:11,11:#fff8e7^[fill:2x2:7,7:#fff8e7" },
        { suffix = "lebkuchen_ziegel", name = "Lebkuchen-Ziegel (mit Zuckerguss)",
          texture = "[fill:16x16:#a85a28^[fill:16x1:0,5:#fff8e7^[fill:16x1:0,11:#fff8e7" ..
                    "^[fill:1x5:8,0:#fff8e7^[fill:1x6:4,6:#fff8e7^[fill:1x6:12,6:#fff8e7" },
        { suffix = "zuckerguss", name = "Zuckerguss",
          texture = "[fill:16x16:#fdf2f8^[fill:6x6:2,2:#ffffff^[fill:6x6:9,9:#ffffff" ..
                    "^[fill:4x4:9,2:#ffffff^[fill:4x4:2,9:#ffffff" },
        { suffix = "schokolade", name = "Schokolade",
          texture = "[fill:16x16:#4a2c11^[fill:7x7:1,1:#6b3e1d^[fill:7x7:8,1:#6b3e1d" ..
                    "^[fill:7x7:1,8:#6b3e1d^[fill:7x7:8,8:#6b3e1d" },
        { suffix = "weisse_schokolade", name = "Weisse Schokolade",
          texture = "[fill:16x16:#d8c08a^[fill:7x7:1,1:#efe0bf^[fill:7x7:8,1:#efe0bf" ..
                    "^[fill:7x7:1,8:#efe0bf^[fill:7x7:8,8:#efe0bf" },
        { suffix = "keks", name = "Keks (mit Schoko-Stueckchen)",
          texture = "[fill:16x16:#d9a566^[fill:3x3:3,3:#5b3a1a^[fill:2x2:10,4:#5b3a1a" ..
                    "^[fill:3x3:9,9:#5b3a1a^[fill:2x2:4,10:#5b3a1a" },
        { suffix = "waffel", name = "Waffel",
          texture = "[fill:16x16:#e0b873^[fill:16x2:0,4:#b8894a^[fill:16x2:0,10:#b8894a" ..
                    "^[fill:2x16:4,0:#b8894a^[fill:2x16:10,0:#b8894a" },
        { suffix = "zuckerwatte_rosa", name = "Zuckerwatte (rosa)",
          texture = "[fill:16x16:#ff9ed2^[fill:5x5:2,2:#ffc4e6^[fill:5x5:9,3:#ffc4e6" ..
                    "^[fill:5x5:4,9:#ffc4e6" },
        { suffix = "zuckerwatte_blau", name = "Zuckerwatte (blau)",
          texture = "[fill:16x16:#9ed8ff^[fill:5x5:2,2:#c8ebff^[fill:5x5:9,3:#c8ebff" ..
                    "^[fill:5x5:4,9:#c8ebff" },
        { suffix = "lakritz", name = "Lakritz",
          texture = "[fill:16x16:#1a1a1a^[fill:16x2:0,4:#444444^[fill:16x2:0,10:#444444" },

        -- A warm, glowing caramel block (cosy lamp-light).
        { suffix = "karamell", name = "Karamell",
          texture = "[fill:16x16:#c87f1e^[fill:16x3:0,5:#e8a13a^[fill:6x6:5,5:#f0c060",
          glow = 8 },

        -- GUMMY blocks (glass = true -> lovely translucent gummy look).
        { suffix = "gummi_rot",    name = "Gummi (rot)",    color = "#e7392b", glass = true },
        { suffix = "gummi_gruen",  name = "Gummi (gruen)",  color = "#28c24a", glass = true },
        { suffix = "gummi_gelb",   name = "Gummi (gelb)",   color = "#f4c20d", glass = true },
        { suffix = "gummi_orange", name = "Gummi (orange)", color = "#ff7f11", glass = true },

        -- DROPS (bright candy buttons): the theme's pattern/colour
        -- focus - build with these and copy them at the boards
        -- (Muster nachlegen: rot-gelb-rot ...).
        { suffix = "drops_rot", name = "Drops (rot)",
          texture = "[fill:16x16:#e74c3c^[fill:5x4:3,3:#ff9e93^[fill:16x3:0,13:#a83228" },
        { suffix = "drops_gelb", name = "Drops (gelb)",
          texture = "[fill:16x16:#f1c40f^[fill:5x4:3,3:#fff19a^[fill:16x3:0,13:#c79a08" },
        { suffix = "drops_blau", name = "Drops (blau)",
          texture = "[fill:16x16:#3498db^[fill:5x4:3,3:#a9d6f5^[fill:16x3:0,13:#21618c" },
        { suffix = "drops_gruen", name = "Drops (gruen)",
          texture = "[fill:16x16:#2ecc71^[fill:5x4:3,3:#abebc6^[fill:16x3:0,13:#1e8449" },

        -- Decorative candy patterns.
        { suffix = "zuckerstange", name = "Zuckerstange (rot-weiss)",
          texture = "[fill:16x16:#ffffff^[fill:4x16:0,0:#e74c3c^[fill:4x16:8,0:#e74c3c" },
        { suffix = "bonbon_streifen", name = "Bonbon (gestreift)",
          texture = "[fill:16x16:#f5b7d0^[fill:3x16:1,0:#e74c3c^[fill:3x16:7,0:#f1c40f" ..
                    "^[fill:3x16:13,0:#3498db" },
        { suffix = "lolli_block", name = "Lolli (Wirbel)",
          texture = "[fill:16x16:#ffffff^[fill:14x14:1,1:#e74c3c^[fill:10x10:3,3:#ffffff" ..
                    "^[fill:6x6:5,5:#e74c3c^[fill:2x2:7,7:#ffffff" },

        -- A glowing candy lamp.
        { suffix = "bonbon_glas", name = "Bonbon-Lampe",
          texture = "[fill:16x16:#ffd23f^[fill:8x8:4,4:#fff4c2^[fill:4x4:6,6:#ffffff",
          glow = 12 },

        -- Per-face block: a real candy box (lid + ribbon on top).
        { suffix = "naschkiste", name = "Naschkiste",
          top    = "[fill:16x16:#ec7fb8^[fill:2x16:7,0:#ffe06b^[fill:16x2:0,7:#ffe06b^[fill:4x4:6,6:#fff0a8",
          side   = "[fill:16x16:#ec7fb8^[fill:16x3:0,6:#ffe06b^[fill:4x5:6,6:#fff0a8",
          bottom = "[fill:16x16:#c75f98" },

        -- Eigenes gemaltes Bild als Block? Lege eine PNG (16x16 oder 32x32)
        -- "lernwelt_naschwerk_meinbild.png" in den textures/-Ordner und entferne
        -- die zwei Minuszeichen vor der naechsten Zeile:
        -- { suffix = "meinbild", name = "Mein Bild", texture = "lernwelt_naschwerk_meinbild.png" },
    },

    -- --- 3) Learning zones (each gets a placeable learning board) ---
    -- Zone titles double as the "habitat" shown in the logbook.
    zones = {
        {
            id = "schoko_fluss", title = "Schoko-Fluss", color = "#8a5a2b",
            activity = "Am suessen Schoko-Fluss schwimmen lustige Naschtiere. " ..
                       "Zaehle, wie viele du siehst, und benenne ihre Farben " ..
                       "(Schoko-Fisch, Marshmallow-Schwan, Keks-Schildkroete).",
            lehrplan = { "MA.1", "BG.1", "D.2" },
            tasks = {
                { type = "quiz",
                  question = "Welche Farbe hat Schokolade?",
                  options = { "Braun", "Blau", "Gruen" }, answer = 1,
                  done = "Richtig! Schokolade ist braun." },
                { type = "quiz",
                  question = "Du siehst 2 Schoko-Fische, 1 kommt dazu. Wie viele sind es?",
                  options = { "3", "5", "2" }, answer = 1,
                  done = "Genau! 2 und 1 dazu sind 3." },
                { type = "rescue", creature = "schoko_fisch", count = 3,
                  done = "Stark! Drei Schoko-Fischen geholfen." },
            },
        },
        {
            id = "lolli_wald", title = "Lolli-Wald", color = "#ff7fbf",
            activity = "Im bunten Lolli-Wald wachsen Lollis und Zuckerwatte. " ..
                       "Lege bunte Muster (rot-gelb-rot ...) und benenne die Farben. " ..
                       "Welche Farbe kommt als naechstes?",
            lehrplan = { "MA.2", "BG.1", "MA.1" },
            tasks = {
                { type = "pattern",
                  -- the classic rot-gelb-rot pattern to copy (MA.2 / BG.1)
                  sequence = { "#e74c3c", "#f1c40f", "#e74c3c" },
                  palette  = { { "#e74c3c", "Rot" }, { "#f1c40f", "Gelb" }, { "#3498db", "Blau" } },
                  done = "Super! Muster rot-gelb-rot gelegt." },
                { type = "quiz",
                  question = "Muster: rot - gelb - rot - gelb - ? Welche Farbe kommt?",
                  options = { "Rot", "Blau", "Gruen" }, answer = 1,
                  done = "Richtig! Nach gelb kommt wieder rot." },
                { type = "rescue", creature = "zuckerwatte_schaf", count = 2,
                  done = "Klasse! Zwei Zuckerwatte-Schafen geholfen." },
            },
        },
        {
            id = "gummi_huegel", title = "Gummi-Huegel", color = "#43c463",
            activity = "Auf den weichen Gummi-Huegeln huepfen Gummibaeren. Zaehle " ..
                       "groessere Mengen, sortiere die Farben und lege ein langes " ..
                       "buntes Muster.",
            lehrplan = { "MA.1", "MA.2", "BG.1" },
            tasks = {
                { type = "quiz",
                  question = "Zaehle: 3 Gummibaeren und 2 dazu. Wie viele sind es?",
                  options = { "5", "4", "6" }, answer = 1,
                  done = "Richtig! 3 und 2 dazu sind 5." },
                { type = "pattern",
                  -- a longer three-colour pattern (MA.2)
                  sequence = { "#2ecc71", "#f1c40f", "#e74c3c" },
                  palette  = { { "#e74c3c", "Rot" }, { "#f1c40f", "Gelb" },
                               { "#2ecc71", "Gruen" }, { "#3498db", "Blau" } },
                  done = "Toll! Das Muster gruen-gelb-rot gelegt." },
                { type = "rescue", creature = "gummibaer", count = 3,
                  done = "Wunderbar! Drei Gummibaeren geholfen." },
            },
        },
    },

    -- --- 4) Helpable candy creatures (peaceful; right-click = help) ---
    --  Reusing the engine's gentle "rescue" loop: a right-click
    --  helps the creature, gives hearts, a sound, a counter entry and
    --  a rank. Swimming creatures auto-spawn in water (engine); the
    --  land creatures come alive via the theme's own land spawner (H).
    creatures = {
        {
            id = "schoko_fisch", name = "Schoko-Fisch", zone = "schoko_fluss",
            color = "#5b3a1a", size = 0.6, speed = 1.1, swims = true,
            food = "Schokostreusel", power = "Schwimmt im Schoko-Fluss",
            heart = "#d9a566",
            rescue_text = "Geholfen! Der Schoko-Fisch taucht froehlich ab. Platsch!",
        },
        {
            id = "marshmallow_schwan", name = "Marshmallow-Schwan", zone = "schoko_fluss",
            color = "#fff0f5", size = 1.0, speed = 0.9, swims = true, family = 1,
            food = "Zuckerperlen", power = "Gleitet weich ueber den Fluss",
            heart = "#ffd0e6",
            rescue_text = "Geholfen! Der Marshmallow-Schwan gleitet sanft davon.",
        },
        {
            id = "keks_schildkroete", name = "Keks-Schildkroete", zone = "schoko_fluss",
            color = "#d9a566", size = 0.8, speed = 0.6, swims = true,
            food = "Kekskruemel", power = "Traegt einen Keks-Panzer",
            heart = "#e0b873",
            rescue_text = "Geholfen! Die Keks-Schildkroete paddelt gemuetlich weiter.",
        },
        {
            id = "brause_qualle", name = "Brause-Qualle", zone = "schoko_fluss",
            color = "#b39ddb", size = 0.7, speed = 0.8, swims = true, glow = 9,
            food = "Brausepulver", power = "Leuchtet und sprudelt",
            heart = "#d2b4ff",
            rescue_text = "Geholfen! Die Brause-Qualle sprudelt leuchtend davon.",
        },
        {
            id = "zuckerwatte_schaf", name = "Zuckerwatte-Schaf", zone = "lolli_wald",
            color = "#ff9ed2", size = 0.9, speed = 1.0, family = 2,
            food = "Zuckerwatte", power = "Weich wie eine rosa Wolke",
            heart = "#ffc4e6",
            rescue_text = "Geholfen! Das Zuckerwatte-Schaf huepft weich davon.",
        },
        {
            id = "lolli_vogel", name = "Lolli-Vogel", zone = "lolli_wald",
            color = "#e74c3c", size = 0.5, speed = 1.4,
            food = "Bonbons", power = "Hat einen bunten Lolli-Schopf",
            heart = "#ff9e93",
            rescue_text = "Geholfen! Der Lolli-Vogel flattert zwitschernd in die Lollis.",
        },
        {
            id = "bonbon_hase", name = "Bonbon-Hase", zone = "lolli_wald",
            color = "#f5b7d0", size = 0.5, speed = 1.5, family = 2,
            food = "Bonbons", power = "Huepft flink durch den Lolli-Wald",
            heart = "#ffd0e6",
            rescue_text = "Geholfen! Der Bonbon-Hase hoppelt flink davon.",
        },
        {
            id = "karamell_eichhoernchen", name = "Karamell-Eichhoernchen", zone = "lolli_wald",
            color = "#c87f1e", size = 0.6, speed = 1.3,
            food = "Karamell-Nuesse", power = "Sammelt klebriges Karamell",
            heart = "#e8a13a",
            rescue_text = "Geholfen! Das Karamell-Eichhoernchen flitzt den Lolli hoch.",
        },
        {
            id = "gummibaer", name = "Gummibaer", zone = "gummi_huegel",
            color = "#e7392b", size = 0.6, speed = 1.1, family = 2,
            food = "Fruchtgummi", power = "Weich und wackelig",
            heart = "#ff8a7f",
            rescue_text = "Geholfen! Der Gummibaer wackelt vergnuegt davon.",
        },
        {
            id = "lakritz_schnecke", name = "Lakritz-Schnecke", zone = "gummi_huegel",
            color = "#2c2c2c", size = 0.5, speed = 0.3,
            food = "Lakritz-Blaetter", power = "Traegt ein Lakritz-Schneckenhaus",
            heart = "#888888",
            rescue_text = "Geholfen! Die Lakritz-Schnecke kriecht gemuetlich weiter.",
        },
        {
            id = "zucker_maus", name = "Zucker-Maus", zone = "gummi_huegel",
            color = "#f6d8e8", size = 0.4, speed = 1.6, family = 2,
            food = "Zuckerkruemel", power = "Flink und kunterbunt",
            heart = "#ffd0e6",
            rescue_text = "Geholfen! Die Zucker-Maus huscht piepsend davon.",
        },
        {
            -- legendary, rare: never auto-spawns (egg/manual only)
            id = "regenbogen_fee", name = "Regenbogen-Lolli-Fee", zone = "gummi_huegel",
            color = "#b76cff", size = 0.6, speed = 1.4, glow = 12, rare = true,
            food = "Regenbogen-Zucker", power = "Sehr selten, leuchtet in Regenbogenfarben",
            heart = "#e0b3ff",
            rescue_text = "Die seltene Regenbogen-Lolli-Fee schenkt dir ein buntes Funkeln!",
        },
    },

    -- --- 5) Ranks (3rd field = colour -> creates a badge item) ---
    ranks = {
        { 0,  "Naschmaus" },
        { 5,  "Bonbon-Sammler" },
        { 10, "Zucker-Forscher", "#ff7fbf" },
        { 25, "Naschmeister",    "#f1c40f" },
        { 50, "Naschwerk-Held",  "#e74c3c" },
    },

    -- --- 6) Logbook item ---
    logbook = { title = "Naschwerk-Logbuch", item_color = "#ff8fc8" },

    -- --- 7) Plain texts for curriculum codes (for /lernplan & boards) ---
    kompetenzen = {
        ["MA.1"] = "Mengen erfassen, zaehlen und vergleichen",
        ["MA.2"] = "Muster und Reihen erkennen und fortsetzen (rot-gelb-rot ...)",
        ["BG.1"] = "Farben erkennen und gestalten",
        ["D.2"]  = "Naschereien benennen und beschreiben",
    },
})

-- ============================================================
--  THEME EXTRAS  (self-contained Lua the engine cannot express)
-- ============================================================

-- ------------------------------------------------------------
--  B) EXTRA: NASCHWAGEN  (drivable candy cart)
--  A self-contained vehicle the theme adds on its own. A candy
--  cart that rolls across the valley and sprays colourful
--  sprinkles. Controls: place -> right-click to board -> W/S
--  drive, A/D steer, jump = small hop, right-click = exit. A
--  second player can ride along.
-- ------------------------------------------------------------
local CART_SPEED = 6
local SPRINKLES  = { "#e74c3c", "#f1c40f", "#3498db", "#2ecc71", "#ff8fc8", "#ffffff" }

core.register_entity(L("naschwagen"), {
    initial_properties = {
        physical = true, collide_with_objects = true,
        collisionbox = { -0.6, -0.3, -0.6, 0.6, 0.3, 0.6 },
        visual = "cube", visual_size = { x = 1.2, y = 0.6, z = 1.4 },
        textures = {
            "[fill:16x16:#ec7fb8", "[fill:16x16:#5b3a1a",
            "[fill:16x16:#f4c20d", "[fill:16x16:#f4c20d",
            "[fill:16x16:#e74c3c", "[fill:16x16:#e74c3c",
        },
    },
    _driver = nil, _passenger = nil, _spray = 0,

    on_rightclick = function(self, clicker)
        if not (clicker and clicker:is_player()) then return end
        local name = clicker:get_player_name()
        if self._driver == name then
            clicker:set_detach()
            clicker:set_eye_offset({ x = 0, y = 0, z = 0 }, { x = 0, y = 0, z = 0 })
            self._driver = nil
            core.chat_send_player(name, "Du steigst vom Naschwagen ab.")
        elseif self._passenger == name then
            clicker:set_detach()
            clicker:set_eye_offset({ x = 0, y = 0, z = 0 }, { x = 0, y = 0, z = 0 })
            self._passenger = nil
            core.chat_send_player(name, "Du steigst als Mitfahrer ab.")
        elseif not self._driver then
            clicker:set_attach(self.object, "", { x = 0, y = 4, z = 0 }, { x = 0, y = 0, z = 0 })
            self._driver = name
            core.chat_send_player(name,
                "Naschwagen los! W/S fahren, A/D lenken, Springen = kleiner Hops, " ..
                "Rechtsklick = absteigen. (Ein zweiter Spieler kann mitfahren!)")
        elseif not self._passenger then
            clicker:set_attach(self.object, "", { x = -4, y = 4, z = 0 }, { x = 0, y = 0, z = 0 })
            self._passenger = name
            core.chat_send_player(name, "Du faehrst als Mitfahrer mit! Rechtsklick = absteigen.")
        end
    end,

    on_step = function(self, dtime)
        -- gravity keeps the cart on the ground
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
        local fwd = (ctrl.up and CART_SPEED) or (ctrl.down and -CART_SPEED * 0.5) or 0
        local v   = self.object:get_velocity()
        local vy  = v and v.y or 0
        if ctrl.jump and math.abs(vy) < 0.1 then vy = 4 end   -- a small hop
        self.object:set_velocity({ x = dir.x * fwd, y = vy, z = dir.z * fwd })

        -- a trail of colourful sprinkles while moving
        if fwd ~= 0 then
            self._spray = (self._spray or 0) + dtime
            if self._spray > 0.15 then
                self._spray = 0
                local p = self.object:get_pos()
                core.add_particlespawner({
                    amount = 6, time = 0.2,
                    minpos = vector.subtract(p, 0.5), maxpos = vector.add(p, 0.5),
                    minvel = { x = -0.4, y = 0.3, z = -0.4 },
                    maxvel = { x = 0.4,  y = 1.2, z = 0.4 },
                    minexptime = 0.4, maxexptime = 0.9, minsize = 1, maxsize = 2,
                    texture = "[fill:8x8:" .. SPRINKLES[math.random(#SPRINKLES)],
                })
            end
        end
    end,
})

core.register_craftitem(L("naschwagen"), {
    description     = "Naschwagen (Fahrzeug)\nPlatzieren, dann Rechtsklick zum Aufsteigen",
    inventory_image = "[fill:16x16:#ec7fb8^[fill:12x4:2,9:#5b3a1a^[fill:4x4:3,3:#f4c20d^[fill:4x4:9,3:#e74c3c",
    on_place = function(itemstack, placer, pointed_thing)
        if pointed_thing.type ~= "node" or not (placer and placer:is_player()) then
            return itemstack
        end
        local pos = pointed_thing.above
        pos.y = pos.y + 0.5
        core.add_entity(pos, L("naschwagen"))
        if not core.is_creative_enabled(placer:get_player_name()) then
            itemstack:take_item()
        end
        return itemstack
    end,
})

-- ------------------------------------------------------------
--  C) EXTRA: REGENBOGEN-LOLLI  (a candy block that cycles colour)
--  A self-contained light show AND a gentle colour lesson: each
--  block has a node timer and, every few seconds, swaps to the
--  next colour of the rainbow (rot -> orange -> gelb -> gruen ->
--  blau -> violett -> ...). Beautiful and a soft colour/pattern
--  lesson (BG.1). Place the base "regenbogen_lolli"; the coloured
--  variants appear on their own.
-- ------------------------------------------------------------
local RAINBOW = {
    { "regenbogen_lolli",         "#e74c3c" },   -- base (in creative inventory)
    { "regenbogen_lolli_orange",  "#ff7f11" },
    { "regenbogen_lolli_gelb",    "#f1c40f" },
    { "regenbogen_lolli_gruen",   "#2ecc71" },
    { "regenbogen_lolli_blau",    "#3498db" },
    { "regenbogen_lolli_violett", "#9b59b6" },
}
local RAINBOW_TIME = 3

for i, a in ipairs(RAINBOW) do
    local suffix   = a[1]
    local colour   = a[2]
    local is_base  = (i == 1)
    local nextname = L(RAINBOW[(i % #RAINBOW) + 1][1])
    local groups   = { cracky = 3, oddly_breakable_by_hand = 2 }
    if not is_base then groups.not_in_creative_inventory = 1 end

    core.register_node(L(suffix), {
        description = is_base
            and "Regenbogen-Lolli\nLeuchtet und wechselt langsam die Farbe"
            or  "Regenbogen-Lolli (" .. colour .. ")",
        tiles = {
            "[fill:16x16:" .. colour .. "^[fill:12x12:2,2:#ffffff^[fill:8x8:4,4:" .. colour ..
            "^[fill:4x4:6,6:#ffffff",
        },
        light_source      = 11,
        paramtype         = "light",
        groups            = groups,
        drop              = L("regenbogen_lolli"),
        is_ground_content = false,
        after_place_node  = function(pos)
            core.get_node_timer(pos):start(RAINBOW_TIME)
        end,
        on_timer = function(pos)
            local p2 = core.get_node(pos).param2
            core.swap_node(pos, { name = nextname, param2 = p2 })
            core.get_node_timer(pos):start(RAINBOW_TIME)
            return false
        end,
    })
end

-- ------------------------------------------------------------
--  D) EXTRA: STARTER KIT  (handed out once on first join)
--  Makes the world testable right away: the logbook, the camera,
--  the candy cart, a regenbogen-lolli, a candy bowl + bonbons,
--  lolli saplings, a stack of each candy block, and one spawn egg
--  per candy creature (the engine registers the eggs when a mob
--  API is present; missing items are simply skipped).
--  Turn off via the setting "lernwelt_naschwerk_starter_kit".
-- ------------------------------------------------------------
local STARTER_BLOCKS = {
    "lebkuchen", "lebkuchen_ziegel", "zuckerguss", "schokolade", "weisse_schokolade",
    "keks", "waffel", "zuckerwatte_rosa", "zuckerwatte_blau", "lakritz", "karamell",
    "gummi_rot", "gummi_gruen", "gummi_gelb", "gummi_orange",
    "drops_rot", "drops_gelb", "drops_blau", "drops_gruen",
    "zuckerstange", "bonbon_streifen", "lolli_block", "bonbon_glas", "naschkiste",
    "regenbogen_lolli", "zaehltisch",
}
-- Spawn-egg item names match the creature ids (world_id:creature_id)
local STARTER_EGGS = {
    "schoko_fisch", "marshmallow_schwan", "keks_schildkroete", "brause_qualle",
    "zuckerwatte_schaf", "lolli_vogel", "bonbon_hase", "karamell_eichhoernchen",
    "gummibaer", "lakritz_schnecke", "zucker_maus", "regenbogen_fee",
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
    give_if_exists(inv, L("naschwagen"))
    give_if_exists(inv, L("bonbon") .. " 20")
    give_if_exists(inv, L("naschschale") .. " 2")
    give_if_exists(inv, L("lolli_setzling") .. " 5")
    for _, suffix in ipairs(STARTER_BLOCKS) do
        give_if_exists(inv, L(suffix) .. " 10")
    end
    for _, cid in ipairs(STARTER_EGGS) do
        give_if_exists(inv, L(cid))
    end
    core.chat_send_player(player:get_player_name(),
        "Naschwerk-Tal: Startausruestung erhalten - Naschwerk-Logbuch, Kamera, Naschwagen, " ..
        "Bonbons + Naschschale, Lolli-Setzlinge, Naschtisch, alle Suessigkeits-Bloecke und " ..
        "Spawn-Eier. Tipp: '/naschwerk_lebkuchenhaus' baut dir ein ganzes Lebkuchenhaus. " ..
        "Viel Spass im Naschwerk-Tal!")
end

core.register_on_joinplayer(function(player)
    if not core.settings:get_bool("lernwelt_naschwerk_starter_kit", true) then return end
    local meta = player:get_meta()
    if meta:get_int("lernwelt_naschwerk:starter_given") == 1 then return end
    meta:set_int("lernwelt_naschwerk:starter_given", 1)
    -- slight delay so the inventory exists and the message is seen
    core.after(1.5, function()
        if player and player:is_player() then give_starter_kit(player) end
    end)
end)

-- ------------------------------------------------------------
--  E) EXTRA: ZAEHL-NASCHTISCH  (an interactive counting game)
--  The theme's MA.1 heart: right-click the table -> a window
--  shows a random number (1-9) of bonbons. Click the matching
--  number button. Right = reward + a personal "counted right"
--  counter with small milestones, and a fresh round. Wrong = a
--  gentle "count again" hint. Pure early-maths fun.
-- ------------------------------------------------------------
local COUNT_FORM   = "lernwelt_naschwerk:zaehlen"
local count_target = {}   -- player name -> current target number
local COUNT_COLORS = { "#e74c3c", "#f1c40f", "#3498db", "#2ecc71", "#ff8fc8", "#9b59b6" }
local COUNT_MILESTONES = {
    [5]  = "Zaehl-Anfaenger",
    [15] = "Zaehl-Profi",
    [30] = "Zaehl-Meister",
}

local function show_count_game(player)
    local name   = player:get_player_name()
    local target = math.random(1, 9)
    local colour = COUNT_COLORS[math.random(#COUNT_COLORS)]
    count_target[name] = target

    local f = {
        "formspec_version[4]", "size[10.5,7]",
        "box[0,0;10.5,1;#ec7fb8]",
        "label[0.4,0.5;Zaehl-Naschtisch: Wie viele Bonbons siehst du?]",
    }
    -- draw the bonbons in a tidy 5-per-row grid
    for i = 1, target do
        local cx = (i - 1) % 5
        local cy = math.floor((i - 1) / 5)
        local x  = 1.0 + cx * 1.7
        local y  = 1.6 + cy * 1.5
        f[#f + 1] = ("box[%f,%f;1.1,1.1;%s]"):format(x, y, colour)
        f[#f + 1] = ("box[%f,%f;0.35,0.3;#ffffff]"):format(x + 0.2, y + 0.2)
    end
    -- number buttons 1..9
    for n = 1, 9 do
        local x = 0.5 + (n - 1) * 1.05
        f[#f + 1] = ("button[%f,5.7;0.95,0.9;cnt_%d;%d]"):format(x, n, n)
    end
    core.show_formspec(name, COUNT_FORM, table.concat(f))
end

core.register_node(L("zaehltisch"), {
    description = "Zaehl-Naschtisch\nRechtsklick = Bonbons zaehlen (Zaehl-Spiel)",
    tiles = {
        "[fill:16x16:#d9a566^[fill:12x12:2,2:#fff2f8^[fill:3x3:3,3:#e74c3c" ..
        "^[fill:3x3:10,3:#f1c40f^[fill:3x3:3,10:#3498db^[fill:3x3:10,10:#2ecc71",
        "[fill:16x16:#b06a32",
        "[fill:16x16:#c87f1e^[fill:16x3:0,6:#e8a13a",
    },
    paramtype2        = "facedir",
    groups            = { cracky = 2, oddly_breakable_by_hand = 2 },
    is_ground_content = false,
    on_rightclick = function(pos, node, clicker)
        if clicker and clicker:is_player() then show_count_game(clicker) end
    end,
})

core.register_on_player_receive_fields(function(player, formname, fields)
    if formname ~= COUNT_FORM then return end
    local name   = player:get_player_name()
    local target = count_target[name]
    if not target then return true end
    for n = 1, 9 do
        if fields["cnt_" .. n] then
            if n == target then
                count_target[name] = nil
                core.sound_play("lernwelt_rescue", { to_player = name, gain = 1.0 })
                local meta = player:get_meta()
                local c = meta:get_int("lernwelt_naschwerk:gezaehlt") + 1
                meta:set_int("lernwelt_naschwerk:gezaehlt", c)
                core.chat_send_player(name,
                    "Richtig! Es waren " .. target .. " Bonbons. Richtig gezaehlt: " .. c)
                local title = COUNT_MILESTONES[c]
                if title then
                    core.sound_play("lernwelt_rankup", { to_player = name, gain = 1.0 })
                    core.chat_send_player(name, "Toll! Du bist jetzt: " .. title .. "!")
                end
                -- a fresh round after a short moment
                core.after(0.8, function()
                    local p = core.get_player_by_name(name)
                    if p then show_count_game(p) end
                end)
            else
                core.chat_send_player(name,
                    "Fast! Zaehle nochmal genau - zeige mit dem Finger auf jedes Bonbon.")
            end
            return true
        end
    end
    return true
end)

-- ------------------------------------------------------------
--  F) EXTRA: NASCHTIERE FUETTERN  (candy bowl + caring counter)
--  Caring for candy creatures: hold a "Bonbon" and right-click a
--  "Naschschale" to feed. Each feed adds to a personal counter
--  with small milestones. Fits the theme's motto: "Teilen".
-- ------------------------------------------------------------
core.register_craftitem(L("bonbon"), {
    description     = "Bonbon (Naschtier-Futter)\nBonbon in die Hand nehmen und eine " ..
                      "Naschschale mit Rechtsklick fuettern",
    inventory_image = "[fill:16x16:#f5b7d0^[fill:9x5:3,6:#e74c3c^[fill:4x4:11,6:#f1c40f" ..
                      "^[fill:3x3:5,5:#ffffff",
    groups          = { food = 1 },
})

local FEED_MILESTONES = {
    [5]  = "Naschtier-Freund",
    [15] = "Naschtier-Pfleger",
    [30] = "Naschtier-Kuemmerer",
}

core.register_node(L("naschschale"), {
    description = "Naschschale\nBonbon in die Hand nehmen, Rechtsklick = Naschtiere fuettern",
    tiles = {
        "[fill:16x16:#fdf2f8^[fill:12x12:2,2:#ec7fb8^[fill:4x4:4,4:#e74c3c" ..
        "^[fill:4x4:9,5:#f1c40f^[fill:4x4:5,9:#3498db",
        "[fill:16x16:#c75f98",
        "[fill:16x16:#ec7fb8^[fill:16x3:0,6:#fff0a8",
    },
    paramtype2        = "facedir",
    groups            = { cracky = 2, oddly_breakable_by_hand = 2 },
    is_ground_content = false,
    on_rightclick = function(pos, node, clicker)
        if not (clicker and clicker:is_player()) then return end
        local name    = clicker:get_player_name()
        local wielded = clicker:get_wielded_item()
        if wielded:get_name() ~= L("bonbon") then
            core.chat_send_player(name,
                "Die Naschschale braucht ein Bonbon. Nimm 'Bonbon' in die Hand und mach Rechtsklick.")
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
            texture = "[fill:8x8:" .. SPRINKLES[math.random(#SPRINKLES)],
        })
        core.sound_play("lernwelt_rescue", { to_player = name, gain = 0.6 })
        local meta = clicker:get_meta()
        local n = meta:get_int("lernwelt_naschwerk:gefuettert") + 1
        meta:set_int("lernwelt_naschwerk:gefuettert", n)
        core.chat_send_player(name, "Naschtiere gefuettert! Satte Naschtiere: " .. n)
        local title = FEED_MILESTONES[n]
        if title then
            core.sound_play("lernwelt_rankup", { to_player = name, gain = 1.0 })
            core.chat_send_player(name, "Toll! Du bist jetzt: " .. title .. "!")
        end
    end,
})

-- ------------------------------------------------------------
--  G) EXTRA: LOLLIS PFLANZEN  (plant & grow colourful candy)
--  A sapling you place; after a while it grows into a random
--  bright candy block (drops/gummy/lolli). Each grown lolli adds
--  to a personal counter. Reinforces the theme's colour focus.
-- ------------------------------------------------------------
local LOLLI_GROWN = {
    "drops_rot", "drops_gelb", "drops_blau", "drops_gruen",
    "lolli_block", "zuckerstange", "bonbon_streifen",
}
local GROW_TIME = 20

core.register_node(L("lolli_setzling"), {
    description = "Lolli-Setzling\nSetzen - waechst zu einem bunten Suessigkeits-Block",
    drawtype = "plantlike",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    floodable = false,
    tiles = { "[fill:16x16:#2ecc71^[fill:2x10:7,5:#8d6e3a^[fill:8x8:4,1:#e74c3c^[fill:4x4:6,2:#ffffff" },
    inventory_image = "[fill:16x16:#2ecc71^[fill:2x10:7,5:#8d6e3a^[fill:8x8:4,1:#e74c3c^[fill:4x4:6,2:#ffffff",
    selection_box = { type = "fixed", fixed = { -0.3, -0.5, -0.3, 0.3, 0.4, 0.3 } },
    groups = { dig_immediate = 3, oddly_breakable_by_hand = 3 },
    after_place_node = function(pos, placer)
        if placer and placer:is_player() then
            core.get_meta(pos):set_string("planter", placer:get_player_name())
        end
        core.get_node_timer(pos):start(GROW_TIME)
    end,
    on_timer = function(pos)
        local planter = core.get_meta(pos):get_string("planter")
        core.set_node(pos, { name = L(LOLLI_GROWN[math.random(#LOLLI_GROWN)]) })
        if planter ~= "" then
            local p = core.get_player_by_name(planter)
            if p then
                local meta = p:get_meta()
                local n = meta:get_int("lernwelt_naschwerk:lollis") + 1
                meta:set_int("lernwelt_naschwerk:lollis", n)
                core.sound_play("lernwelt_rescue", { to_player = planter, gain = 0.6 })
                core.chat_send_player(planter, "Ein Lolli ist gewachsen! Suessigkeits-Bloecke: " .. n)
            end
        end
        return false
    end,
})

-- ------------------------------------------------------------
--  H) CREATURE LAND SPAWNER  (a living valley)
--  The engine's built-in spawner only places water creatures, so
--  this small, backend-agnostic spawner brings the land creatures
--  to life: every so often it tries to add one non-rare land
--  creature on solid ground with air above, near a player, capped
--  so the valley never gets crowded. Turn off with the setting
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
--  I) EXTRA: BASE COMMANDS  (Lebkuchenhaus, test station)
--  Ready-made builds in front of you. All need the "server"
--  privilege (automatic in single-player).
-- ------------------------------------------------------------
local BOARDS = {
    L("tafel_schoko_fluss"),
    L("tafel_lolli_wald"),
    L("tafel_gummi_huegel"),
}

-- The signature base: a roomy LEBKUCHENHAUS (gingerbread house)
-- with gingerbread walls, a chocolate roof, candy-cane corners, the
-- three learning boards, a glowing rainbow-lolli wall, a counting
-- table, a candy bowl and a candy cart.
core.register_chatcommand("naschwerk_lebkuchenhaus", {
    description = "Baut ein ganzes Lebkuchenhaus vor dir (Halle, 3 Lern-Tafeln, " ..
                  "Regenbogen-Lolli-Wand, Zaehl-Naschtisch, Naschschale, Naschwagen)",
    privs = { server = true },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then return false, "Dieser Befehl funktioniert nur im Spiel." end
        local b    = vector.round(player:get_pos())
        local fy   = b.y - 1
        local z0   = b.z + 2
        local W    = 5                -- half-width (x: -5..5)
        local DEEP = 11               -- depth (z: 0..11)
        local floor = L("keks")
        local wall  = L("lebkuchen_ziegel")
        local roof  = L("schokolade")

        for dx = -W, W do
            for dz = 0, DEEP do
                local x, z = b.x + dx, z0 + dz
                core.set_node({ x = x, y = fy, z = z }, { name = floor })
                local edge = (dx == -W or dx == W or dz == 0 or dz == DEEP)
                for dy = 1, 4 do
                    -- a doorway on the near (z0) side
                    local door = (dz == 0 and dx == 0 and dy <= 2)
                    if edge and not door then
                        local mat = (dy == 4) and roof or wall
                        core.set_node({ x = x, y = fy + dy, z = z }, { name = mat })
                    elseif dy == 4 then
                        core.set_node({ x = x, y = fy + dy, z = z }, { name = roof })  -- ceiling
                    end
                end
            end
        end

        -- candy-cane pillars in the four corners
        for _, c in ipairs({ { -W, 0 }, { W, 0 }, { -W, DEEP }, { W, DEEP } }) do
            for dy = 1, 3 do
                core.set_node({ x = b.x + c[1], y = fy + dy, z = z0 + c[2] },
                    { name = L("zuckerstange") })
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

        -- a glowing rainbow-lolli wall on the left (start each node's colour
        -- timer, since set_node does not call after_place_node)
        for dy = 1, 3 do
            for _, zz in ipairs({ z0 + 3, z0 + 4 }) do
                local ap = { x = b.x - W + 1, y = fy + dy, z = zz }
                core.set_node(ap, { name = L("regenbogen_lolli") })
                core.get_node_timer(ap):start(RAINBOW_TIME)
            end
        end

        -- a counting table in the middle, a candy bowl + a lolli sapling on the right
        core.set_node({ x = b.x, y = fy + 1, z = z0 + 3 }, { name = L("zaehltisch") })
        core.set_node({ x = b.x + W - 1, y = fy + 1, z = z0 + 5 }, { name = L("naschschale") })
        core.set_node({ x = b.x + W - 2, y = fy + 1, z = z0 + 6 }, { name = L("lolli_setzling") })
        core.get_node_timer({ x = b.x + W - 2, y = fy + 1, z = z0 + 6 }):start(GROW_TIME)
        core.set_node({ x = b.x + W - 1, y = fy + 1, z = z0 + 7 }, { name = L("bonbon_glas") })

        -- a candy cart ready to board, near the entrance
        core.add_entity({ x = b.x, y = fy + 1.5, z = z0 + 1 }, L("naschwagen"))

        return true, "Lebkuchenhaus gebaut! Drinnen leuchtet links eine Regenbogen-Lolli-Wand, in " ..
                     "der Mitte steht der Zaehl-Naschtisch, rechts warten Naschschale und Lolli. " ..
                     "Vorne steht ein Naschwagen, hinten die drei Lern-Tafeln."
    end,
})

-- A small test station: a candy floor, the three boards, a candy
-- cart, a counting table, a rainbow-lolli and a lolli sapling.
core.register_chatcommand("naschwerk_teststation", {
    description = "Baut eine kleine Test-Station vor dir (Boden, 3 Lern-Tafeln, " ..
                  "Naschwagen, Zaehl-Naschtisch, Regenbogen-Lolli)",
    privs = { server = true },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then return false, "Dieser Befehl funktioniert nur im Spiel." end
        local base    = vector.round(player:get_pos())
        local floor_y = base.y - 1
        local floor   = L("waffel")

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

        -- a counting table, a glowing rainbow-lolli and a lolli sapling
        core.set_node({ x = base.x, y = floor_y + 1, z = base.z + 4 }, { name = L("zaehltisch") })
        core.set_node({ x = base.x - 2, y = floor_y + 1, z = base.z + 2 }, { name = L("regenbogen_lolli") })
        core.get_node_timer({ x = base.x - 2, y = floor_y + 1, z = base.z + 2 }):start(RAINBOW_TIME)
        core.set_node({ x = base.x + 2, y = floor_y + 1, z = base.z + 2 },
            { name = L("lolli_setzling") })
        core.get_node_timer({ x = base.x + 2, y = floor_y + 1, z = base.z + 2 }):start(GROW_TIME)

        -- a candy cart ready to board
        core.add_entity({ x = base.x, y = floor_y + 1.5, z = base.z + 3 }, L("naschwagen"))

        return true, "Test-Station gebaut! Drei Lern-Tafeln, ein Zaehl-Naschtisch, ein " ..
                     "leuchtender Regenbogen-Lolli, ein Lolli-Setzling und ein Naschwagen " ..
                     "stehen vor dir (Richtung +Z)."
    end,
})

-- ------------------------------------------------------------
--  J) EXTRA: AMBIENT-SOUND  (bubbling chocolate / soft jingle)
--  Plays a gentle candy sound to each player now and then. The
--  .ogg files are optional (missing = silent, only a warning).
-- ------------------------------------------------------------
local amb_timer, amb_next = 0, 45
core.register_globalstep(function(dtime)
    amb_timer = amb_timer + dtime
    if amb_timer < amb_next then return end
    amb_timer = 0
    amb_next = 35 + math.random(0, 40)
    for _, player in ipairs(core.get_connected_players()) do
        local snd = (math.random() < 0.5) and "_blubber" or "_ambient"
        core.sound_play(WORLD_ID .. snd, { to_player = player:get_player_name(), gain = 0.4 })
    end
end)

-- ------------------------------------------------------------
--  K) EXTRA: BUCHSTABEN-BLOECKE  (A-Z, zum Woerterlegen)
--  A tiny 5x7 pixel font rendered into each block's texture with
--  layered "[fill" - no image files. Nice for "Deutsch / benennen":
--  lay out candy names and simple words from letter blocks.
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
    local t = { "[fill:16x16:#fff2f8" }
    for r = 1, #rows do
        local row = rows[r]
        for c = 1, #row do
            if row:sub(c, c) == "#" then
                t[#t + 1] = ("^[fill:2x2:%d,%d:#e74c3c"):format(3 + (c - 1) * 2, 1 + (r - 1) * 2)
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

core.log("action", "[lernwelt_naschwerk] Theme 'Naschwerk-Tal' registered (on lernwelt engine).")
