-- ============================================================
--  THEME:  GLUEHPILZ-WALD  (cosy glowing-mushroom realm)
--  A brand-free, very low-threshold "first world" built ON TOP
--  of the reusable "lernwelt" engine. Almost everything below is
--  one declarative register_world{...} call - blocks, learning
--  zones, rescuable forest animals, logbook, ranks and badges all
--  come from the engine.
--
--  Things the engine cannot express live as small pieces of
--  custom code after register_world:
--    B) the rideable "Leucht-Kaefer" (glow-beetle mount)
--    C) TAG-NACHT-PILZE: glowing mushrooms you right-click to make
--       it day, dusk or night - the theme's special feature
--       (Tag-Nacht-Wechsel ueber leuchtende Pilze)
--    D) a starter kit handed out on first join (for quick testing)
--    E) a gentle ground spawner so forest friends appear near you
--    ... plus forest-cleanup, mushroom planting, a big mushroom
--        house + test-station commands, ambient sound, drifting
--        glow spores at night and letter blocks A-Z.
--
--  The mod name equals the world id ("lernwelt_gluehpilz"), so all
--  nodes/items live in the "lernwelt_gluehpilz:" namespace.
--
--  Content is authored in German (ASCII: ae/oe/ue), like the
--  other example themes. The engine's own UI is translated
--  separately via lernwelt/locale/*.tr.
-- ============================================================

local WORLD_ID = "lernwelt_gluehpilz"

-- ------------------------------------------------------------
--  A) THE WHOLE LEARNING WORLD AS ONE DECLARATIVE TABLE
-- ------------------------------------------------------------
lernwelt.register_world({

    -- internal prefix; kept identical to the mod name so all
    -- nodes/items live in the "lernwelt_gluehpilz:" namespace
    id    = WORLD_ID,
    title = "Gluehpilz-Wald",

    -- --- 1) Peaceful, child-friendly world ---
    -- Frozen at DAY so a first world is always bright and safe. The
    -- Tag-Nacht-Pilze (section C) let children switch to night on
    -- purpose - that is the whole point of the day/night learning
    -- goal, and the glow mushrooms keep the night cosy, not scary.
    config = {
        damage      = false,   -- no damage / no dying
        creative    = true,    -- unlimited blocks
        peaceful    = true,    -- no monsters
        freeze_time = "day",   -- start bright; mushrooms change the time
        no_weather  = true,
    },

    -- --- 2) Glowing mushrooms + cosy forest blocks (no PNG) ---
    blocks = {
        -- Bunte Gluehpilze (glowing, for colour-sorting & cosy night light)
        { suffix = "gluehpilz_rot",   name = "Gluehpilz (rot)",   color = "#e74c3c", glow = 9 },
        { suffix = "gluehpilz_blau",  name = "Gluehpilz (blau)",  color = "#3498db", glow = 9 },
        { suffix = "gluehpilz_gelb",  name = "Gluehpilz (gelb)",  color = "#f1c40f", glow = 10 },
        { suffix = "gluehpilz_gruen", name = "Gluehpilz (gruen)", color = "#2ecc71", glow = 9 },
        { suffix = "gluehpilz_pink",  name = "Gluehpilz (pink)",  color = "#e84393", glow = 9 },
        { suffix = "gluehpilz_lila",  name = "Gluehpilz (lila)",  color = "#9b59b6", glow = 9 },

        -- Wald-Baubloecke (mushroom house + forest floor)
        { suffix = "moos", name = "Moos",
          texture = "[fill:16x16:#4e8b3a^[fill:3x3:2,3:#3a6b2a^[fill:2x2:9,2:#5fa047" ..
                    "^[fill:3x3:11,9:#3a6b2a^[fill:2x2:5,11:#5fa047^[fill:2x2:7,7:#3a6b2a" },
        { suffix = "waldboden", name = "Waldboden",
          texture = "[fill:16x16:#6e4b2a^[fill:3x2:2,3:#5a3c20^[fill:2x2:10,5:#5a3c20" ..
                    "^[fill:2x2:6,10:#7e5a34^[fill:2x2:12,11:#5a3c20^[fill:2x2:3,12:#7e5a34" },
        { suffix = "pilzstamm", name = "Pilz-Stamm (cremig)",
          texture = "[fill:16x16:#f5e6c8^[fill:2x16:4,0:#e8d3a8^[fill:2x16:10,0:#e8d3a8" },
        { suffix = "rindenholz", name = "Rinden-Holz",
          texture = "[fill:16x16:#6e4b2a^[fill:2x16:2,0:#5a3c20^[fill:2x16:7,0:#5a3c20" ..
                    "^[fill:2x16:12,0:#5a3c20" },
        { suffix = "holzdielen", name = "Holz-Dielen",
          texture = "[fill:16x16:#b9844f^[fill:16x1:0,4:#8a5e34^[fill:16x1:0,9:#8a5e34" ..
                    "^[fill:16x1:0,14:#8a5e34" },
        { suffix = "pilzhaus_wand", name = "Pilzhaus-Wand",
          texture = "[fill:16x16:#f5e6c8^[fill:5x6:5,5:#aaddff^[fill:1x6:5,5:#8a5e34" ..
                    "^[fill:1x6:10,5:#8a5e34^[fill:5x1:5,5:#8a5e34^[fill:5x1:5,11:#8a5e34" },
        { suffix = "fenster_glas", name = "Pilzhaus-Fenster", color = "#aaddff", glass = true },

        -- Glueh-Hoehlen-Bloecke
        { suffix = "hoehlenstein", name = "Hoehlen-Stein",
          texture = "[fill:16x16:#34302f^[fill:4x4:2,2:#403a39^[fill:3x3:10,9:#2a2625" ..
                    "^[fill:2x2:7,12:#403a39" },
        { suffix = "moosstein", name = "Moos-Stein",
          texture = "[fill:16x16:#5a5450^[fill:3x3:2,2:#4e8b3a^[fill:2x2:11,4:#3a6b2a" ..
                    "^[fill:3x2:6,11:#4e8b3a^[fill:2x2:12,12:#3a6b2a" },
        { suffix = "kristall", name = "Glueh-Kristall", color = "#5dade2", glow = 11 },
        { suffix = "gluehmoos", name = "Glueh-Moos", glow = 8,
          texture = "[fill:16x16:#1e8449^[fill:2x2:3,3:#7dff9e^[fill:2x2:10,5:#7dff9e" ..
                    "^[fill:2x2:6,11:#7dff9e^[fill:1x1:13,12:#aaffc0^[fill:1x1:2,9:#aaffc0" },

        -- Bach-Bloecke
        { suffix = "bachkiesel", name = "Bach-Kiesel",
          texture = "[fill:16x16:#9aa7ad^[fill:4x3:2,3:#7e8b91^[fill:3x3:10,8:#b6c2c7" ..
                    "^[fill:3x2:6,11:#7e8b91^[fill:2x2:3,11:#b6c2c7" },
        { suffix = "seerose", name = "Seerosen-Block", glow = 2,
          texture = "[fill:16x16:#2e7d6b^[fill:10x10:3,3:#27ae60^[fill:4x4:6,6:#e84393" },

        -- Gemusterte Deko-Bloecke (prozedural, ganz ohne Bilddateien).
        -- "texture" ist ein Luanti-Textur-Modifier: eine Basis "[fill"
        -- plus Auflagen "^[fill:BxH:X,Y:#farbe".
        { suffix = "muster_fliegenpilz", name = "Fliegenpilz-Block",
          texture = "[fill:16x16:#c0392b^[fill:3x3:2,2:#ffffff^[fill:3x3:11,3:#ffffff" ..
                    "^[fill:3x3:6,7:#ffffff^[fill:2x2:3,11:#ffffff^[fill:2x2:12,11:#ffffff" },
        { suffix = "muster_punkte", name = "Punkte-Block",
          texture = "[fill:16x16:#e84393^[fill:3x3:2,2:#ffffff^[fill:3x3:11,2:#ffffff" ..
                    "^[fill:3x3:2,11:#ffffff^[fill:3x3:11,11:#ffffff^[fill:3x3:6,6:#ffffff" },
        { suffix = "muster_streifen", name = "Streifen-Block",
          texture = "[fill:16x16:#2ecc71^[fill:3x16:3,0:#ffffff^[fill:3x16:10,0:#ffffff" },
        { suffix = "muster_schach", name = "Schachbrett-Block",
          texture = "[fill:16x16:#f1c40f^[fill:8x8:0,0:#6e4b2a^[fill:8x8:8,8:#6e4b2a" },
        { suffix = "muster_rahmen", name = "Rahmen-Block",
          texture = "[fill:16x16:#9b59b6^[fill:12x12:2,2:#c39bd3" },
        { suffix = "honigwabe", name = "Honigwaben-Block", glow = 3,
          texture = "[fill:16x16:#f39c12^[fill:4x4:1,2:#ffcf66^[fill:4x4:9,2:#ffcf66" ..
                    "^[fill:4x4:5,8:#ffcf66^[fill:4x4:11,8:#ffcf66^[fill:4x4:1,10:#ffcf66" },

        -- Per-face block: a real mushroom cap (red dotted "lid" on top,
        -- creamy stem on the sides) - a cosy little house roof piece.
        { suffix = "pilzhut", name = "Pilz-Hut (Dach)",
          top    = "[fill:16x16:#c0392b^[fill:3x3:2,2:#ffffff^[fill:3x3:11,3:#ffffff" ..
                   "^[fill:3x3:6,8:#ffffff^[fill:2x2:12,11:#ffffff",
          side   = "[fill:16x16:#cd5043^[fill:16x3:0,0:#c0392b^[fill:3x3:2,8:#ffffff" ..
                   "^[fill:3x3:10,9:#ffffff",
          bottom = "[fill:16x16:#f5e6c8" },

        -- Per-face block: a cosy storage stump (mossy lid, bark sides).
        { suffix = "vorratsstumpf", name = "Vorrats-Stumpf",
          top    = "[fill:16x16:#6e4b2a^[fill:14x14:1,1:#4e8b3a^[fill:4x4:6,6:#3a6b2a",
          side   = "[fill:16x16:#6e4b2a^[fill:2x16:3,0:#5a3c20^[fill:2x16:9,0:#5a3c20" ..
                   "^[fill:16x2:0,7:#7e5a34",
          bottom = "[fill:16x16:#5a3c20" },

        -- Eigenes gemaltes Bild als Block? Lege eine PNG (16x16 oder 32x32)
        -- "lernwelt_gluehpilz_meinbild.png" in den textures/-Ordner und entferne
        -- die zwei Minuszeichen vor der naechsten Zeile:
        -- { suffix = "meinbild", name = "Mein Bild", texture = "lernwelt_gluehpilz_meinbild.png" },
    },

    -- --- 3) Learning zones (each gets a placeable learning board) ---
    -- Zone titles double as the "habitat" shown in the logbook.
    zones = {
        {
            id = "pilzwald", title = "Pilzwald", color = "#8e44ad",
            activity = "Pilze und Tiere nach Farbe sortieren, eine Farb-Reihe " ..
                       "legen, Tiere benennen und zaehlen.",
            lehrplan = { "MA.2", "MA.1", "D.2" },
            tasks = {
                { type = "quiz", question = "Welche Farbe hat ein Marienkaefer?",
                  options = { "Rot", "Blau", "Gruen" }, answer = 1,
                  done = "Richtig! Marienkaefer sind rot mit schwarzen Punkten." },
                { type = "pattern",
                  sequence = { "#e74c3c", "#f1c40f", "#3498db" },
                  palette  = { { "#e74c3c", "Rot" }, { "#f1c40f", "Gelb" }, { "#3498db", "Blau" } },
                  done = "Super! Pilz-Reihe rot-gelb-blau sortiert." },
                { type = "rescue", creature = "marienkaefer", count = 2,
                  done = "Stark! Zwei Marienkaefer nach Hause gebracht." },
            },
        },
        {
            id = "gluehhoehle", title = "Glueh-Hoehle", color = "#2c2c54",
            activity = "Im Dunkeln leuchtende Pilze suchen, hell und dunkel " ..
                       "unterscheiden, Tag und Nacht erleben.",
            lehrplan = { "NMG.1", "MA.1" },
            tasks = {
                { type = "quiz", question = "Wann leuchten die Gluehpilze am schoensten?",
                  options = { "In der Nacht", "Am Mittag" }, answer = 1,
                  done = "Richtig! In der Nacht leuchten die Gluehpilze hell." },
                { type = "quiz", question = "Was machen wir, wenn es Nacht wird?",
                  options = { "Schlafen", "Schwimmen", "Rennen" }, answer = 1,
                  done = "Richtig! Nachts wird geschlafen." },
                { type = "rescue", creature = "gluehwuermchen", count = 2,
                  done = "Toll! Zwei Gluehwuermchen zum Leuchten gebracht." },
            },
        },
        {
            id = "bach", title = "Bach", color = "#3498db",
            activity = "Grosse und kleine Tiere vergleichen, klein und gross " ..
                       "ordnen, am Wasser spielen.",
            lehrplan = { "MA.1", "MA.2", "NMG.1" },
            tasks = {
                { type = "quiz", question = "Wer ist groesser?",
                  options = { "Biber", "Wassermaus" }, answer = 1,
                  done = "Genau! Der Biber ist viel groesser als die Maus." },
                { type = "quiz", question = "Was ist ganz klein?",
                  options = { "Wassermaus", "Biber" }, answer = 1,
                  done = "Richtig! Die Wassermaus ist ganz klein." },
                { type = "rescue", creature = "biber", count = 1,
                  done = "Klasse! Den grossen Biber zum Bach gebracht." },
            },
        },
    },

    -- --- 4) Rescuable forest friends (peaceful; right-click = rescue) ---
    creatures = {
        {
            id = "igel", name = "Igel", zone = "pilzwald",
            color = "#8d6e3a", size = 0.5, speed = 0.6, family = 1,
            food = "Schnecken", power = "Rollt sich zur Kugel",
            heart = "#d7c4a0",
            rescue_text = "Gerettet! Der Igel trippelt gemuetlich ins Laub.",
        },
        {
            id = "marienkaefer", name = "Marienkaefer", zone = "pilzwald",
            color = "#e74c3c", size = 0.4, speed = 0.8,
            food = "Blattlaeuse", power = "Hat Glueckspunkte",
            heart = "#f5b7b1",
            rescue_text = "Gerettet! Der Marienkaefer krabbelt los und fliegt davon.",
        },
        {
            id = "schmetterling", name = "Schmetterling", zone = "pilzwald",
            color = "#e84393", size = 0.4, speed = 1.2,
            food = "Bluetennektar", power = "Hat bunte Fluegel",
            heart = "#fd9bc8",
            rescue_text = "Gerettet! Der Schmetterling flattert bunt davon.",
        },
        {
            id = "eichhoernchen", name = "Eichhoernchen", zone = "pilzwald",
            color = "#d35400", size = 0.5, speed = 1.1, family = 1,
            food = "Nuesse", power = "Springt von Ast zu Ast",
            heart = "#f0a875",
            rescue_text = "Gerettet! Das Eichhoernchen huscht den Baum hinauf.",
        },
        {
            id = "schnecke", name = "Schnecke", zone = "pilzwald",
            color = "#f39c12", size = 0.4, speed = 0.2,
            food = "Blaetter", power = "Traegt ihr Haus mit sich",
            heart = "#fad7a0",
            rescue_text = "Gerettet! Die Schnecke kriecht ganz langsam davon.",
        },
        {
            id = "gluehwuermchen", name = "Gluehwuermchen", zone = "gluehhoehle",
            color = "#f1c40f", size = 0.3, speed = 0.7, glow = 12,
            food = "Tau", power = "Leuchtet im Dunkeln",
            heart = "#fdebd0",
            rescue_text = "Gerettet! Das Gluehwuermchen leuchtet dir dankbar nach.",
        },
        {
            id = "leuchtkaefer", name = "Leucht-Kaefer", zone = "gluehhoehle",
            color = "#2ecc71", size = 0.4, speed = 0.8, glow = 10,
            food = "Pilzsporen", power = "Glueht gruen",
            heart = "#a9dfbf",
            rescue_text = "Gerettet! Der Leucht-Kaefer brummt leuchtend davon.",
        },
        {
            id = "fledermaus", name = "Fledermaus", zone = "gluehhoehle",
            color = "#6c3483", size = 0.5, speed = 1.4,
            food = "Motten", power = "Hoert im Dunkeln",
            heart = "#bb8fce",
            rescue_text = "Gerettet! Die Fledermaus flattert leise in die Hoehle.",
        },
        {
            id = "kristallschnecke", name = "Kristall-Schnecke", zone = "gluehhoehle",
            color = "#5dade2", size = 0.4, speed = 0.2, glow = 6,
            food = "Glitzersteine", power = "Schimmert wie Kristall",
            heart = "#aed6f1",
            rescue_text = "Gerettet! Die Kristall-Schnecke schimmert sanft davon.",
        },
        {
            id = "biber", name = "Biber", zone = "bach",
            color = "#6e4b2a", size = 0.8, speed = 0.6, family = 1,
            food = "Rinde", power = "Baut grosse Daemme",
            heart = "#c8a06e",
            rescue_text = "Gerettet! Der grosse Biber platscht zufrieden in den Bach.",
        },
        {
            id = "wassermaus", name = "Wassermaus", zone = "bach",
            color = "#95a5a6", size = 0.3, speed = 1.0,
            food = "Samen", power = "Ganz klein und flink",
            heart = "#d7dbdd",
            rescue_text = "Gerettet! Die kleine Wassermaus flitzt ins Gras.",
        },
        {
            id = "entlein", name = "Entlein", zone = "bach",
            color = "#f1c40f", size = 0.4, speed = 0.7, swims = true, family = 2,
            food = "Wasserlinsen", power = "Schwimmt schon als Baby",
            heart = "#fce8a0",
            rescue_text = "Gerettet! Das Entlein paddelt froehlich zur Mama.",
        },
        {
            id = "frosch", name = "Frosch", zone = "bach",
            color = "#27ae60", size = 0.4, speed = 0.9,
            food = "Fliegen", power = "Springt ganz weit",
            heart = "#82e0aa",
            rescue_text = "Gerettet! Der Frosch huepft quakend zum Bach.",
        },
        {
            -- legendary, rare: never auto-spawns (egg/manual only)
            id = "traumfalter", name = "Traum-Falter", zone = "gluehhoehle",
            color = "#f1c40f", size = 0.9, speed = 1.0, glow = 12, rare = true,
            food = "Mondlicht", power = "Sehr selten und magisch",
            heart = "#fff2a8",
            rescue_text = "Der legendaere Traum-Falter schenkt dir ein sanftes Leuchten!",
        },
    },

    -- --- 5) Ranks (3rd field = colour -> creates a badge item) ---
    ranks = {
        { 0,  "Pilz-Knirps" },
        { 5,  "Wald-Schnupperer" },
        { 10, "Pilz-Freund",  "#2ecc71" },
        { 25, "Glueh-Hueter", "#9b59b6" },
        { 50, "Wald-Koenig",  "#f1c40f" },
    },

    -- --- 6) Logbook item ---
    logbook = { title = "Wald-Tagebuch", item_color = "#e67e22" },

    -- --- 7) Plain texts for curriculum codes (for /lernplan & boards) ---
    kompetenzen = {
        ["MA.1"]  = "Mengen erfassen und zaehlen (Pilze und Tiere zaehlen)",
        ["MA.2"]  = "Sortieren und ordnen: nach Farbe und nach Groesse (klein/gross)",
        ["NMG.1"] = "Tag und Nacht erleben, hell und dunkel unterscheiden",
        ["D.2"]   = "Tiere und Pilze benennen und beschreiben",
    },
})

-- ------------------------------------------------------------
--  B) EXTRA: LEUCHT-KAEFER  (rideable glow-beetle mount)
--  Not part of the engine - a self-contained mount the theme adds
--  on its own. Lives in the same "lernwelt_gluehpilz:" namespace.
--  A gentle, slow, glowing beetle you ride through the forest and
--  the cave. Controls: place -> right-click to mount -> W/S move,
--  A/D steer, jump = up, sneak = down, right-click = dismount.
--  A second player can ride along.
-- ------------------------------------------------------------
local BEETLE_SPEED = 4

core.register_entity(WORLD_ID .. ":reitkaefer", {
    initial_properties = {
        physical = true, collide_with_objects = true,
        collisionbox = { -0.6, -0.4, -0.6, 0.6, 0.4, 0.6 },
        visual = "cube", visual_size = { x = 1.1, y = 0.9, z = 1.3 },
        textures = {
            "[fill:16x16:#27ae60", "[fill:16x16:#1e8449",
            "[fill:16x16:#2ecc71", "[fill:16x16:#2ecc71",
            "[fill:16x16:#34302f", "[fill:16x16:#2ecc71",
        },
    },
    _driver = nil, _passenger = nil, _hum = nil, _spore = 0,

    on_rightclick = function(self, clicker)
        if not (clicker and clicker:is_player()) then return end
        local name = clicker:get_player_name()
        if self._driver == name then
            clicker:set_detach()
            clicker:set_eye_offset({ x = 0, y = 0, z = 0 }, { x = 0, y = 0, z = 0 })
            self._driver = nil
            self.object:set_properties({ glow = 0 })
            if self._hum then core.sound_stop(self._hum); self._hum = nil end
            core.chat_send_player(name, "Du steigst vom Leucht-Kaefer ab.")
        elseif self._passenger == name then
            clicker:set_detach()
            clicker:set_eye_offset({ x = 0, y = 0, z = 0 }, { x = 0, y = 0, z = 0 })
            self._passenger = nil
            core.chat_send_player(name, "Du steigst als Mitfahrer ab.")
        elseif not self._driver then
            clicker:set_attach(self.object, "", { x = 0, y = 4, z = 0 }, { x = 0, y = 0, z = 0 })
            self._driver = name
            self.object:set_properties({ glow = 12 })   -- Kaefer leuchtet
            self._hum = core.sound_play(WORLD_ID .. "_kaefer",
                { object = self.object, loop = true, gain = 0.4 })
            core.chat_send_player(name,
                "Leucht-Kaefer geweckt! W/S fliegen, A/D lenken, Springen = hoch, " ..
                "Schleichen = runter, Rechtsklick = absteigen. " ..
                "(Ein zweiter Spieler kann mitfliegen!)")
        elseif not self._passenger then
            clicker:set_attach(self.object, "", { x = -4, y = 4, z = 0 }, { x = 0, y = 0, z = 0 })
            self._passenger = name
            core.chat_send_player(name, "Du fliegst als Mitfahrer mit! Rechtsklick = absteigen.")
        end
    end,

    on_step = function(self, dtime)
        self.object:set_acceleration({ x = 0, y = 0, z = 0 })
        local driver = self._driver and core.get_player_by_name(self._driver)
        if not driver then
            self.object:set_velocity({ x = 0, y = 0, z = 0 })
            if self._hum then core.sound_stop(self._hum); self._hum = nil end
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
        local fwd = (ctrl.up and BEETLE_SPEED) or (ctrl.down and -BEETLE_SPEED * 0.5) or 0
        local vy  = (ctrl.jump and BEETLE_SPEED * 0.6) or (ctrl.sneak and -BEETLE_SPEED * 0.6) or 0
        self.object:set_velocity({ x = dir.x * fwd, y = vy, z = dir.z * fwd })

        -- soft glowing spore trail while moving
        if fwd ~= 0 or vy ~= 0 then
            self._spore = (self._spore or 0) + dtime
            if self._spore > 0.25 then
                self._spore = 0
                local p = self.object:get_pos()
                core.add_particlespawner({
                    amount = 5, time = 0.2,
                    minpos = vector.subtract(p, 0.4), maxpos = vector.add(p, 0.4),
                    minvel = { x = -0.2, y = 0.3, z = -0.2 },
                    maxvel = { x = 0.2,  y = 0.8, z = 0.2 },
                    minexptime = 0.6, maxexptime = 1.2, minsize = 1, maxsize = 2,
                    texture = "[fill:8x8:#d6ffe0",
                })
            end
        end
    end,
})

core.register_craftitem(WORLD_ID .. ":reitkaefer", {
    description = "Leucht-Kaefer (Reittier)\nPlatzieren, dann Rechtsklick zum Aufsteigen",
    inventory_image = "[fill:16x16:#2ecc71^[fill:8x8:4,4:#34302f^[fill:4x4:6,2:#1e8449",
    on_place = function(itemstack, placer, pointed_thing)
        if pointed_thing.type ~= "node" or not (placer and placer:is_player()) then
            return itemstack
        end
        local pos = pointed_thing.above
        pos.y = pos.y + 0.5
        core.add_entity(pos, WORLD_ID .. ":reitkaefer")
        if not core.is_creative_enabled(placer:get_player_name()) then
            itemstack:take_item()
        end
        return itemstack
    end,
})

-- ------------------------------------------------------------
--  C) EXTRA: TAG-NACHT-PILZE  (day / dusk / night mushrooms)
--  The theme's special feature and its core learning goal:
--  "Tag-Nacht-Wechsel ueber leuchtende Pilze". Right-click a
--  glowing mushroom to change the time of the whole world:
--    tag_pilz     -> Tag    (bright, sun)
--    daemmer_pilz -> Daemmerung (soft golden evening)
--    nacht_pilz   -> Nacht  (the Gluehpilze light up the forest)
--  Because the world is frozen (time_speed = 0), the chosen time
--  simply stays until a child picks another mushroom - a calm,
--  deliberate day/night experience instead of a fast, scary cycle.
--  We also store the choice in lernwelt._timeofday so the engine
--  re-applies it on the next join.
-- ------------------------------------------------------------
local function set_world_time(tod, message)
    core.set_timeofday(tod)
    lernwelt._timeofday = tod   -- the engine re-applies this on join
    for _, pl in ipairs(core.get_connected_players()) do
        local n = pl:get_player_name()
        core.sound_play(WORLD_ID .. "_pilz", { to_player = n, gain = 0.5 })
        core.chat_send_player(n, message)
    end
end

local TIME_PILZE = {
    {
        suffix = "tag_pilz", name = "Tag-Pilz (macht es hell)",
        tod = 0.5, glow = 13,
        msg = "Es wird Tag! Die Sonne scheint ueber den Wald.",
        tile = "[fill:16x16:#f1c40f^[fill:6x6:5,2:#fff2a8^[fill:8x4:4,9:#f5e6c8" ..
               "^[fill:2x2:7,12:#e8d3a8",
    },
    {
        suffix = "daemmer_pilz", name = "Daemmer-Pilz (macht es golden)",
        tod = 0.8, glow = 9,
        msg = "Es wird Daemmerung - alles leuchtet golden und gemuetlich.",
        tile = "[fill:16x16:#e67e22^[fill:6x6:5,2:#f5b041^[fill:8x4:4,9:#f5e6c8" ..
               "^[fill:2x2:7,12:#e8d3a8",
    },
    {
        suffix = "nacht_pilz", name = "Nacht-Pilz (macht es Nacht)",
        tod = 0.0, glow = 9,
        msg = "Es wird Nacht - jetzt leuchten die Gluehpilze ganz hell!",
        tile = "[fill:16x16:#2c2c54^[fill:6x6:5,2:#5d5d9e^[fill:2x2:3,3:#ffffff" ..
               "^[fill:1x1:11,4:#ffffff^[fill:8x4:4,9:#f5e6c8^[fill:2x2:7,12:#e8d3a8",
    },
}

for _, p in ipairs(TIME_PILZE) do
    core.register_node(WORLD_ID .. ":" .. p.suffix, {
        description = p.name .. "\nRechtsklick = Tageszeit aendern",
        drawtype = "plantlike",
        paramtype = "light",
        light_source = p.glow,
        sunlight_propagates = true,
        walkable = false,
        floodable = false,
        tiles = { p.tile },
        inventory_image = p.tile,
        selection_box = { type = "fixed", fixed = { -0.4, -0.5, -0.4, 0.4, 0.4, 0.4 } },
        groups = { dig_immediate = 3, oddly_breakable_by_hand = 3 },
        on_rightclick = function(pos, node, clicker)
            if clicker and clicker:is_player() then
                set_world_time(p.tod, p.msg)
            end
        end,
    })
end

-- ------------------------------------------------------------
--  D) EXTRA: STARTER KIT  (handed out once on first join)
--  Makes the world testable right away: the logbook, the camera,
--  the Leucht-Kaefer, mushroom seeds, a stack of each glow
--  mushroom + forest block + the Tag-Nacht-Pilze, and one spawn
--  egg per forest friend (the engine registers the eggs when a
--  mob API is present; missing items are simply skipped).
--  Turn off via the setting "lernwelt_gluehpilz_starter_kit".
-- ------------------------------------------------------------
local STARTER_BLOCKS = {
    "gluehpilz_rot", "gluehpilz_blau", "gluehpilz_gelb",
    "gluehpilz_gruen", "gluehpilz_pink", "gluehpilz_lila",
    "moos", "waldboden", "pilzstamm", "pilzhut", "pilzhaus_wand", "fenster_glas",
    "kristall", "gluehmoos",
    "tag_pilz", "daemmer_pilz", "nacht_pilz",
}
-- Spawn-egg item names match the creature ids (world_id:creature_id)
local STARTER_EGGS = {
    "igel", "marienkaefer", "schmetterling", "eichhoernchen", "schnecke",
    "gluehwuermchen", "leuchtkaefer", "fledermaus", "kristallschnecke",
    "biber", "wassermaus", "entlein", "frosch", "traumfalter",
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
    give_if_exists(inv, WORLD_ID .. ":reitkaefer")
    give_if_exists(inv, WORLD_ID .. ":pilz_setzling 5")
    for _, suffix in ipairs(STARTER_BLOCKS) do
        give_if_exists(inv, WORLD_ID .. ":" .. suffix .. " 10")
    end
    for _, cid in ipairs(STARTER_EGGS) do
        give_if_exists(inv, WORLD_ID .. ":" .. cid)
    end
    core.chat_send_player(player:get_player_name(),
        "Gluehpilz-Wald: Startausruestung erhalten - Wald-Tagebuch, Kamera, " ..
        "Leucht-Kaefer, Gluehpilze, Tag-Nacht-Pilze, Bau-Bloecke, Pilz-Setzlinge " ..
        "und Spawn-Eier sind in deinem Inventar. Viel Spass im Wald!")
end

core.register_on_joinplayer(function(player)
    if not core.settings:get_bool("lernwelt_gluehpilz_starter_kit", true) then return end
    local meta = player:get_meta()
    if meta:get_int("lernwelt_gluehpilz:starter_given") == 1 then return end
    meta:set_int("lernwelt_gluehpilz:starter_given", 1)
    -- slight delay so the inventory exists and the message is seen
    core.after(1.5, function()
        if player and player:is_player() then give_starter_kit(player) end
    end)
end)

-- ------------------------------------------------------------
--  E) EXTRA: GROUND SPAWNER  (a living forest)
--  The engine's built-in spawner only places water animals, so
--  this small, backend-agnostic spawner brings the (land-walking)
--  forest friends to life: every so often it tries to add one
--  non-rare, non-swimming creature on solid ground with air above,
--  near a player, capped so the forest never gets crowded. Turn
--  off with the setting "lernwelt_spawn_creatures".
-- ------------------------------------------------------------
local function ground_spawn_list()
    local list  = {}
    local world = lernwelt.worlds[WORLD_ID]
    for _, c in ipairs((world or {}).creatures or {}) do
        if not c.rare and not c.swims then list[#list + 1] = WORLD_ID .. ":" .. c.id end
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
--  F) EXTRA: WALD AUFRAEUMEN  (forest-cleanup mini-game)
--  Litter nodes you can break to clean up the wood. Each piece
--  adds to a personal cleanup counter with small milestones.
--  Place test litter with "/pilzwald_muell" (priv: server) or via
--  the test station. Fits the motto: "Bewahren".
-- ------------------------------------------------------------
local TRASH = {
    { suffix = "muell_papier",  name = "Papier (Wald-Muell)",      color = "#ecf0f1" },
    { suffix = "muell_dose",    name = "Blechdose (Wald-Muell)",   color = "#b2babb" },
    { suffix = "muell_flasche", name = "Plastikflasche (Wald-Muell)", color = "#a3e4d7" },
}

local CLEAN_MILESTONES = {
    [5]  = "Wald-Putzer",
    [15] = "Hain-Heger",
    [30] = "Wald-Held",
}

local function collect_trash(player)
    if not (player and player:is_player()) then return end
    local meta = player:get_meta()
    local n = meta:get_int("lernwelt_gluehpilz:muell") + 1
    meta:set_int("lernwelt_gluehpilz:muell", n)
    local name = player:get_player_name()
    core.sound_play("lernwelt_rescue", { to_player = name, gain = 0.8 })
    core.chat_send_player(name, "Muell eingesammelt! Sauberer Wald: " .. n .. " Stueck.")
    local title = CLEAN_MILESTONES[n]
    if title then
        core.sound_play("lernwelt_rankup", { to_player = name, gain = 1.0 })
        core.chat_send_player(name, "Toll! Du bist jetzt: " .. title .. "!")
    end
end

for _, t in ipairs(TRASH) do
    core.register_node(WORLD_ID .. ":" .. t.suffix, {
        description = t.name .. "\nAbbauen = Wald saeubern",
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

core.register_chatcommand("pilzwald_muell", {
    description = "Verteilt etwas Wald-Muell zum Aufraeumen um dich herum (zum Testen)",
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
                    local t = TRASH[math.random(#TRASH)]
                    core.set_node(q, { name = WORLD_ID .. ":" .. t.suffix })
                    placed = placed + 1
                    break
                end
            end
        end
        if placed == 0 then
            return true, "Kein passender Platz gefunden - stell dich auf festen Boden und versuch es nochmal."
        end
        return true, placed .. " Stueck Muell verteilt - sammle sie ein (abbauen)!"
    end,
})

-- ------------------------------------------------------------
--  G) EXTRA: PILZE PFLANZEN  (grow your own glow mushrooms)
--  A mushroom seed you place; after a while it grows into a random
--  glowing mushroom block. Each grown mushroom adds to a personal
--  "Pilze" counter. Fits the motto: "Bewahren / aufbauen".
-- ------------------------------------------------------------
local PILZ_GROWN = {
    "gluehpilz_rot", "gluehpilz_blau", "gluehpilz_gelb",
    "gluehpilz_gruen", "gluehpilz_pink", "gluehpilz_lila",
}
local GROW_TIME = 20

core.register_node(WORLD_ID .. ":pilz_setzling", {
    description = "Pilz-Setzling\nSetzen - waechst zu einem Gluehpilz",
    drawtype = "plantlike",
    paramtype = "light",
    light_source = 3,
    sunlight_propagates = true,
    walkable = false,
    floodable = false,
    tiles = { "[fill:16x16:#4e8b3a^[fill:5x5:5,3:#e8d3a8^[fill:4x3:6,8:#f5e6c8" },
    inventory_image = "[fill:16x16:#4e8b3a^[fill:5x5:5,3:#e8d3a8^[fill:4x3:6,8:#f5e6c8",
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
        core.set_node(pos, { name = WORLD_ID .. ":" .. PILZ_GROWN[math.random(#PILZ_GROWN)] })
        if planter ~= "" then
            local p = core.get_player_by_name(planter)
            if p then
                local meta = p:get_meta()
                local n = meta:get_int("lernwelt_gluehpilz:pilze") + 1
                meta:set_int("lernwelt_gluehpilz:pilze", n)
                core.sound_play("lernwelt_rescue", { to_player = planter, gain = 0.6 })
                core.chat_send_player(planter, "Ein Gluehpilz ist gewachsen! Deine Pilze: " .. n)
            end
        end
        return false
    end,
})

-- ------------------------------------------------------------
--  H) EXTRA: TEST STATION  (chat command for quick setup)
--  "/pilzwald_teststation" builds a small ready-made spot in front
--  of you: a moss floor, the three learning boards, a Leucht-Kaefer,
--  a row of Tag-Nacht-Pilze to try, some glow mushrooms for cosy
--  light and a little litter to clean up. Handy for testing or for
--  an adult to prepare the world. It overwrites the nodes where it
--  builds, so it needs the "server" privilege.
-- ------------------------------------------------------------
local STATION_BOARDS = {
    WORLD_ID .. ":tafel_pilzwald",
    WORLD_ID .. ":tafel_gluehhoehle",
    WORLD_ID .. ":tafel_bach",
}

local function build_test_station(player)
    local base    = vector.round(player:get_pos())
    local floor_y = base.y - 1
    local floor   = WORLD_ID .. ":moos"

    -- 7 wide (x: -3..3) x 4 deep (z: +2..+5) moss floor in front of you
    for dx = -3, 3 do
        for dz = 2, 5 do
            core.set_node({ x = base.x + dx, y = floor_y, z = base.z + dz }, { name = floor })
        end
    end

    -- the three learning boards on the floor, panels facing back to you
    local xs = { -2, 0, 2 }
    for i, board in ipairs(STATION_BOARDS) do
        if core.registered_nodes[board] then
            core.set_node({ x = base.x + xs[i], y = floor_y + 1, z = base.z + 3 },
                { name = board, param2 = 2 })
        end
    end

    -- a row of Tag-Nacht-Pilze to try (right-click them!)
    core.set_node({ x = base.x - 2, y = floor_y + 1, z = base.z + 4 },
        { name = WORLD_ID .. ":tag_pilz" })
    core.set_node({ x = base.x, y = floor_y + 1, z = base.z + 4 },
        { name = WORLD_ID .. ":daemmer_pilz" })
    core.set_node({ x = base.x + 2, y = floor_y + 1, z = base.z + 4 },
        { name = WORLD_ID .. ":nacht_pilz" })

    -- a couple of glow mushrooms for cosy light
    core.set_node({ x = base.x - 3, y = floor_y + 1, z = base.z + 2 },
        { name = WORLD_ID .. ":gluehpilz_lila" })
    core.set_node({ x = base.x + 3, y = floor_y + 1, z = base.z + 2 },
        { name = WORLD_ID .. ":gluehpilz_gruen" })

    -- a Leucht-Kaefer ready to ride
    core.add_entity({ x = base.x, y = floor_y + 1.5, z = base.z + 5 },
        WORLD_ID .. ":reitkaefer")

    -- a few litter pieces for the cleanup mini-game
    local litter = { "muell_papier", "muell_dose", "muell_flasche" }
    local spots  = { { -1, 2 }, { 1, 5 }, { -3, 4 }, { 3, 5 } }
    for _, s in ipairs(spots) do
        core.set_node({ x = base.x + s[1], y = floor_y + 1, z = base.z + s[2] },
            { name = WORLD_ID .. ":" .. litter[math.random(#litter)] })
    end
end

core.register_chatcommand("pilzwald_teststation", {
    description = "Baut eine kleine Gluehpilz-Test-Station vor dir " ..
                  "(Moos-Boden, 3 Lern-Tafeln, Leucht-Kaefer, Tag-Nacht-Pilze)",
    privs = { server = true },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then
            return false, "Dieser Befehl funktioniert nur im Spiel."
        end
        build_test_station(player)
        return true, "Test-Station gebaut! Sie steht vor dir Richtung Norden (+Z): " ..
                     "Moos-Boden, drei Lern-Tafeln, ein Leucht-Kaefer, drei Tag-Nacht-" ..
                     "Pilze zum Ausprobieren und etwas Muell zum Aufraeumen."
    end,
})

-- ------------------------------------------------------------
--  I) EXTRA: GROSSES PILZHAUS  (the signature base)
--  "/pilzwald_haus" builds the world's home base in front of you:
--  a big mushroom house with a thick creamy stem, a round red
--  dotted cap (Fliegenpilz), a doorway, windows, a wooden floor,
--  the three learning boards inside, glow mushrooms for cosy light,
--  a Tag-Nacht-Pilz trio and a Leucht-Kaefer. Priv: server.
-- ------------------------------------------------------------
core.register_chatcommand("pilzwald_haus", {
    description = "Baut ein grosses Pilzhaus (Basis) vor dir - mit Tafeln, " ..
                  "Gluehpilzen, Tag-Nacht-Pilzen und Leucht-Kaefer",
    privs = { server = true },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then return false, "Dieser Befehl funktioniert nur im Spiel." end
        local b     = vector.round(player:get_pos())
        local stem  = WORLD_ID .. ":pilzstamm"
        local cap   = WORLD_ID .. ":pilzhut"
        local floor = WORLD_ID .. ":holzdielen"
        local wall  = WORLD_ID .. ":pilzhaus_wand"
        local glass = WORLD_ID .. ":fenster_glas"
        local R, fy = 5, b.y - 1
        local z0    = b.z + 2          -- house centre is at z0 + R
        local cz    = z0 + R

        -- wooden floor + round wall (stem) up to 4 high, with a doorway
        -- at the front (z0) and four windows around the wall
        for dx = -R, R do
            for dz = 0, 2 * R do
                local x, z   = b.x + dx, z0 + dz
                local inside = (dx * dx + (dz - R) * (dz - R)) <= (R * R)
                if inside then
                    core.set_node({ x = x, y = fy, z = z }, { name = floor })
                end
                local rim = (dx * dx + (dz - R) * (dz - R))
                local on_wall = rim <= (R * R) and rim > ((R - 1) * (R - 1))
                if on_wall then
                    for dy = 1, 4 do
                        local door   = (dz == 0 and math.abs(dx) <= 1 and dy <= 3)
                        local window = (dy == 2 or dy == 3) and
                                       (math.abs(dx) == R - 1 or dz == 1 or dz == 2 * R - 1)
                        local node = wall
                        if door then node = nil
                        elseif window then node = glass end
                        if node then
                            core.set_node({ x = x, y = fy + dy, z = z }, { name = node })
                        end
                    end
                end
            end
        end

        -- the big round red dotted cap, a dome two blocks above the wall
        for dy = 0, 3 do
            local cr = R + 1 - dy            -- cap shrinks towards the top
            for dx = -cr, cr do
                for dz = -cr, cr do
                    if dx * dx + dz * dz <= cr * cr + 1 then
                        core.set_node({ x = b.x + dx, y = fy + 4 + dy, z = cz + dz },
                            { name = cap })
                    end
                end
            end
        end

        -- the three learning boards inside, facing the door
        local boards = { "tafel_pilzwald", "tafel_gluehhoehle", "tafel_bach" }
        local xs = { -2, 0, 2 }
        for i, bd in ipairs(boards) do
            local nn = WORLD_ID .. ":" .. bd
            if core.registered_nodes[nn] then
                core.set_node({ x = b.x + xs[i], y = fy + 1, z = cz + R - 2 },
                    { name = nn, param2 = 2 })
            end
        end

        -- cosy glow mushrooms in the corners + a Tag-Nacht-Pilz trio
        local glow = { "gluehpilz_rot", "gluehpilz_blau", "gluehpilz_gelb",
                       "gluehpilz_gruen", "gluehpilz_pink", "gluehpilz_lila" }
        local glowspots = { { -3, R - 2 }, { 3, R - 2 }, { -3, R + 2 }, { 3, R + 2 } }
        for i, s in ipairs(glowspots) do
            core.set_node({ x = b.x + s[1], y = fy + 1, z = z0 + s[2] },
                { name = WORLD_ID .. ":" .. glow[((i - 1) % #glow) + 1] })
        end
        core.set_node({ x = b.x - 1, y = fy + 1, z = cz }, { name = WORLD_ID .. ":tag_pilz" })
        core.set_node({ x = b.x,     y = fy + 1, z = cz }, { name = WORLD_ID .. ":daemmer_pilz" })
        core.set_node({ x = b.x + 1, y = fy + 1, z = cz }, { name = WORLD_ID .. ":nacht_pilz" })

        -- a Leucht-Kaefer waiting just outside the door
        core.add_entity({ x = b.x, y = fy + 1.5, z = z0 - 1 }, WORLD_ID .. ":reitkaefer")

        return true, "Grosses Pilzhaus gebaut! Geh durch die Tuer (Richtung +Z): " ..
                     "drinnen warten die drei Lern-Tafeln, Gluehpilze, die Tag-Nacht-" ..
                     "Pilze und vor der Tuer ein Leucht-Kaefer."
    end,
})

-- ------------------------------------------------------------
--  J) EXTRA: AMBIENT-SOUND  (gentle forest / cricket sounds)
--  Plays a gentle forest sound to each player now and then. The
--  .ogg files are optional (missing = silent, only a warning).
-- ------------------------------------------------------------
local amb_timer, amb_next = 0, 45
core.register_globalstep(function(dtime)
    amb_timer = amb_timer + dtime
    if amb_timer < amb_next then return end
    amb_timer = 0
    amb_next = 35 + math.random(0, 40)
    for _, player in ipairs(core.get_connected_players()) do
        local snd = (math.random() < 0.5) and "_wald" or "_ambient"
        core.sound_play(WORLD_ID .. snd, { to_player = player:get_player_name(), gain = 0.4 })
    end
end)

-- ------------------------------------------------------------
--  K) EXTRA: GLUEH-SPOREN  (cosy drifting spores at night)
--  A purely visual touch: when it is dark, soft glowing spores
--  drift gently upward around each player - the forest feels alive
--  and cuddly at night. Throttled and silent (no gameplay effect).
-- ------------------------------------------------------------
local spore_timer = 0
core.register_globalstep(function(dtime)
    spore_timer = spore_timer + dtime
    if spore_timer < 2.0 then return end
    spore_timer = 0
    if core.get_timeofday() > 0.25 and core.get_timeofday() < 0.75 then return end  -- only when dark
    for _, player in ipairs(core.get_connected_players()) do
        local p = player:get_pos()
        core.add_particlespawner({
            amount = 8, time = 2.0,
            minpos = { x = p.x - 5, y = p.y - 1, z = p.z - 5 },
            maxpos = { x = p.x + 5, y = p.y + 3, z = p.z + 5 },
            minvel = { x = -0.1, y = 0.2, z = -0.1 },
            maxvel = { x = 0.1,  y = 0.6, z = 0.1 },
            minexptime = 1.5, maxexptime = 3.0, minsize = 1, maxsize = 2,
            glow = 8,
            texture = "[fill:8x8:#d6ffe0",
            playername = player:get_player_name(),
        })
    end
end)

-- ------------------------------------------------------------
--  L) EXTRA: BUCHSTABEN-BLOECKE  (A-Z, zum Woerterlegen)
--  A tiny 5x7 pixel font rendered into each block's texture with
--  layered "[fill" - no image files. Nice for "Deutsch / benennen":
--  lay out names and simple words from letter blocks (think wooden
--  signs in the forest). For Umlauts use AE/OE/UE.
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
    local t = { "[fill:16x16:#f5e6c8" }
    for r = 1, #rows do
        local row = rows[r]
        for c = 1, #row do
            if row:sub(c, c) == "#" then
                t[#t + 1] = ("^[fill:2x2:%d,%d:#6e4b2a"):format(3 + (c - 1) * 2, 1 + (r - 1) * 2)
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

core.log("action", "[lernwelt_gluehpilz] Theme 'Gluehpilz-Wald' registered (on lernwelt engine).")
