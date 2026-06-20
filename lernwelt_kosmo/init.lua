-- ============================================================
--  THEME:  KOSMO-STATION  (space station explorers)
--  A brand-free outer-space learning world built ON TOP of the
--  reusable "lernwelt" engine. Almost everything below is one
--  declarative register_world{...} call - blocks, learning
--  zones, rescuable space friends, logbook, ranks and badges all
--  come from the engine.
--
--  Things the engine cannot express live as small pieces of
--  custom code after register_world:
--    B) the drivable "Raumgleiter" (space glider vehicle)
--    C) MOON GRAVITY: jump/physics blocks (low gravity, a
--       trampoline jump-pad, a weightless field and a reset
--       block) - the theme's special feature
--    D) a starter kit handed out on first join (for quick testing)
--    E) a gentle ground spawner so space friends appear near you
--    ... plus space-junk cleanup, star planting, test-station
--        commands, ambient sound and letter blocks A-Z.
--
--  The mod name equals the world id ("lernwelt_kosmo"), so all
--  nodes/items live in the "lernwelt_kosmo:" namespace.
--
--  Content is authored in German (ASCII: ae/oe/ue), like the
--  other example themes. The engine's own UI is translated
--  separately via lernwelt/locale/*.tr.
-- ============================================================

local WORLD_ID = "lernwelt_kosmo"

-- ------------------------------------------------------------
--  A) THE WHOLE LEARNING WORLD AS ONE DECLARATIVE TABLE
-- ------------------------------------------------------------
lernwelt.register_world({

    -- internal prefix; kept identical to the mod name so all
    -- nodes/items live in the "lernwelt_kosmo:" namespace
    id    = WORLD_ID,
    title = "Kosmo-Station",

    -- --- 1) Peaceful, child-friendly world ---
    config = {
        damage      = false,    -- no damage / no dying
        creative    = true,     -- unlimited blocks
        peaceful    = true,     -- no monsters
        freeze_time = "night",  -- a starry space sky (the station glows)
        no_weather  = true,
    },

    -- --- 2) Colourful planet blocks + station parts (no PNG) ---
    blocks = {
        -- Bunte Planeten (glowing, for counting & colour tasks)
        { suffix = "planet_rot",    name = "Roter Planet (Mars)",     color = "#e74c3c", glow = 5 },
        { suffix = "planet_blau",   name = "Blauer Planet",           color = "#3498db", glow = 5 },
        { suffix = "planet_gelb",   name = "Gelbe Sonne",             color = "#f1c40f", glow = 8 },
        { suffix = "planet_gruen",  name = "Gruener Planet",          color = "#2ecc71", glow = 5 },
        { suffix = "planet_lila",   name = "Lila Planet",             color = "#9b59b6", glow = 5 },
        { suffix = "planet_orange", name = "Orange Planet (Jupiter)", color = "#e67e22", glow = 5 },

        -- Station shell + window glass
        { suffix = "stationswand", name = "Stations-Wand",
          texture = "[fill:16x16:#95a5a6^[fill:16x1:0,1:#7f8c8d^[fill:16x1:0,14:#7f8c8d" ..
                    "^[fill:1x16:1,0:#7f8c8d^[fill:1x16:14,0:#7f8c8d^[fill:2x2:7,7:#bdc3c7" },
        { suffix = "bullaugen_glas", name = "Bullaugen-Glas", color = "#aaddff", glass = true },

        -- Patterned decoration blocks (procedural, no image files needed).
        -- "texture" is a Luanti texture-modifier string: a base "[fill"
        -- plus overlaid "^[fill:WxH:X,Y:#colour" rectangles.
        { suffix = "muster_sterne", name = "Sternenhimmel-Block",
          texture = "[fill:16x16:#1b1b3a^[fill:2x2:3,3:#ffffff^[fill:2x2:10,5:#ffffff" ..
                    "^[fill:2x2:6,11:#ffffff^[fill:1x1:13,12:#ffffff^[fill:1x1:2,9:#ffffff" ..
                    "^[fill:2x2:12,2:#fff2a8" },
        { suffix = "muster_streifen", name = "Streifen-Panel",
          texture = "[fill:16x16:#3498db^[fill:3x16:3,0:#ffffff^[fill:3x16:10,0:#ffffff" },
        { suffix = "muster_punkte", name = "Punkte-Panel",
          texture = "[fill:16x16:#9b59b6^[fill:3x3:2,2:#ffffff^[fill:3x3:11,2:#ffffff" ..
                    "^[fill:3x3:2,11:#ffffff^[fill:3x3:11,11:#ffffff^[fill:3x3:6,6:#ffffff" },
        { suffix = "muster_schach", name = "Schachbrett-Panel",
          texture = "[fill:16x16:#f1c40f^[fill:8x8:0,0:#34495e^[fill:8x8:8,8:#34495e" },
        { suffix = "muster_rahmen", name = "Rahmen-Panel",
          texture = "[fill:16x16:#16a085^[fill:12x12:2,2:#1abc9c" },
        { suffix = "raketenrumpf", name = "Raketen-Rumpf",
          texture = "[fill:16x16:#ecf0f1^[fill:16x3:0,0:#e74c3c^[fill:4x4:6,7:#5dade2" ..
                    "^[fill:16x2:0,13:#bdc3c7" },
        { suffix = "steuerpult", name = "Steuerpult",
          texture = "[fill:16x16:#2c3e50^[fill:3x3:2,2:#e74c3c^[fill:3x3:7,2:#2ecc71" ..
                    "^[fill:3x3:12,2:#f1c40f^[fill:12x4:2,9:#34495e^[fill:2x2:3,10:#aaddff" ..
                    "^[fill:2x2:7,10:#aaddff^[fill:2x2:11,10:#aaddff" },
        { suffix = "solarpanel", name = "Solarpanel",
          texture = "[fill:16x16:#1f3a93^[fill:16x1:0,5:#0b1e5b^[fill:16x1:0,10:#0b1e5b" ..
                    "^[fill:1x16:5,0:#0b1e5b^[fill:1x16:10,0:#0b1e5b" },
        { suffix = "mondgestein", name = "Mondgestein",
          texture = "[fill:16x16:#bdc3c7^[fill:4x4:3,3:#95a5a6^[fill:3x3:10,8:#95a5a6" ..
                    "^[fill:2x2:6,11:#7f8c8d" },
        { suffix = "asteroid", name = "Asteroid",
          texture = "[fill:16x16:#7f8c8d^[fill:5x5:2,2:#566573^[fill:4x4:9,9:#566573" ..
                    "^[fill:3x3:10,2:#95a5a6" },
        { suffix = "sternenstaub", name = "Sternenstaub-Block", glow = 9,
          texture = "[fill:16x16:#2c3e50^[fill:2x2:3,3:#fff2a8^[fill:1x1:8,2:#ffffff" ..
                    "^[fill:2x2:11,6:#fff2a8^[fill:1x1:5,9:#ffffff^[fill:2x2:9,11:#fff2a8" ..
                    "^[fill:1x1:13,12:#ffffff^[fill:1x1:2,12:#fff2a8" },
        { suffix = "planet_ring", name = "Ringplanet (Saturn)", glow = 5,
          texture = "[fill:16x16:#e0b35a^[fill:16x2:0,6:#7e5109^[fill:16x1:0,9:#9c7320" },

        -- Per-face block: a real supply crate (lid on top, metal sides).
        { suffix = "vorratskiste", name = "Vorratskiste",
          top    = "[fill:16x16:#7f8c8d^[fill:16x2:0,0:#f1c40f^[fill:16x2:0,14:#f1c40f^[fill:4x4:6,6:#2c3e50",
          side   = "[fill:16x16:#7f8c8d^[fill:16x3:0,6:#f1c40f^[fill:4x5:6,6:#2c3e50",
          bottom = "[fill:16x16:#566573" },

        -- --- MOON-GRAVITY / PHYSICS BLOCKS (see section C) ---
        -- Stand on them to change how you move. Registered here so
        -- they appear in the creative menu and the starter kit; the
        -- effect is applied by the globalstep in section C.
        { suffix = "mond_boden", name = "Mond-Boden (leichte Schwerkraft)", glow = 2,
          texture = "[fill:16x16:#cfd8dc^[fill:3x3:3,3:#90a4ae^[fill:2x2:10,7:#90a4ae" ..
                    "^[fill:2x2:6,11:#90a4ae^[fill:1x1:13,2:#7e57c2" },
        { suffix = "sprung_pad", name = "Sprung-Pad (Trampolin)", glow = 3,
          texture = "[fill:16x16:#2c3e50^[fill:12x12:2,2:#27ae60^[fill:12x2:2,4:#2ecc71" ..
                    "^[fill:12x2:2,10:#2ecc71^[fill:2x2:7,7:#ffffff" },
        { suffix = "schwerelos_feld", name = "Schwerelos-Feld", glow = 4,
          texture = "[fill:16x16:#7b4fae^[fill:3x3:2,2:#b39ddb^[fill:3x3:11,11:#b39ddb" ..
                    "^[fill:2x2:7,6:#d1c4e9" },
        { suffix = "schwerkraft_normal", name = "Schwerkraft-Normal",
          texture = "[fill:16x16:#34495e^[fill:10x10:3,3:#566573^[fill:2x6:6,5:#ecf0f1" ..
                    "^[fill:4x2:8,5:#ecf0f1^[fill:2x2:8,9:#ecf0f1" },

        -- Eigenes gemaltes Bild als Block? Lege eine PNG (16x16 oder 32x32)
        -- "lernwelt_kosmo_meinbild.png" in den textures/-Ordner und entferne
        -- die zwei Minuszeichen vor der naechsten Zeile:
        -- { suffix = "meinbild", name = "Mein Bild", texture = "lernwelt_kosmo_meinbild.png" },
    },

    -- --- 3) Learning zones (each gets a placeable learning board) ---
    -- Zone titles double as the "habitat" shown in the logbook.
    zones = {
        {
            id = "planeten", title = "Bunte Planeten", color = "#3498db",
            activity = "Planeten nach Farben sortieren, Planeten zaehlen " ..
                       "und benennen, eine Farb-Reihe legen.",
            lehrplan = { "MA.1", "NMG.2", "D.2" },
            tasks = {
                { type = "quiz", question = "Welche Farbe hat der Planet Mars?",
                  options = { "Rot", "Blau", "Gruen" }, answer = 1,
                  done = "Richtig! Der Mars ist der rote Planet." },
                { type = "quiz", question = "Wie viele Planeten siehst du?  *  *  *",
                  options = { "3", "2", "5" }, answer = 1,
                  done = "Richtig! Das sind drei Planeten." },
                { type = "rescue", creature = "alien_gruen", count = 2,
                  done = "Stark! Zwei gruene Aliens zur Station gebracht." },
                { type = "pattern",
                  sequence = { "#3498db", "#f1c40f", "#e74c3c" },
                  palette  = { { "#3498db", "Blau" }, { "#f1c40f", "Gelb" }, { "#e74c3c", "Rot" } },
                  done = "Super! Planeten-Reihe blau-gelb-rot gelegt." },
            },
        },
        {
            id = "asteroidenguertel", title = "Asteroidenguertel", color = "#7f8c8d",
            activity = "Grosse und kleine Asteroiden vergleichen, " ..
                       "zaehlen und Groessen ordnen.",
            lehrplan = { "MA.1", "MA.2", "NMG.2" },
            tasks = {
                { type = "quiz", question = "Was ist groesser?",
                  options = { "Planet", "Asteroid" }, answer = 1,
                  done = "Genau! Ein Planet ist viel groesser als ein Asteroid." },
                { type = "quiz", question = "Wie viele Asteroiden?  o o o o",
                  options = { "4", "3", "6" }, answer = 1,
                  done = "Richtig! Das sind vier Asteroiden." },
                { type = "rescue", creature = "asteroidenkrabbe", count = 2,
                  done = "Klasse! Zwei Asteroiden-Krabben gerettet." },
            },
        },
        {
            id = "sternennebel", title = "Sternennebel-Hoehle", color = "#2c2c54",
            activity = "Im dunklen Nebel leuchtende Sterne suchen, " ..
                       "hell und dunkel unterscheiden, ruhig erkunden.",
            lehrplan = { "NMG.3", "NMG.2" },
            tasks = {
                { type = "quiz", question = "Was leuchtet im dunklen Nebel?",
                  options = { "Sternen-Wesen", "Asteroid", "Roboter" }, answer = 1,
                  done = "Richtig! Das Sternen-Wesen leuchtet hell." },
                { type = "quiz", question = "Welche Farbe hat unsere Sonne?",
                  options = { "Gelb", "Blau", "Lila" }, answer = 1,
                  done = "Richtig! Die Sonne leuchtet gelb." },
                { type = "rescue", creature = "sternenwesen", count = 1,
                  done = "Toll! Ein Sternen-Wesen zum Leuchten gebracht." },
            },
        },
        {
            id = "mondbasis", title = "Mond-Basis", color = "#d7dbdd",
            activity = "Mond-Schwerkraft erleben (hoch springen!) und die " ..
                       "Missionsreihenfolge fuer den Raketenstart planen.",
            lehrplan = { "BS.2", "MI.1", "MA.1" },
            tasks = {
                { type = "quiz", question = "Wie ist die Schwerkraft auf dem Mond?",
                  options = { "Schwaecher", "Staerker" }, answer = 1,
                  done = "Richtig! Auf dem Mond springst du viel hoeher." },
                { type = "pattern",
                  sequence = { "#e74c3c", "#f1c40f", "#2ecc71" },
                  palette  = { { "#e74c3c", "1 Tanken" }, { "#f1c40f", "2 Countdown" }, { "#2ecc71", "3 Start" } },
                  done = "Super! Start-Reihenfolge geplant: Tanken, Countdown, Start!" },
                { type = "rescue", creature = "mondhase", count = 2,
                  done = "Klasse! Zwei Mond-Hasen gerettet." },
            },
        },
    },

    -- --- 4) Rescuable space friends (peaceful; right-click = rescue) ---
    creatures = {
        {
            id = "alien_gruen", name = "Gruener Alien", zone = "planeten",
            color = "#2ecc71", size = 0.6, speed = 0.8, glow = 3,
            food = "Sternenbeeren", power = "Winkt mit drei Armen",
            heart = "#82e0aa",
            rescue_text = "Gerettet! Der gruene Alien winkt froehlich zur Station.",
        },
        {
            id = "marsmaennchen", name = "Marsmaennchen", zone = "planeten",
            color = "#e74c3c", size = 0.5, speed = 0.9, family = 1,
            food = "Roter Staub", power = "Huepft ueberraschend hoch",
            heart = "#f5b7b1",
            rescue_text = "Gerettet! Das Marsmaennchen huepft gluecklich davon.",
        },
        {
            id = "weltraumkatze", name = "Weltraum-Katze", zone = "planeten",
            color = "#e67e22", size = 0.6, speed = 1.2, family = 2,
            food = "Mond-Milch", power = "Schwebt und schnurrt",
            heart = "#f8c471",
            rescue_text = "Gerettet! Die Weltraum-Katze schwebt schnurrend davon.",
        },
        {
            id = "plasma_vogel", name = "Plasma-Vogel", zone = "planeten",
            color = "#e84393", size = 0.5, speed = 1.6, glow = 7,
            food = "Lichtfunken", power = "Leuchtet in allen Farben",
            heart = "#fd79a8",
            rescue_text = "Gerettet! Der Plasma-Vogel zischt leuchtend davon.",
        },
        {
            id = "ufo", name = "Mini-UFO", zone = "planeten",
            color = "#5dade2", size = 0.7, speed = 1.8, glow = 6,
            food = "Strom", power = "Fliegt im Zickzack",
            heart = "#aed6f1",
            rescue_text = "Gerettet! Das Mini-UFO flitzt im Zickzack davon. Wuuusch!",
        },
        {
            id = "asteroidenkrabbe", name = "Asteroiden-Krabbe", zone = "asteroidenguertel",
            color = "#7f8c8d", size = 0.5, speed = 0.5,
            food = "Gestein", power = "Klammert sich an Felsen",
            heart = "#d6dbdf",
            rescue_text = "Gerettet! Die Asteroiden-Krabbe krabbelt zur Station.",
        },
        {
            id = "satellit", name = "Satellit Robi", zone = "asteroidenguertel",
            color = "#aaddff", size = 0.8, speed = 0.6, glow = 4,
            food = "Sonnenlicht", power = "Funkt nach Hause",
            heart = "#d6eaf8",
            rescue_text = "Gerettet! Satellit Robi funkt ein froehliches Piep-Piep.",
        },
        {
            id = "roboter", name = "Mini-Roboter", zone = "mondbasis",
            color = "#95a5a6", size = 0.6, speed = 0.7,
            food = "Batterien", power = "Piept und rechnet",
            heart = "#d7dbdd",
            rescue_text = "Gerettet! Der Mini-Roboter rollt piepend zur Station.",
        },
        {
            id = "astronaut", name = "Verirrter Astronaut", zone = "mondbasis",
            color = "#ecf0f1", size = 0.8, speed = 0.6,
            food = "Tubennahrung", power = "Schwebt im Raumanzug",
            heart = "#fdfefe",
            rescue_text = "Gerettet! Der Astronaut schwebt erleichtert zur Station.",
        },
        {
            id = "mondhase", name = "Mond-Hase", zone = "mondbasis",
            color = "#d7dbdd", size = 0.5, speed = 1.0, family = 2,
            food = "Mond-Gras", power = "Springt riesig weit",
            heart = "#eaeded",
            rescue_text = "Gerettet! Der Mond-Hase springt in grossen Saetzen davon.",
        },
        {
            id = "weltraumqualle", name = "Weltraum-Qualle", zone = "sternennebel",
            color = "#1abc9c", size = 0.7, speed = 0.4, glow = 8,
            food = "Plasma", power = "Schwebt und leuchtet",
            heart = "#a3e4d7",
            rescue_text = "Gerettet! Die Weltraum-Qualle schwebt sanft ins Licht.",
        },
        {
            id = "sternenwesen", name = "Sternen-Wesen", zone = "sternennebel",
            color = "#f1c40f", size = 0.6, speed = 0.7, glow = 14,
            food = "Sternenstaub", power = "Strahlt ganz hell",
            heart = "#fdebd0",
            rescue_text = "Gerettet! Das Sternen-Wesen strahlt dir dankbar nach.",
        },
        {
            id = "nebel_schweber", name = "Nebel-Schweber", zone = "sternennebel",
            color = "#9b59b6", size = 0.6, speed = 0.9, glow = 6,
            food = "Nebel", power = "Wird fast unsichtbar",
            heart = "#d2b4de",
            rescue_text = "Gerettet! Der Nebel-Schweber verschwimmt und schwebt davon.",
        },
        {
            -- legendary, rare: never auto-spawns (egg/manual only)
            id = "goldkomet", name = "Goldener Komet", zone = "sternennebel",
            color = "#f1c40f", size = 1.2, speed = 2.0, glow = 10, rare = true,
            food = "Sonnenfeuer", power = "Sehr selten und magisch",
            heart = "#fff2a8",
            rescue_text = "Der legendaere Goldene Komet schenkt dir ein Funkeln!",
        },
    },

    -- --- 5) Ranks (3rd field = colour -> creates a badge item) ---
    ranks = {
        { 0,  "Anwaerter" },
        { 5,  "Kadett" },
        { 10, "Pilot",            "#3498db" },
        { 25, "Commander",        "#27ae60" },
        { 50, "Sternen-Kapitaen", "#f1c40f" },
    },

    -- --- 6) Logbook item ---
    logbook = { title = "Stern-Logbuch", item_color = "#f1c40f" },

    -- --- 7) Plain texts for curriculum codes (for /lernplan & boards) ---
    kompetenzen = {
        ["MA.1"]  = "Mengen erfassen und zaehlen (Planeten zaehlen)",
        ["MA.2"]  = "Muster, Reihen und Groessen ordnen",
        ["MI.1"]  = "Einfache Ablaeufe planen (Missionsreihenfolge)",
        ["NMG.2"] = "Himmelskoerper kennenlernen (Sonne, Mond, Planeten)",
        ["NMG.3"] = "Hell und dunkel erleben, sich orientieren",
        ["BS.2"]  = "Sich geschickt bewegen und springen (Mond-Schwerkraft)",
        ["D.2"]   = "Dinge benennen und beschreiben",
    },
})

-- ------------------------------------------------------------
--  B) EXTRA: RAUMGLEITER  (drivable space glider)
--  Not part of the engine - a self-contained vehicle the theme
--  adds on its own. Lives in the same "lernwelt_kosmo:" namespace.
--  Controls: place -> right-click to board -> W/S drive, A/D
--  steer, jump = up, sneak = down, right-click = exit. A second
--  player can ride along.
-- ------------------------------------------------------------
local GLIDER_SPEED = 6

core.register_entity(WORLD_ID .. ":raumgleiter", {
    initial_properties = {
        physical = true, collide_with_objects = true,
        collisionbox = { -0.6, -0.4, -0.6, 0.6, 0.4, 0.6 },
        visual = "cube", visual_size = { x = 1.1, y = 0.9, z = 1.5 },
        textures = {
            "[fill:16x16:#bdc3c7", "[fill:16x16:#7f8c8d",
            "[fill:16x16:#bdc3c7", "[fill:16x16:#e74c3c",
            "[fill:16x16:#5dade2", "[fill:16x16:#bdc3c7",
        },
    },
    _driver = nil, _passenger = nil, _motor = nil, _exhaust = 0,

    on_rightclick = function(self, clicker)
        if not (clicker and clicker:is_player()) then return end
        local name = clicker:get_player_name()
        if self._driver == name then
            clicker:set_detach()
            clicker:set_eye_offset({ x = 0, y = 0, z = 0 }, { x = 0, y = 0, z = 0 })
            self._driver = nil
            self.object:set_properties({ glow = 0 })
            if self._motor then core.sound_stop(self._motor); self._motor = nil end
            core.chat_send_player(name, "Du steigst aus dem Raumgleiter aus.")
        elseif self._passenger == name then
            clicker:set_detach()
            clicker:set_eye_offset({ x = 0, y = 0, z = 0 }, { x = 0, y = 0, z = 0 })
            self._passenger = nil
            core.chat_send_player(name, "Du steigst als Mitflieger aus.")
        elseif not self._driver then
            clicker:set_attach(self.object, "", { x = 0, y = 4, z = 0 }, { x = 0, y = 0, z = 0 })
            self._driver = name
            self.object:set_properties({ glow = 9 })   -- Triebwerk leuchtet
            self._motor = core.sound_play(WORLD_ID .. "_triebwerk",
                { object = self.object, loop = true, gain = 0.5 })
            core.chat_send_player(name,
                "Raumgleiter gestartet! W/S fliegen, A/D lenken, Springen = hoch, " ..
                "Schleichen = runter, Rechtsklick = aussteigen. " ..
                "(Ein zweiter Spieler kann mitfliegen!)")
        elseif not self._passenger then
            clicker:set_attach(self.object, "", { x = -4, y = 4, z = 0 }, { x = 0, y = 0, z = 0 })
            self._passenger = name
            core.chat_send_player(name, "Du fliegst als Mitflieger mit! Rechtsklick = aussteigen.")
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
        local fwd = (ctrl.up and GLIDER_SPEED) or (ctrl.down and -GLIDER_SPEED * 0.5) or 0
        local vy  = (ctrl.jump and GLIDER_SPEED * 0.6) or (ctrl.sneak and -GLIDER_SPEED * 0.6) or 0
        self.object:set_velocity({ x = dir.x * fwd, y = vy, z = dir.z * fwd })

        -- exhaust flame trail while moving
        if fwd ~= 0 or vy ~= 0 then
            self._exhaust = (self._exhaust or 0) + dtime
            if self._exhaust > 0.2 then
                self._exhaust = 0
                local p = self.object:get_pos()
                core.add_particlespawner({
                    amount = 6, time = 0.2,
                    minpos = vector.subtract(p, 0.4), maxpos = vector.add(p, 0.4),
                    minvel = { x = -0.3, y = -0.2, z = -0.3 },
                    maxvel = { x = 0.3,  y = 0.3, z = 0.3 },
                    minexptime = 0.4, maxexptime = 0.9, minsize = 1, maxsize = 3,
                    texture = "[fill:8x8:#f39c12",
                })
            end
        end
    end,
})

core.register_craftitem(WORLD_ID .. ":raumgleiter", {
    description = "Raumgleiter (Fahrzeug)\nPlatzieren, dann Rechtsklick zum Einsteigen",
    inventory_image = "[fill:16x16:#bdc3c7^[fill:8x8:4,4:#5dade2^[fill:16x3:0,0:#e74c3c",
    on_place = function(itemstack, placer, pointed_thing)
        if pointed_thing.type ~= "node" or not (placer and placer:is_player()) then
            return itemstack
        end
        local pos = pointed_thing.above
        pos.y = pos.y + 0.5
        core.add_entity(pos, WORLD_ID .. ":raumgleiter")
        if not core.is_creative_enabled(placer:get_player_name()) then
            itemstack:take_item()
        end
        return itemstack
    end,
})

-- ------------------------------------------------------------
--  C) EXTRA: MOND-SCHWERKRAFT  (jump / physics blocks)
--  The theme's special feature. Stand on a block to change how
--  you move:
--    mond_boden          -> low gravity, big floaty jumps
--    schwerelos_feld     -> almost weightless (you drift)
--    sprung_pad          -> a trampoline: bounces you up
--    schwerkraft_normal  -> back to normal gravity
--  A single globalstep reads the block under each player's feet
--  and applies the matching physics_override (only when it
--  changes, so it never spams). Fits "Bewegung / Mond-Schwerkraft"
--  and works as the in-world replacement for a trampoline mod.
-- ------------------------------------------------------------
local PHYS = {
    [WORLD_ID .. ":mond_boden"]         = { gravity = 0.18, jump = 1.35, speed = 1.0,
        msg = "Mond-Schwerkraft! Du springst federleicht und ganz hoch." },
    [WORLD_ID .. ":schwerelos_feld"]    = { gravity = 0.05, jump = 1.0,  speed = 0.9,
        msg = "Schwerelos! Du schwebst fast wie im Weltall." },
    [WORLD_ID .. ":schwerkraft_normal"] = { gravity = 1.0,  jump = 1.0,  speed = 1.0,
        msg = "Normale Schwerkraft." },
}
local BOUNCE = WORLD_ID .. ":sprung_pad"

local phys_state = {}   -- name -> nodename ("normal" when on no special block)
local bounce_cd  = {}   -- name -> remaining cooldown seconds

local function player_velocity(player)
    if player.get_velocity then return player:get_velocity() end
    return player:get_player_velocity()   -- older Luanti
end

local function player_add_velocity(player, vel)
    if player.add_velocity then
        player:add_velocity(vel)
    elseif player.add_player_velocity then
        player:add_player_velocity(vel)    -- older Luanti
    end
end

core.register_globalstep(function(dtime)
    for _, player in ipairs(core.get_connected_players()) do
        local name = player:get_player_name()
        local pos  = player:get_pos()
        local bp   = {
            x = math.floor(pos.x + 0.5),
            y = math.floor(pos.y - 0.5),   -- block directly under the feet
            z = math.floor(pos.z + 0.5),
        }
        local below = core.get_node(bp).name

        -- Trampolin: bounce upward when standing on the pad
        if below == BOUNCE then
            bounce_cd[name] = (bounce_cd[name] or 0) - dtime
            local v = player_velocity(player)
            if (bounce_cd[name] or 0) <= 0 and v.y <= 0.2 then
                player_add_velocity(player, { x = 0, y = 9, z = 0 })
                bounce_cd[name] = 0.5
                core.sound_play(WORLD_ID .. "_sprung", { to_player = name, gain = 0.5 })
            end
        end

        -- Gravity floors: apply the matching physics only on change
        local target  = PHYS[below]
        local desired = target and below or "normal"
        if phys_state[name] ~= desired then
            phys_state[name] = desired
            if target then
                player:set_physics_override({
                    gravity = target.gravity, jump = target.jump, speed = target.speed })
                core.chat_send_player(name, target.msg)
            else
                player:set_physics_override({ gravity = 1.0, jump = 1.0, speed = 1.0 })
            end
        end
    end
end)

core.register_on_leaveplayer(function(player)
    local name = player:get_player_name()
    phys_state[name] = nil
    bounce_cd[name]  = nil
end)

-- ------------------------------------------------------------
--  D) EXTRA: STARTER KIT  (handed out once on first join)
--  Makes the world testable right away: the logbook, the camera,
--  the space glider, star seeds, a stack of each planet block +
--  station glass + the gravity blocks, and one spawn egg per
--  space friend (the engine registers the eggs when a mob API is
--  present; missing items are simply skipped).
--  Turn off via the setting "lernwelt_kosmo_starter_kit".
-- ------------------------------------------------------------
local STARTER_BLOCKS = {
    "planet_rot", "planet_blau", "planet_gelb", "planet_gruen", "planet_lila",
    "bullaugen_glas", "stationswand",
    "mond_boden", "sprung_pad", "schwerelos_feld", "schwerkraft_normal",
}
-- Spawn-egg item names match the creature ids (world_id:creature_id)
local STARTER_EGGS = {
    "alien_gruen", "marsmaennchen", "weltraumkatze", "plasma_vogel", "ufo",
    "asteroidenkrabbe", "satellit", "roboter", "astronaut", "mondhase",
    "weltraumqualle", "sternenwesen", "nebel_schweber", "goldkomet",
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
    give_if_exists(inv, WORLD_ID .. ":raumgleiter")
    give_if_exists(inv, WORLD_ID .. ":stern_samen 5")
    for _, suffix in ipairs(STARTER_BLOCKS) do
        give_if_exists(inv, WORLD_ID .. ":" .. suffix .. " 10")
    end
    for _, cid in ipairs(STARTER_EGGS) do
        give_if_exists(inv, WORLD_ID .. ":" .. cid)
    end
    core.chat_send_player(player:get_player_name(),
        "Kosmo-Station: Startausruestung erhalten - Logbuch, Kamera, Raumgleiter, " ..
        "Planeten, Schwerkraft-Bloecke, Stern-Samen und Spawn-Eier sind in deinem " ..
        "Inventar. Viel Spass im All!")
end

core.register_on_joinplayer(function(player)
    if not core.settings:get_bool("lernwelt_kosmo_starter_kit", true) then return end
    local meta = player:get_meta()
    if meta:get_int("lernwelt_kosmo:starter_given") == 1 then return end
    meta:set_int("lernwelt_kosmo:starter_given", 1)
    -- slight delay so the inventory exists and the message is seen
    core.after(1.5, function()
        if player and player:is_player() then give_starter_kit(player) end
    end)
end)

-- ------------------------------------------------------------
--  E) EXTRA: GROUND SPAWNER  (a living station)
--  The engine's built-in spawner only places water animals, so
--  this small, backend-agnostic spawner brings the (land-walking)
--  space friends to life: every so often it tries to add one
--  non-rare creature on solid ground with air above, near a
--  player, capped so the station never gets crowded. Turn off
--  with the setting "lernwelt_spawn_creatures".
-- ------------------------------------------------------------
local function ground_spawn_list()
    local list  = {}
    local world = lernwelt.worlds[WORLD_ID]
    for _, c in ipairs((world or {}).creatures or {}) do
        if not c.rare then list[#list + 1] = WORLD_ID .. ":" .. c.id end
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

            -- find solid ground with air above, near the player's height
            local spawn_pos
            for dy = 3, -6, -1 do
                local p     = { x = cx, y = math.floor(pp.y) + dy, z = cz }
                local here  = core.get_node(p).name
                local above = core.get_node({ x = p.x, y = p.y + 1, z = p.z }).name
                local def   = core.registered_nodes[here]
                -- walkable defaults to true in Luanti, so test "~= false"
                -- (air and liquids have walkable=false and are excluded)
                if def and def.walkable ~= false and here ~= "air"
                   and here ~= "ignore" and above == "air" then
                    spawn_pos = { x = p.x, y = p.y + 1, z = p.z }
                    break
                end
            end

            if spawn_pos then
                -- cap: at most 5 of this world's creatures nearby
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
--  F) EXTRA: WELTRAUMSCHROTT EINSAMMELN  (space-junk cleanup)
--  Junk nodes you can break to clean up the orbit. Each piece
--  adds to a personal cleanup counter with small milestones.
--  Place test junk with "/kosmo_schrott" (priv: server) or via
--  the test station. Fits the motto: "Bewahren".
-- ------------------------------------------------------------
local JUNK = {
    { suffix = "schrott_metall", name = "Metall-Schrott (Weltraummuell)", color = "#95a5a6" },
    { suffix = "schrott_panel",  name = "Altes Solarpanel (Weltraummuell)", color = "#2980b9" },
    { suffix = "schrott_tank",   name = "Leerer Tank (Weltraummuell)",   color = "#e67e22" },
}

local CLEAN_MILESTONES = {
    [5]  = "Stations-Putzer",
    [15] = "Orbit-Reiniger",
    [30] = "Weltraum-Held",
}

local function collect_junk(player)
    if not (player and player:is_player()) then return end
    local meta = player:get_meta()
    local n = meta:get_int("lernwelt_kosmo:schrott") + 1
    meta:set_int("lernwelt_kosmo:schrott", n)
    local name = player:get_player_name()
    core.sound_play("lernwelt_rescue", { to_player = name, gain = 0.8 })
    core.chat_send_player(name, "Schrott eingesammelt! Sauberer Orbit: " .. n .. " Stueck.")
    local title = CLEAN_MILESTONES[n]
    if title then
        core.sound_play("lernwelt_rankup", { to_player = name, gain = 1.0 })
        core.chat_send_player(name, "Toll! Du bist jetzt: " .. title .. "!")
    end
end

for _, t in ipairs(JUNK) do
    core.register_node(WORLD_ID .. ":" .. t.suffix, {
        description = t.name .. "\nAbbauen = Orbit saeubern",
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
            collect_junk(digger)
        end,
    })
end

core.register_chatcommand("kosmo_schrott", {
    description = "Verteilt etwas Weltraumschrott zum Aufraeumen um dich herum (zum Testen)",
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
                local bdef  = core.registered_nodes[below]
                if here == "air" and bdef and bdef.walkable ~= false
                   and below ~= "air" and below ~= "ignore" then
                    local t = JUNK[math.random(#JUNK)]
                    core.set_node(q, { name = WORLD_ID .. ":" .. t.suffix })
                    placed = placed + 1
                    break
                end
            end
        end
        if placed == 0 then
            return true, "Kein passender Platz gefunden - stell dich auf festen Boden und versuch es nochmal."
        end
        return true, placed .. " Stueck Schrott verteilt - sammle sie ein (abbauen)!"
    end,
})

-- ------------------------------------------------------------
--  G) EXTRA: STERN-SAMEN PFLANZEN  (grow your own galaxy)
--  A star seed you place; after a while it grows into a random
--  glowing planet/star block. Each grown star adds to a personal
--  "galaxy" counter. Fits the motto: "Bewahren / aufbauen".
-- ------------------------------------------------------------
local STAR_GROWN = {
    "planet_rot", "planet_blau", "planet_gelb", "planet_gruen",
    "planet_lila", "planet_orange", "sternenstaub",
}
local GROW_TIME = 20

core.register_node(WORLD_ID .. ":stern_samen", {
    description = "Stern-Samen\nSetzen - waechst zu einem Stern/Planeten",
    drawtype = "plantlike",
    paramtype = "light",
    light_source = 4,
    sunlight_propagates = true,
    walkable = false,
    floodable = false,
    tiles = { "[fill:16x16:#2c3e50^[fill:4x4:6,6:#fff2a8^[fill:2x2:2,2:#ffffff^[fill:2x2:11,11:#ffffff" },
    inventory_image = "[fill:16x16:#2c3e50^[fill:4x4:6,6:#fff2a8^[fill:2x2:2,2:#ffffff^[fill:2x2:11,11:#ffffff",
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
        core.set_node(pos, { name = WORLD_ID .. ":" .. STAR_GROWN[math.random(#STAR_GROWN)] })
        if planter ~= "" then
            local p = core.get_player_by_name(planter)
            if p then
                local meta = p:get_meta()
                local n = meta:get_int("lernwelt_kosmo:sterne") + 1
                meta:set_int("lernwelt_kosmo:sterne", n)
                core.sound_play("lernwelt_rescue", { to_player = planter, gain = 0.6 })
                core.chat_send_player(planter, "Ein Stern ist gewachsen! Deine Galaxie: " .. n)
            end
        end
        return false
    end,
})

-- ------------------------------------------------------------
--  H) EXTRA: TEST STATION  (chat command for quick setup)
--  "/kosmo_teststation" builds a small ready-made station in
--  front of you: a metal floor, the four learning boards, a
--  Raumgleiter, a moon-gravity patch with a jump pad, and some
--  junk to clean up. Handy for testing or for an adult to prepare
--  the world. It overwrites the nodes where it builds, so it needs
--  the "server" privilege.
-- ------------------------------------------------------------
local STATION_BOARDS = {
    WORLD_ID .. ":tafel_planeten",
    WORLD_ID .. ":tafel_asteroidenguertel",
    WORLD_ID .. ":tafel_sternennebel",
    WORLD_ID .. ":tafel_mondbasis",
}

local function build_test_station(player)
    local base    = vector.round(player:get_pos())
    local floor_y = base.y - 1
    local floor   = WORLD_ID .. ":stationswand"

    -- 7 wide (x: -3..3) x 4 deep (z: +2..+5) metal floor in front of you
    for dx = -3, 3 do
        for dz = 2, 5 do
            core.set_node({ x = base.x + dx, y = floor_y, z = base.z + dz }, { name = floor })
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

    -- a moon-gravity patch with a jump pad (try the special blocks!)
    core.set_node({ x = base.x - 1, y = floor_y, z = base.z + 4 },
        { name = WORLD_ID .. ":mond_boden" })
    core.set_node({ x = base.x, y = floor_y, z = base.z + 4 },
        { name = WORLD_ID .. ":mond_boden" })
    core.set_node({ x = base.x + 1, y = floor_y, z = base.z + 4 },
        { name = WORLD_ID .. ":sprung_pad" })

    -- a Raumgleiter ready to board
    core.add_entity({ x = base.x, y = floor_y + 1.5, z = base.z + 5 },
        WORLD_ID .. ":raumgleiter")

    -- a few junk pieces for the cleanup mini-game
    local junk  = { "schrott_metall", "schrott_panel", "schrott_tank" }
    local spots = { { -2, 2 }, { 2, 2 }, { -3, 5 }, { 3, 5 } }
    for _, s in ipairs(spots) do
        core.set_node({ x = base.x + s[1], y = floor_y + 1, z = base.z + s[2] },
            { name = WORLD_ID .. ":" .. junk[math.random(#junk)] })
    end
end

core.register_chatcommand("kosmo_teststation", {
    description = "Baut eine kleine Kosmo-Test-Station vor dir " ..
                  "(Metallboden, 4 Lern-Tafeln, Raumgleiter, Mond-Boden + Sprung-Pad)",
    privs = { server = true },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then
            return false, "Dieser Befehl funktioniert nur im Spiel."
        end
        build_test_station(player)
        return true, "Test-Station gebaut! Sie steht vor dir Richtung Norden (+Z): " ..
                     "Metallboden, vier Lern-Tafeln, ein Raumgleiter, ein Mond-Boden " ..
                     "mit Sprung-Pad und etwas Schrott zum Aufraeumen."
    end,
})

-- ------------------------------------------------------------
--  I) EXTRA: GROSSE RAUMSTATION  (chat command)
--  "/kosmo_basis" builds a bigger glass-dome station in front of
--  you: metal floor, glass shell with a doorway, the four learning
--  boards, a Raumgleiter, a moon-gravity strip with a jump pad and
--  some junk. Priv: server.
-- ------------------------------------------------------------
core.register_chatcommand("kosmo_basis", {
    description = "Baut eine groessere Raumstation vor dir (Glaskuppel, Tafeln, Raumgleiter)",
    privs = { server = true },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then return false, "Dieser Befehl funktioniert nur im Spiel." end
        local b     = vector.round(player:get_pos())
        local glass = WORLD_ID .. ":bullaugen_glas"
        local floor = WORLD_ID .. ":stationswand"
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
        local boards = { "tafel_planeten", "tafel_asteroidenguertel",
                         "tafel_sternennebel", "tafel_mondbasis" }
        local xs = { -3, -1, 1, 3 }
        for i, bd in ipairs(boards) do
            local nn = WORLD_ID .. ":" .. bd
            if core.registered_nodes[nn] then
                core.set_node({ x = b.x + xs[i], y = fy + 1, z = z0 + 1 }, { name = nn, param2 = 2 })
            end
        end
        -- a moon-gravity strip with a jump pad in the middle of the dome
        core.set_node({ x = b.x - 1, y = fy, z = z0 + R }, { name = WORLD_ID .. ":mond_boden" })
        core.set_node({ x = b.x,     y = fy, z = z0 + R }, { name = WORLD_ID .. ":sprung_pad" })
        core.set_node({ x = b.x + 1, y = fy, z = z0 + R }, { name = WORLD_ID .. ":mond_boden" })
        core.add_entity({ x = b.x, y = fy + 1.5, z = z0 + 2 * R - 1 }, WORLD_ID .. ":raumgleiter")
        for _, s in ipairs({ { -2, 2 }, { 2, 3 }, { 0, 7 }, { -1, 8 } }) do
            core.set_node({ x = b.x + s[1], y = fy + 1, z = z0 + s[2] },
                { name = WORLD_ID .. ":schrott_metall" })
        end
        return true, "Raumstation gebaut! Glaskuppel mit Tuer, Tafeln, Raumgleiter, " ..
                     "Mond-Boden mit Sprung-Pad und etwas Schrott."
    end,
})

-- ------------------------------------------------------------
--  J) EXTRA: AMBIENT-SOUND  (gentle station hum / radio beeps)
--  Plays a gentle space sound to each player now and then. The
--  .ogg files are optional (missing = silent, only a warning).
-- ------------------------------------------------------------
local amb_timer, amb_next = 0, 45
core.register_globalstep(function(dtime)
    amb_timer = amb_timer + dtime
    if amb_timer < amb_next then return end
    amb_timer = 0
    amb_next = 35 + math.random(0, 40)
    for _, player in ipairs(core.get_connected_players()) do
        local snd = (math.random() < 0.5) and "_funk" or "_ambient"
        core.sound_play(WORLD_ID .. snd, { to_player = player:get_player_name(), gain = 0.4 })
    end
end)

-- ------------------------------------------------------------
--  K) EXTRA: BUCHSTABEN-BLOECKE  (A-Z, zum Woerterlegen)
--  A tiny 5x7 pixel font rendered into each block's texture with
--  layered "[fill" - no image files. Nice for "Deutsch / benennen":
--  lay out names and simple words from letter blocks (think of them
--  as the keys of a control panel). For Umlauts use AE/OE/UE.
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
    local t = { "[fill:16x16:#2c3e50" }
    for r = 1, #rows do
        local row = rows[r]
        for c = 1, #row do
            if row:sub(c, c) == "#" then
                t[#t + 1] = ("^[fill:2x2:%d,%d:#f1c40f"):format(3 + (c - 1) * 2, 1 + (r - 1) * 2)
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

core.log("action", "[lernwelt_kosmo] Theme 'Kosmo-Station' registered (on lernwelt engine).")
