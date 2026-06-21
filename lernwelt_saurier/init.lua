-- ============================================================
--  THEME:  SAURIER-FORSCHER  (friendly herbivore dinosaurs)
--  A brand-free dinosaur learning world built ON TOP of the
--  reusable "lernwelt" engine. Almost everything below is one
--  declarative register_world{...} call - blocks, learning
--  zones, friendly dinos, logbook, ranks and badges all come
--  from the engine.
--
--  The base is a "Forscherstation" (research station). Three
--  zones make up the world:
--    * Tal                     - the valley, where the dinos roam
--    * Fossilien-Grabungsstaette - the fossil dig site (dig in sand)
--    * Nistplatz               - the nesting place (eggs & families)
--
--  Learning goals: dino names, comparing sizes (klein-mittel-gross),
--  "Ausgraben" (digging/searching in sand for fossils) and
--  classifying (Pflanzenfresser? which dino group?). Tagged to
--  the Swiss curriculum (Lehrplan 21, cycle 1): mainly NMG and
--  Mathematik / Groessen.
--
--  Things the engine cannot express live as small pieces of
--  custom code after register_world:
--    B) the drivable "Forscher-Jeep" (ground vehicle)
--    C) a starter kit handed out on first join (quick testing)
--    D) a ready-made test station (chat command)
--    E) "AUSGRABEN" - the dig-for-fossils mini-game (the heart)
--    F) hatching dino eggs into little ones (Nistplatz)
--    G) a gentle land spawner so the valley feels alive
--    H) a bigger Forscherstation base (chat command)
--    I) ambient dino calls
--    J) letter blocks A-Z (dino names) + number blocks 0-9 (counting)
--    K) a "Groessen-Parade" command: line up dinos klein -> gross
--
--  The mod name equals the world id ("lernwelt_saurier"), so all
--  nodes/items live in the "lernwelt_saurier:" namespace.
--
--  Content is authored in German (ASCII: ae/oe/ue), like the
--  other example themes. The engine's own UI is translated
--  separately via lernwelt/locale/*.tr.
-- ============================================================

local WORLD_ID = "lernwelt_saurier"
local function L(suffix) return WORLD_ID .. ":" .. suffix end

-- ------------------------------------------------------------
--  A) THE WHOLE LEARNING WORLD AS ONE DECLARATIVE TABLE
-- ------------------------------------------------------------
lernwelt.register_world({

    -- internal prefix; kept identical to the mod name so all
    -- nodes/items live in the "lernwelt_saurier:" namespace
    id    = WORLD_ID,
    title = "Saurier-Forscher",

    -- --- 1) Peaceful, child-friendly world ---
    config = {
        damage      = false,   -- no damage / no dying
        creative    = true,    -- unlimited blocks
        peaceful    = true,    -- no monsters
        freeze_time = "day",   -- always bright (no scary nights)
        no_weather  = true,
    },

    -- --- 2) Earthy dino blocks + station glass (no PNG needed) ---
    blocks = {
        { suffix = "fels",          name = "Urzeit-Fels",       color = "#7f8c8d" },
        { suffix = "sandstein",     name = "Sandstein",         color = "#e4c690" },
        { suffix = "wuestensand",   name = "Wuesten-Sand",      color = "#f4e3c1" },
        { suffix = "blattwerk",     name = "Dschungel-Blatt",   color = "#2e8b57" },
        { suffix = "vulkangestein", name = "Vulkangestein",     color = "#34495e" },
        { suffix = "bernstein",     name = "Bernstein-Block",   color = "#f39c12", glow = 7 },
        { suffix = "stationsglas",  name = "Stations-Glas",     color = "#aaddff", glass = true },

        -- Patterned decoration blocks (procedural, no image files needed).
        -- The "texture" field is a Luanti texture-modifier string: a base
        -- "[fill" plus overlaid "^[fill:WxH:X,Y:#colour" rectangles.
        { suffix = "muster_fussabdruck", name = "Fussabdruck-Block",
          texture = "[fill:16x16:#e4c690^[fill:4x5:6,8:#5d4037" ..
                    "^[fill:2x3:4,5:#5d4037^[fill:2x3:8,4:#5d4037^[fill:2x3:11,5:#5d4037" },
        { suffix = "muster_knochen", name = "Knochen-Block",
          texture = "[fill:16x16:#7f8c8d^[fill:8x2:4,7:#f5f5f5" ..
                    "^[fill:3x3:2,5:#f5f5f5^[fill:3x3:2,8:#f5f5f5" ..
                    "^[fill:3x3:11,5:#f5f5f5^[fill:3x3:11,8:#f5f5f5" },
        { suffix = "muster_ei", name = "Nest-Block",
          texture = "[fill:16x16:#8d6e3a^[fill:4x5:3,8:#f5e9d0" ..
                    "^[fill:4x5:9,8:#f5e9d0^[fill:4x5:6,4:#f5e9d0" },
        { suffix = "muster_schuppen", name = "Schuppen-Block",
          texture = "[fill:16x16:#2e8b57^[fill:3x3:1,1:#82e0aa^[fill:3x3:7,1:#82e0aa" ..
                    "^[fill:3x3:13,1:#82e0aa^[fill:3x3:4,5:#82e0aa^[fill:3x3:10,5:#82e0aa" ..
                    "^[fill:3x3:1,9:#82e0aa^[fill:3x3:7,9:#82e0aa^[fill:3x3:13,9:#82e0aa" },
        { suffix = "muster_blatt", name = "Farn-Block",
          texture = "[fill:16x16:#1e8449^[fill:2x12:7,2:#145a32" ..
                    "^[fill:6x2:2,4:#27ae60^[fill:6x2:8,4:#27ae60" ..
                    "^[fill:6x2:2,8:#27ae60^[fill:6x2:8,8:#27ae60" },
        { suffix = "muster_lava", name = "Lava-Block",
          texture = "[fill:16x16:#641e16^[fill:6x3:2,3:#e67e22" ..
                    "^[fill:5x3:9,7:#e67e22^[fill:4x3:3,11:#f1c40f" },
        { suffix = "muster_schach", name = "Schachbrett-Block",
          texture = "[fill:16x16:#e4c690^[fill:8x8:0,0:#5d4037^[fill:8x8:8,8:#5d4037" },

        -- Per-face block: a real research crate (lid on top, wood on the sides).
        { suffix = "forscherkiste", name = "Forscher-Kiste",
          top    = "[fill:16x16:#8d6e3a^[fill:16x2:0,0:#27ae60^[fill:16x2:0,14:#27ae60^[fill:2x2:7,7:#4a2f15",
          side   = "[fill:16x16:#8d6e3a^[fill:16x3:0,6:#27ae60^[fill:4x5:6,6:#4a2f15",
          bottom = "[fill:16x16:#6e552c" },

        -- Eigenes gemaltes Bild als Block? Lege eine PNG (16x16 oder 32x32)
        -- "lernwelt_saurier_meinbild.png" in den textures/-Ordner und entferne
        -- die zwei Minuszeichen vor der naechsten Zeile:
        -- { suffix = "meinbild", name = "Mein Bild", texture = "lernwelt_saurier_meinbild.png" },
    },

    -- --- 3) Learning zones (each gets a placeable learning board) ---
    -- Zone titles double as the "habitat" shown in the logbook.
    zones = {
        {
            id = "tal", title = "Tal", color = "#27ae60",
            activity = "Dinos beobachten, ihre Namen lernen und nach Groesse " ..
                       "vergleichen (klein - mittel - gross).",
            lehrplan = { "NMG.2", "MA.3", "D.2" },
            tasks = {
                { type = "quiz", question = "Welcher Dino hat einen ganz langen Hals?",
                  options = { "Brachiosaurus", "Triceratops", "Stegosaurus" }, answer = 1,
                  done = "Richtig! Der Brachiosaurus hat einen sehr langen Hals." },
                { type = "quiz", question = "Wer ist groesser?",
                  options = { "Brachiosaurus", "Microceratus" }, answer = 1,
                  done = "Genau! Der Brachiosaurus ist riesig, der Microceratus winzig." },
                { type = "pattern",
                  sequence = { "#f9e79f", "#f0b27a", "#ca6f1e" },
                  palette  = { { "#f9e79f", "Klein" }, { "#f0b27a", "Mittel" }, { "#ca6f1e", "Gross" } },
                  done = "Super! Von klein nach gross geordnet." },
                { type = "rescue", creature = "triceratops", count = 2,
                  done = "Stark! Zwei Triceratops begruesst und erforscht." },
            },
        },
        {
            id = "grabung", title = "Fossilien-Grabungsstaette", color = "#ca6f1e",
            activity = "Im Sand nach Fossilien GRABEN (abbauen), die Funde " ..
                       "zaehlen und die Dinos klassifizieren (Pflanzenfresser?).",
            lehrplan = { "NMG.8", "MA.1", "NMG.2" },
            tasks = {
                { type = "quiz", question = "Was findest du beim Ausgraben im Sand?",
                  options = { "Knochen und Zaehne", "Autos", "Handys" }, answer = 1,
                  done = "Richtig! Im Sand stecken Knochen, Zaehne und Eier-Fossilien." },
                { type = "quiz", question = "Frisst ein Triceratops Pflanzen oder Fleisch?",
                  options = { "Pflanzen", "Fleisch" }, answer = 1,
                  done = "Richtig! Der Triceratops ist ein Pflanzenfresser." },
                { type = "quiz", question = "Wie viele Hoerner hat ein Triceratops?",
                  options = { "3", "1", "7" }, answer = 1,
                  done = "Richtig! 'Tri' heisst drei - drei Hoerner." },
                { type = "rescue", creature = "protoceratops", count = 2,
                  done = "Klasse! Zwei Protoceratops in der Grube erforscht." },
            },
        },
        {
            id = "nistplatz", title = "Nistplatz", color = "#e67e22",
            activity = "Dino-Nester entdecken, Eier zaehlen, Dino-Familien " ..
                       "zusammenbringen und Eier ausbrueten.",
            lehrplan = { "MA.1", "NMG.2", "MA.3" },
            tasks = {
                { type = "quiz", question = "Wie kommen kleine Dinos auf die Welt?",
                  options = { "Sie schluepfen aus dem Ei", "Sie fallen vom Baum", "Aus dem Wasser" },
                  answer = 1, done = "Richtig! Dinos schluepfen aus Eiern." },
                { type = "quiz", question = "Im Nest liegen 3 Eier. Wie viele sind das?",
                  options = { "3", "2", "5" }, answer = 1,
                  done = "Richtig gezaehlt! Es sind 3 Eier." },
                { type = "rescue", creature = "maiasaura", count = 1,
                  done = "Toll! Die Maiasaura ist wieder bei ihren Kleinen." },
                { type = "pattern",
                  sequence = { "#f5e9d0", "#cd6155", "#f5e9d0" },
                  palette  = { { "#f5e9d0", "Ei" }, { "#cd6155", "Mama" }, { "#27ae60", "Blatt" } },
                  done = "Super! Muster Ei-Mama-Ei gelegt." },
            },
        },
    },

    -- --- 4) Friendly dinosaurs (peaceful; right-click = greet/study) ---
    creatures = {
        -- Tal (valley) - the big, gentle plant-eaters
        {
            id = "brachiosaurus", name = "Brachiosaurus", zone = "tal",
            color = "#87a96b", size = 2.4, speed = 0.5,
            food = "Blaetter aus Baumkronen", power = "Sehr langer Hals",
            heart = "#d4e6b5",
            rescue_text = "Erforscht! Der Brachiosaurus reckt seinen langen Hals und trompetet.",
        },
        {
            id = "diplodocus", name = "Diplodocus", zone = "tal",
            color = "#6b8e23", size = 2.2, speed = 0.5, family = 1,
            food = "Farne und Blaetter", power = "Langer Peitschen-Schwanz",
            heart = "#c8d6a0",
            rescue_text = "Erforscht! Der Diplodocus schwingt langsam seinen langen Schwanz.",
        },
        {
            id = "triceratops", name = "Triceratops", zone = "tal",
            color = "#a0522d", size = 1.4, speed = 0.9,
            food = "niedrige Pflanzen", power = "Drei Hoerner und ein Nackenschild",
            heart = "#e6b89c",
            rescue_text = "Erforscht! Der Triceratops senkt freundlich seine drei Hoerner.",
        },
        {
            id = "stegosaurus", name = "Stegosaurus", zone = "tal",
            color = "#8a9a5b", size = 1.3, speed = 0.7,
            food = "weiche Pflanzen", power = "Knochenplatten auf dem Ruecken",
            heart = "#c5d199",
            rescue_text = "Erforscht! Die Platten des Stegosaurus schimmern in der Sonne.",
        },
        {
            id = "parasaurolophus", name = "Parasaurolophus", zone = "tal",
            color = "#48a9a6", size = 1.2, speed = 1.0,
            food = "Blaetter und Zweige", power = "Trompeten-Kamm am Kopf",
            heart = "#a9dfdd",
            rescue_text = "Erforscht! Der Parasaurolophus troetet mit seinem Kopf-Kamm. Tuuut!",
        },
        {
            id = "ankylosaurus", name = "Ankylosaurus", zone = "tal",
            color = "#707b7c", size = 1.2, speed = 0.6,
            food = "Bodenpflanzen", power = "Panzer und Schwanz-Keule",
            heart = "#b2babb",
            rescue_text = "Erforscht! Der Ankylosaurus wackelt mit seiner Schwanz-Keule.",
        },
        {
            id = "iguanodon", name = "Iguanodon", zone = "tal",
            color = "#9aac6b", size = 1.3, speed = 1.0,
            food = "Pflanzen aller Art", power = "Daumen-Stachel an der Hand",
            heart = "#cfd9a8",
            rescue_text = "Erforscht! Der Iguanodon hebt freundlich seinen Daumen-Stachel.",
        },

        -- Fossilien-Grabungsstaette (dig site) - smaller dinos near the sand
        {
            id = "pachycephalosaurus", name = "Pachycephalosaurus", zone = "grabung",
            color = "#c08552", size = 1.1, speed = 1.1,
            food = "Blaetter und Beeren", power = "Dicker Knochen-Schaedel",
            heart = "#e2c4a0",
            rescue_text = "Erforscht! Der Pachycephalosaurus nickt mit seinem dicken Kopf.",
        },
        {
            id = "protoceratops", name = "Protoceratops", zone = "grabung",
            color = "#d2b48c", size = 0.7, speed = 0.9, family = 1,
            food = "Wuestenpflanzen", power = "Kleines Nackenschild",
            heart = "#ecd9bb",
            rescue_text = "Erforscht! Der Protoceratops trippelt durch den Sand.",
        },
        {
            id = "microceratus", name = "Microceratus", zone = "grabung",
            color = "#f0c987", size = 0.5, speed = 1.3,
            food = "kleine Pflanzen", power = "Winzig und flink",
            heart = "#f8e3bf",
            rescue_text = "Erforscht! Der winzige Microceratus flitzt davon. Schwupp!",
        },

        -- Nistplatz (nesting place) - parents that bring their babies
        {
            id = "maiasaura", name = "Maiasaura", zone = "nistplatz",
            color = "#cd6155", size = 1.2, speed = 0.8, family = 2,
            food = "Beeren und Blaetter", power = "Fuersorgliche Dino-Mama",
            heart = "#f2a7a0",
            rescue_text = "Erforscht! Die Maiasaura ruft sanft nach ihren Jungen.",
        },
        {
            id = "apatosaurus", name = "Apatosaurus", zone = "nistplatz",
            color = "#5499c7", size = 2.2, speed = 0.5, family = 1,
            food = "Baumblaetter", power = "Riesig und sanft",
            heart = "#aed1ea",
            rescue_text = "Erforscht! Der Apatosaurus stampft gemuetlich zu seinem Nest.",
        },
        {
            id = "hadrosaurus", name = "Hadrosaurus", zone = "nistplatz",
            color = "#af7ac5", size = 1.3, speed = 0.9, family = 1,
            food = "Blaetter und Zapfen", power = "Enten-Schnabel zum Mahlen",
            heart = "#d7bce3",
            rescue_text = "Erforscht! Der Hadrosaurus schmatzt zufrieden mit seinem Schnabel.",
        },
        {
            -- legendary, rare: never auto-spawns (egg/manual only)
            id = "regenbogensaurier", name = "Regenbogen-Saurier", zone = "tal",
            color = "#f1c40f", size = 2.0, speed = 0.7, glow = 8, rare = true,
            food = "Sonnenlicht und Bluetenstaub", power = "Sehr selten und magisch",
            heart = "#fff2a8",
            rescue_text = "Der legendaere Regenbogen-Saurier schenkt dir ein buntes Leuchten!",
        },
    },

    -- --- 5) Ranks (3rd field = colour -> creates a badge item) ---
    ranks = {
        { 0,  "Frischling" },
        { 5,  "Nachwuchs-Forscher" },
        { 10, "Junior-Palaeontologe", "#3498db" },
        { 25, "Saurier-Experte",      "#27ae60" },
        { 50, "Chef-Palaeontologe",   "#f1c40f" },
    },

    -- --- 6) Logbook item ---
    logbook = { title = "Forscher-Logbuch", item_color = "#27ae60" },

    -- --- 7) Plain texts for curriculum codes (for /lernplan & boards) ---
    kompetenzen = {
        ["NMG.2"] = "Tiere und ihre Lebensraeume erkunden (Saurier)",
        ["NMG.8"] = "Wie Forscher die Vergangenheit erkunden (Fossilien)",
        ["MA.1"]  = "Mengen erfassen und zaehlen (Eier, Fossilien)",
        ["MA.2"]  = "Muster und Reihen ordnen",
        ["MA.3"]  = "Groessen vergleichen und ordnen (klein - mittel - gross)",
        ["D.2"]   = "Saurier benennen und beschreiben",
        ["BS.2"]  = "Sich geschickt bewegen (graben, klettern)",
        ["BG.1"]  = "Farben und Muster gestalten",
    },
})

-- ============================================================
--  THEME EXTRAS  (self-contained Lua the engine cannot express)
-- ============================================================

-- ------------------------------------------------------------
--  B) EXTRA: FORSCHER-JEEP  (drivable ground vehicle)
--  Not part of the engine - a self-contained vehicle the theme
--  adds on its own. A sturdy expedition jeep that rolls over the
--  ground. Lives in the same "lernwelt_saurier:" namespace.
--  Controls: place -> right-click to board -> W/S drive, A/D
--  steer, jump = small hop, right-click = exit. A second player
--  (parent + child) can ride along.
-- ------------------------------------------------------------
local JEEP_SPEED = 6

core.register_entity(L("jeep"), {
    initial_properties = {
        physical = true, collide_with_objects = true,
        collisionbox = { -0.6, -0.4, -0.6, 0.6, 0.4, 0.6 },
        visual = "cube", visual_size = { x = 1.3, y = 0.8, z = 1.6 },
        textures = {
            "[fill:16x16:#7d6608", "[fill:16x16:#5d4037",
            "[fill:16x16:#6e7f1c", "[fill:16x16:#6e7f1c",
            "[fill:16x16:#9aac6b", "[fill:16x16:#6e7f1c",
        },
    },
    _driver = nil, _passenger = nil, _dust = 0,

    on_rightclick = function(self, clicker)
        if not (clicker and clicker:is_player()) then return end
        local name = clicker:get_player_name()
        if self._driver == name then
            clicker:set_detach()
            clicker:set_eye_offset({ x = 0, y = 0, z = 0 }, { x = 0, y = 0, z = 0 })
            self._driver = nil
            core.chat_send_player(name, "Du steigst aus dem Forscher-Jeep aus.")
        elseif self._passenger == name then
            clicker:set_detach()
            clicker:set_eye_offset({ x = 0, y = 0, z = 0 }, { x = 0, y = 0, z = 0 })
            self._passenger = nil
            core.chat_send_player(name, "Du steigst als Mitfahrer aus.")
        elseif not self._driver then
            clicker:set_attach(self.object, "", { x = 0, y = 5, z = 0 }, { x = 0, y = 0, z = 0 })
            self._driver = name
            core.chat_send_player(name,
                "Forscher-Jeep gestartet! W/S fahren, A/D lenken, Springen = kleiner Hops, " ..
                "Rechtsklick = aussteigen. (Ein zweiter Spieler kann mitfahren!)")
        elseif not self._passenger then
            clicker:set_attach(self.object, "", { x = -5, y = 5, z = 0 }, { x = 0, y = 0, z = 0 })
            self._passenger = name
            core.chat_send_player(name, "Du faehrst als Mitfahrer mit! Rechtsklick = aussteigen.")
        end
    end,

    on_step = function(self, dtime)
        -- gravity keeps the jeep on the ground (it is no aircraft)
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
        local fwd = (ctrl.up and JEEP_SPEED) or (ctrl.down and -JEEP_SPEED * 0.5) or 0
        local v   = self.object:get_velocity()
        local vy  = v and v.y or 0
        if ctrl.jump and math.abs(vy) < 0.1 then vy = 4 end   -- a small hop
        self.object:set_velocity({ x = dir.x * fwd, y = vy, z = dir.z * fwd })

        -- a little dust cloud while driving
        if fwd ~= 0 then
            self._dust = (self._dust or 0) + dtime
            if self._dust > 0.2 then
                self._dust = 0
                local p = self.object:get_pos()
                core.add_particlespawner({
                    amount = 6, time = 0.2,
                    minpos = vector.subtract(p, 0.5), maxpos = vector.add(p, 0.5),
                    minvel = { x = -0.4, y = 0.3, z = -0.4 },
                    maxvel = { x = 0.4,  y = 1.0, z = 0.4 },
                    minexptime = 0.4, maxexptime = 0.9, minsize = 1, maxsize = 2,
                    texture = "[fill:8x8:#d7c79a",
                })
            end
        end
    end,
})

core.register_craftitem(L("jeep"), {
    description     = "Forscher-Jeep (Fahrzeug)\nPlatzieren, dann Rechtsklick zum Einsteigen",
    inventory_image = "[fill:16x16:#6e7f1c^[fill:12x4:2,9:#5d4037^[fill:4x4:2,3:#9aac6b",
    on_place = function(itemstack, placer, pointed_thing)
        if pointed_thing.type ~= "node" or not (placer and placer:is_player()) then
            return itemstack
        end
        local pos = pointed_thing.above
        pos.y = pos.y + 0.5
        core.add_entity(pos, L("jeep"))
        if not core.is_creative_enabled(placer:get_player_name()) then
            itemstack:take_item()
        end
        return itemstack
    end,
})

-- ------------------------------------------------------------
--  E) EXTRA: AUSGRABEN  (dig-for-fossils mini-game, the heart)
--  Fossils are small finds hidden in special "Grabungssand"
--  blocks. You DIG (break) the sand; each Grabungssand block
--  yields a random fossil into your inventory and counts up a
--  personal "Fossilien" counter with milestones. Scatter a dig
--  field with "/saurier_grabung" (priv: server) or via the test
--  station. Fits the motto: "Entdecken" and NMG.8 / MA.1.
--  Defined BEFORE the starter kit so the items already exist.
-- ------------------------------------------------------------
local FOSSILS = {
    { suffix = "knochen", name = "Dino-Knochen (Fossil)",
      image = "[fill:16x16:#e4c690^[fill:9x3:4,7:#f5f5f5^[fill:3x3:3,5:#f5f5f5" ..
              "^[fill:3x3:3,8:#f5f5f5^[fill:3x3:10,5:#f5f5f5^[fill:3x3:10,8:#f5f5f5" },
    { suffix = "dino_zahn", name = "Dino-Zahn (Fossil)",
      image = "[fill:16x16:#e4c690^[fill:4x9:6,3:#fdfdfd^[fill:2x3:6,11:#d5d5d5" },
    { suffix = "ammonit", name = "Ammonit (Fossil)",
      image = "[fill:16x16:#e4c690^[fill:8x8:4,4:#8d6e3a^[fill:4x4:6,6:#5d4037^[fill:2x2:7,7:#e4c690" },
    { suffix = "ei_fossil", name = "Versteinertes Ei (Fossil)",
      image = "[fill:16x16:#e4c690^[fill:6x8:5,4:#cdb892^[fill:2x2:6,6:#8d6e3a^[fill:2x2:8,9:#8d6e3a" },
}

local FOSSIL_MILESTONES = {
    [5]  = "Fossilien-Sammler",
    [15] = "Junior-Palaeontologe",
    [30] = "Saurier-Forscher",
}

for _, f in ipairs(FOSSILS) do
    core.register_craftitem(L(f.suffix), {
        description     = f.name,
        inventory_image = f.image,
    })
end

local function find_fossil(player)
    if not (player and player:is_player()) then return end
    local meta = player:get_meta()
    local n = meta:get_int("lernwelt_saurier:fossilien") + 1
    meta:set_int("lernwelt_saurier:fossilien", n)
    local name = player:get_player_name()
    local fossil = FOSSILS[math.random(#FOSSILS)]
    local inv = player:get_inventory()
    if inv then inv:add_item("main", L(fossil.suffix)) end
    core.sound_play("lernwelt_rescue", { to_player = name, gain = 0.8 })
    core.chat_send_player(name, "Fund! Du hast ein Fossil ausgegraben: " ..
        fossil.name .. ". Gefundene Fossilien: " .. n .. ".")
    local title = FOSSIL_MILESTONES[n]
    if title then
        core.sound_play("lernwelt_rankup", { to_player = name, gain = 1.0 })
        core.chat_send_player(name, "Toll gegraben! Du bist jetzt: " .. title .. "!")
    end
end

-- Grabungssand: looks like ordinary sand (so you have to SEARCH by
-- digging) but a fossil is hidden inside. A faint speck hints at it.
core.register_node(L("grabungssand"), {
    description = "Grabungssand\nAbbauen (graben) = im Sand nach Fossilien suchen",
    tiles = { "[fill:16x16:#f4e3c1^[fill:2x2:11,4:#c9a96a^[fill:2x2:5,10:#c9a96a" },
    groups = { crumbly = 3, oddly_breakable_by_hand = 3, falling_node = 0 },
    sounds = nil,
    is_ground_content = false,
    drop = "",
    after_dig_node = function(pos, oldnode, oldmeta, digger)
        find_fossil(digger)
    end,
})

-- nodes the dig-field command may build on / replace
local DIG_SPACE = {
    ["air"] = true,
    ["default:sand"] = true, ["default:desert_sand"] = true,
    ["default:dirt"] = true, ["default:dirt_with_grass"] = true,
    ["mcl_core:sand"] = true, ["mcl_core:redsand"] = true,
    ["mcl_core:dirt"] = true, ["mcl_core:dirt_with_grass"] = true,
}

core.register_chatcommand("saurier_grabung", {
    description = "Legt eine Fossilien-Grabungsstaette vor dir an " ..
                  "(Sandfeld mit versteckten Fossilien zum Ausgraben)",
    privs = { server = true },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then return false, "Dieser Befehl funktioniert nur im Spiel." end
        local base   = vector.round(player:get_pos())
        local fy     = base.y - 1
        local sand   = L("wuestensand")
        local placed = 0
        -- a 7 x 5 sand patch in front of you (z: +2..+6)
        for dx = -3, 3 do
            for dz = 2, 6 do
                local p    = { x = base.x + dx, y = fy, z = base.z + dz }
                local here = core.get_node(p).name
                if DIG_SPACE[here] or core.registered_nodes[here] then
                    -- ~30% of the field hides a fossil (Grabungssand)
                    if math.random() < 0.3 then
                        core.set_node(p, { name = L("grabungssand") })
                        placed = placed + 1
                    else
                        core.set_node(p, { name = sand })
                    end
                end
            end
        end
        if placed == 0 then placed = 1 end  -- always something to find
        return true, "Grabungsstaette angelegt! Grabe (abbauen) im Sandfeld vor dir - " ..
                     "in einigen Sandbloecken stecken Fossilien. Etwa " .. placed ..
                     " Funde warten auf dich."
    end,
})

-- ------------------------------------------------------------
--  C) EXTRA: STARTER KIT  (handed out once on first join)
--  Makes the world testable right away: the logbook, the camera,
--  the jeep, a stack of each building block, an egg-to-hatch and
--  one spawn egg per dino (the engine registers the eggs when a
--  mob API is present; missing items are simply skipped).
--  Turn off via the setting "lernwelt_saurier_starter_kit".
-- ------------------------------------------------------------
local STARTER_BLOCKS = {
    "fels", "sandstein", "wuestensand", "blattwerk",
    "vulkangestein", "bernstein", "stationsglas",
}
-- Spawn-egg item names match the creature ids (world_id:creature_id)
local STARTER_EGGS = {
    "brachiosaurus", "diplodocus", "triceratops", "stegosaurus",
    "parasaurolophus", "ankylosaurus", "iguanodon",
    "pachycephalosaurus", "protoceratops", "microceratus",
    "maiasaura", "apatosaurus", "hadrosaurus", "regenbogensaurier",
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
    give_if_exists(inv, L("jeep"))
    give_if_exists(inv, L("dino_ei") .. " 3")
    give_if_exists(inv, L("grabungssand") .. " 10")
    for _, suffix in ipairs(STARTER_BLOCKS) do
        give_if_exists(inv, L(suffix) .. " 10")
    end
    for _, cid in ipairs(STARTER_EGGS) do
        give_if_exists(inv, L(cid))
    end
    core.chat_send_player(player:get_player_name(),
        "Saurier-Forscher: Startausruestung erhalten - Logbuch, Kamera, Forscher-Jeep, " ..
        "Dino-Eier, Grabungssand, Bau-Bloecke und Spawn-Eier sind in deinem Inventar. " ..
        "Viel Spass beim Forschen!")
end

core.register_on_joinplayer(function(player)
    if not core.settings:get_bool("lernwelt_saurier_starter_kit", true) then return end
    local meta = player:get_meta()
    if meta:get_int("lernwelt_saurier:starter_given") == 1 then return end
    meta:set_int("lernwelt_saurier:starter_given", 1)
    -- slight delay so the inventory exists and the message is seen
    core.after(1.5, function()
        if player and player:is_player() then give_starter_kit(player) end
    end)
end)

-- ------------------------------------------------------------
--  F) EXTRA: DINO-EI AUSBRUETEN  (hatch eggs at the Nistplatz)
--  Place a dino egg; after a while it hatches into a random
--  little dino. Each hatched dino adds to a personal "Kueken"
--  counter. Parallels a plant/grow loop and fits the Nistplatz.
-- ------------------------------------------------------------
local HATCHLINGS = {
    "triceratops", "stegosaurus", "parasaurolophus", "protoceratops",
    "microceratus", "maiasaura", "hadrosaurus", "pachycephalosaurus",
}
local HATCH_TIME = 25

core.register_node(L("dino_ei"), {
    description = "Dino-Ei\nSetzen - schluepft nach kurzer Zeit zu einem kleinen Dino",
    drawtype = "plantlike",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    floodable = false,
    tiles = { "[fill:16x16:#f5e9d0^[fill:8x11:4,3:#e8d3a8^[fill:3x3:6,6:#cdb892" },
    inventory_image = "[fill:16x16:#f5e9d0^[fill:8x11:4,3:#e8d3a8^[fill:3x3:6,6:#cdb892",
    selection_box = { type = "fixed", fixed = { -0.3, -0.5, -0.3, 0.3, 0.3, 0.3 } },
    groups = { dig_immediate = 3, oddly_breakable_by_hand = 3 },
    after_place_node = function(pos, placer)
        if placer and placer:is_player() then
            core.get_meta(pos):set_string("planter", placer:get_player_name())
        end
        core.get_node_timer(pos):start(HATCH_TIME)
    end,
    on_timer = function(pos)
        local planter = core.get_meta(pos):get_string("planter")
        core.set_node(pos, { name = "air" })
        -- a little hatch puff
        core.add_particlespawner({
            amount = 12, time = 0.3,
            minpos = vector.subtract(pos, 0.4), maxpos = vector.add(pos, 0.4),
            minvel = { x = -0.5, y = 0.5, z = -0.5 }, maxvel = { x = 0.5, y = 1.2, z = 0.5 },
            minexptime = 0.5, maxexptime = 1.0, minsize = 1, maxsize = 2,
            texture = "[fill:8x8:#f5e9d0",
        })
        if lernwelt.mobs.available() then
            local obj = core.add_entity(pos, L(HATCHLINGS[math.random(#HATCHLINGS)]))
            local le  = obj and obj:get_luaentity()
            if le then le._is_baby = true end
        end
        if planter ~= "" then
            local p = core.get_player_by_name(planter)
            if p then
                local meta = p:get_meta()
                local n = meta:get_int("lernwelt_saurier:kueken") + 1
                meta:set_int("lernwelt_saurier:kueken", n)
                core.sound_play("lernwelt_rescue", { to_player = planter, gain = 0.6 })
                core.chat_send_player(planter, "Ein kleiner Dino ist geschluepft! Schluepf-Zaehler: " .. n)
            end
        end
        return false
    end,
})

-- ------------------------------------------------------------
--  G) EXTRA: DINO LAND SPAWNER  (a living valley)
--  The engine's built-in spawner only places water animals, so
--  this small, backend-agnostic spawner brings the dinos to life:
--  every so often it tries to add one non-rare dino on solid
--  ground with air above, near a player, capped so the valley
--  never gets crowded. Turn off with "lernwelt_spawn_creatures".
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
            local dist = 9 + math.random(0, 14)
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
--  D) EXTRA: TEST STATION  (chat command for quick setup)
--  "/saurier_teststation" builds a small ready-made station in
--  front of you: a sand floor, the three learning boards, a
--  Forscher-Jeep and a little dig field. Handy for testing or for
--  an adult to prepare the world. It overwrites the nodes where
--  it builds, so it needs the "server" privilege.
-- ------------------------------------------------------------
local STATION_BOARDS = {
    L("tafel_tal"),
    L("tafel_grabung"),
    L("tafel_nistplatz"),
}

local function build_test_station(player)
    local base    = vector.round(player:get_pos())
    local floor_y = base.y - 1
    local floor   = L("sandstein")

    -- 7 wide (x: -3..3) x 5 deep (z: +2..+6) floor in front of you
    for dx = -3, 3 do
        for dz = 2, 6 do
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

    -- a Forscher-Jeep ready to board
    core.add_entity({ x = base.x, y = floor_y + 1.5, z = base.z + 6 }, L("jeep"))

    -- a small dig field with hidden fossils on the right
    for dx = 2, 3 do
        for dz = 4, 6 do
            local r = (math.random() < 0.4) and L("grabungssand") or L("wuestensand")
            core.set_node({ x = base.x + dx, y = floor_y + 1, z = base.z + dz }, { name = r })
        end
    end
end

core.register_chatcommand("saurier_teststation", {
    description = "Baut eine kleine Saurier-Test-Station vor dir " ..
                  "(Boden, 3 Lern-Tafeln, Forscher-Jeep, kleines Grabungsfeld)",
    privs = { server = true },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then
            return false, "Dieser Befehl funktioniert nur im Spiel."
        end
        build_test_station(player)
        return true, "Test-Station gebaut! Sie steht vor dir Richtung Norden " ..
                     "(+Z): Boden, drei Lern-Tafeln, ein Forscher-Jeep und ein " ..
                     "kleines Grabungsfeld zum Ausgraben."
    end,
})

-- ------------------------------------------------------------
--  H) EXTRA: GROSSE FORSCHERSTATION  (chat command)
--  "/saurier_forscherstation" builds a bigger glass-domed station
--  in front of you: a sandstone floor, a glass shell with a
--  doorway, the three learning boards, a Forscher-Jeep and a dig
--  field. Priv: server.
-- ------------------------------------------------------------
core.register_chatcommand("saurier_forscherstation", {
    description = "Baut eine groessere Forscherstation vor dir " ..
                  "(Glaskuppel, Tafeln, Forscher-Jeep, Grabungsfeld)",
    privs = { server = true },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then return false, "Dieser Befehl funktioniert nur im Spiel." end
        local b     = vector.round(player:get_pos())
        local glass = L("stationsglas")
        local floor = L("sandstein")
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
        local boards = { "tafel_tal", "tafel_grabung", "tafel_nistplatz" }
        local xs = { -3, 0, 3 }
        for i, bd in ipairs(boards) do
            local nn = L(bd)
            if core.registered_nodes[nn] then
                core.set_node({ x = b.x + xs[i], y = fy + 1, z = z0 + 1 }, { name = nn, param2 = 2 })
            end
        end
        core.add_entity({ x = b.x, y = fy + 1.5, z = z0 + R }, L("jeep"))
        -- a dig field inside the dome
        for dx = -2, 2 do
            for dz = 2 * R - 2, 2 * R - 1 do
                local r = (math.random() < 0.35) and L("grabungssand") or L("wuestensand")
                core.set_node({ x = b.x + dx, y = fy + 1, z = z0 + dz }, { name = r })
            end
        end
        return true, "Forscherstation gebaut! Glaskuppel mit Tuer, drei Tafeln, " ..
                     "Forscher-Jeep und ein Grabungsfeld zum Ausgraben."
    end,
})

-- ------------------------------------------------------------
--  K) EXTRA: GROESSEN-PARADE  (line up dinos klein -> gross)
--  "/saurier_groessen" spawns a row of dinos in front of you,
--  sorted from smallest to largest - a hands-on size comparison
--  (MA.3 / Groessen). Needs a mob API and the "server" priv.
-- ------------------------------------------------------------
core.register_chatcommand("saurier_groessen", {
    description = "Stellt einige Dinos der Reihe nach von klein nach gross vor dir auf " ..
                  "(Groessenvergleich)",
    privs = { server = true },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then return false, "Dieser Befehl funktioniert nur im Spiel." end
        if not lernwelt.mobs.available() then
            return false, "Dafuer wird eine Mob-API gebraucht (z. B. VoxeLibre/Mineclonia)."
        end
        local world = lernwelt.worlds[WORLD_ID]
        local row = {}
        for _, c in ipairs((world or {}).creatures or {}) do
            if not c.rare then row[#row + 1] = c end
        end
        table.sort(row, function(a, b) return (a.size or 1) < (b.size or 1) end)
        local b  = vector.round(player:get_pos())
        local fy = b.y
        local x  = b.x - math.floor(#row / 2) * 2
        for _, c in ipairs(row) do
            core.add_entity({ x = x, y = fy, z = b.z + 4 }, L(c.id))
            x = x + 2
        end
        return true, "Groessen-Parade aufgestellt: die Dinos stehen von KLEIN (links) " ..
                     "nach GROSS (rechts). Vergleiche sie!"
    end,
})

-- ------------------------------------------------------------
--  I) EXTRA: AMBIENT-SOUND  (distant dino calls)
--  Plays a gentle dino call to each player now and then. The
--  .ogg files are optional (missing = silent, only a warning).
-- ------------------------------------------------------------
local amb_timer, amb_next = 0, 45
core.register_globalstep(function(dtime)
    amb_timer = amb_timer + dtime
    if amb_timer < amb_next then return end
    amb_timer = 0
    amb_next = 35 + math.random(0, 40)
    for _, player in ipairs(core.get_connected_players()) do
        local snd = (math.random() < 0.5) and "_ruf" or "_ambient"
        core.sound_play(WORLD_ID .. snd, { to_player = player:get_player_name(), gain = 0.4 })
    end
end)

-- ------------------------------------------------------------
--  J) EXTRA: BUCHSTABEN-BLOECKE (A-Z) + ZAHLEN-BLOECKE (0-9)
--  A tiny 5x7 pixel font rendered into each block's texture with
--  layered "[fill" - no image files. Nice for "Deutsch / benennen"
--  (lay out DINO NAMES) and for "Mathematik / zaehlen" (lay out
--  how many eggs or fossils you found). For Umlauts use AE/OE/UE.
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

local DIGITS = {
    ["0"] = { ".###.", "#...#", "#..##", "#.#.#", "##..#", "#...#", ".###." },
    ["1"] = { "..#..", ".##..", "..#..", "..#..", "..#..", "..#..", ".###." },
    ["2"] = { ".###.", "#...#", "....#", "...#.", "..#..", ".#...", "#####" },
    ["3"] = { "#####", "...#.", "..#..", "...#.", "....#", "#...#", ".###." },
    ["4"] = { "...#.", "..##.", ".#.#.", "#..#.", "#####", "...#.", "...#." },
    ["5"] = { "#####", "#....", "####.", "....#", "....#", "#...#", ".###." },
    ["6"] = { ".###.", "#....", "#....", "####.", "#...#", "#...#", ".###." },
    ["7"] = { "#####", "....#", "...#.", "..#..", ".#...", ".#...", ".#..." },
    ["8"] = { ".###.", "#...#", "#...#", ".###.", "#...#", "#...#", ".###." },
    ["9"] = { ".###.", "#...#", "#...#", ".####", "....#", "....#", ".###." },
}

local function glyph_texture(rows, bg, fg)
    local t = { "[fill:16x16:" .. bg }
    for r = 1, #rows do
        local row = rows[r]
        for c = 1, #row do
            if row:sub(c, c) == "#" then
                t[#t + 1] = ("^[fill:2x2:%d,%d:%s"):format(3 + (c - 1) * 2, 1 + (r - 1) * 2, fg)
            end
        end
    end
    return table.concat(t)
end

for letter, rows in pairs(FONT5x7) do
    core.register_node(L("buchstabe_" .. letter:lower()), {
        description = "Buchstabe " .. letter,
        tiles = { glyph_texture(rows, "#f4e3c1", "#5d4037") },
        groups = { cracky = 3, oddly_breakable_by_hand = 2 },
        is_ground_content = false,
    })
end

for digit, rows in pairs(DIGITS) do
    core.register_node(L("zahl_" .. digit), {
        description = "Zahl " .. digit,
        tiles = { glyph_texture(rows, "#e8d3a8", "#27ae60") },
        groups = { cracky = 3, oddly_breakable_by_hand = 2 },
        is_ground_content = false,
    })
end

core.log("action", "[lernwelt_saurier] Theme 'Saurier-Forscher' registered (on lernwelt engine).")
