-- ============================================================
--  THEME:  HIMMELSDORF  (Wolkenstadt / sky village)
--  A brand-free SKY learning world built ON TOP of the reusable
--  "lernwelt" engine. Almost everything below is one declarative
--  register_world{...} call - blocks, learning zones, rescuable
--  sky animals, logbook, ranks and badges all come from the engine.
--
--  The theme's heart is THE SKY: rainbow colours, the weather and
--  spatial orientation (oben/unten - up/down). The base is a
--  Schwebeinsel (floating island) and the world has three zones:
--  a Regenbogenbruecke (rainbow bridge), the Wolkenfelder (cloud
--  fields) and a Ballonhafen (balloon harbour).
--  (Lehrplan 21: NMG Wetter & Raumorientierung.)
--
--  Things the engine cannot express live as small pieces of
--  custom code after register_world:
--    B) a drivable "Heissluftballon" (a real flying vehicle -> Flug-Physik)
--    C) the "Regenbogen" block (cycles through the seven rainbow colours)
--    D) a first-join starter kit (quick testing)
--    E) a "Wetter-Station" (sun -> clouds -> rain -> storm -> rainbow)
--    F) "Regenbogen pflanzen" (a seed that grows into a colour block)
--    G) a sky spawner so the cloud animals come alive
--    H) a "Hoehenmesser" (altimeter -> oben/unten, Raumorientierung)
--    I) base commands (Schwebeinsel, Wolkenstadt, test station)
--    ...plus ambient sound and letter blocks.
--
--  The mod name equals the world id ("lernwelt_himmelsdorf"), so all
--  nodes/items live in the "lernwelt_himmelsdorf:" namespace.
--
--  Content is authored in German (ASCII: ae/oe/ue), like the other
--  example themes. The engine's own UI is translated separately via
--  lernwelt/locale/*.tr.
-- ============================================================

local WORLD_ID = "lernwelt_himmelsdorf"
local function L(suffix) return WORLD_ID .. ":" .. suffix end

-- The seven rainbow colours (id, German name, hex). Used for the
-- rainbow blocks, the cycling "Regenbogen" block and the seed.
local RAINBOW = {
    { "rot",     "Rot",     "#e74c3c" },
    { "orange",  "Orange",  "#e67e22" },
    { "gelb",    "Gelb",    "#f1c40f" },
    { "gruen",   "Gruen",   "#2ecc71" },
    { "blau",    "Blau",    "#3498db" },
    { "indigo",  "Indigo",  "#5d6dd6" },
    { "violett", "Violett", "#9b59b6" },
}

-- ------------------------------------------------------------
--  BLOCK LIST  (built once, then handed to register_world)
--  Sky-, cloud- and rainbow-themed blocks, all procedural ([fill).
-- ------------------------------------------------------------
local blocks = {
    -- The cloud city's building material (soft white clouds you walk on).
    { suffix = "wolke", name = "Wolke",
      texture = "[fill:16x16:#eef7ff^[fill:6x4:2,8:#ffffff^[fill:5x4:9,9:#ffffff" ..
                "^[fill:4x3:5,4:#dbeafe" },
    { suffix = "wolke_glas", name = "Glaswolke (durchsichtig)", color = "#eaf6ff", glass = true },
    { suffix = "wolkenziegel", name = "Wolkenziegel",
      texture = "[fill:16x16:#eaf6ff^[fill:16x1:0,5:#cfe8f7^[fill:16x1:0,11:#cfe8f7" ..
                "^[fill:1x5:8,0:#cfe8f7^[fill:1x6:4,6:#cfe8f7^[fill:1x6:12,6:#cfe8f7" },

    -- The floating island's ground (grass on top, rock & roots below).
    { suffix = "schwebeland", name = "Schwebeland (Inselboden)",
      top    = "[fill:16x16:#7dcea0^[fill:3x3:2,3:#58d68d^[fill:3x3:9,7:#58d68d^[fill:2x2:12,2:#58d68d",
      side   = "[fill:16x16:#8d6e3a^[fill:16x4:0,0:#7dcea0^[fill:3x4:4,9:#6e552c^[fill:3x4:10,8:#6e552c",
      bottom = "[fill:16x16:#6e552c^[fill:2x5:4,11:#5b3a06^[fill:2x4:10,12:#5b3a06" },
    { suffix = "himmelsstein", name = "Himmelsstein",
      texture = "[fill:16x16:#d6dbdf^[fill:5x4:2,3:#c8ccd0^[fill:4x4:9,8:#c8ccd0^[fill:3x3:11,2:#c8ccd0" },

    -- A glowing sun, a glowing star and a soft cloud lamp (light & dark).
    { suffix = "sonnenblock", name = "Sonnenblock",
      texture = "[fill:16x16:#f9e79f^[fill:8x8:4,4:#f1c40f^[fill:4x4:6,6:#fff8dc" ..
                "^[fill:2x2:7,1:#f1c40f^[fill:2x2:7,13:#f1c40f^[fill:2x2:1,7:#f1c40f^[fill:2x2:13,7:#f1c40f",
      glow = 14 },
    { suffix = "sternenblock", name = "Sternenblock",
      texture = "[fill:16x16:#2c3e50^[fill:2x10:7,3:#fff59d^[fill:10x2:3,7:#fff59d" ..
                "^[fill:2x2:5,5:#fff59d^[fill:2x2:9,5:#fff59d^[fill:2x2:5,9:#fff59d^[fill:2x2:9,9:#fff59d",
      glow = 12 },
    { suffix = "wolkenlampe", name = "Wolkenlampe",
      texture = "[fill:16x16:#fdfefe^[fill:8x8:4,4:#fcf3cf^[fill:4x4:6,6:#f9e79f",
      glow = 11 },

    -- RAINBOW PATTERNS (the theme's art focus): build with them and
    -- copy them at the learning boards (Regenbogen-Muster nachlegen).
    { suffix = "muster_regenbogen", name = "Regenbogen-Muster",
      texture = "[fill:16x16:#e74c3c^[fill:16x2:0,2:#e67e22^[fill:16x2:0,4:#f1c40f" ..
                "^[fill:16x2:0,6:#2ecc71^[fill:16x2:0,8:#3498db^[fill:16x2:0,10:#5d6dd6" ..
                "^[fill:16x2:0,12:#9b59b6" },
    { suffix = "muster_wolke", name = "Wolken-Muster",
      texture = "[fill:16x16:#aed6f1^[fill:8x5:2,3:#ffffff^[fill:6x4:9,8:#ffffff^[fill:4x3:6,9:#ffffff" },
    { suffix = "muster_sonne", name = "Sonnen-Muster",
      texture = "[fill:16x16:#aed6f1^[fill:8x8:4,4:#f1c40f^[fill:2x2:1,7:#f1c40f" ..
                "^[fill:2x2:13,7:#f1c40f^[fill:2x2:7,1:#f1c40f^[fill:2x2:7,13:#f1c40f" },
    { suffix = "muster_stern", name = "Sternen-Muster",
      texture = "[fill:16x16:#2c3e50^[fill:2x10:7,3:#f7dc6f^[fill:10x2:3,7:#f7dc6f" ..
                "^[fill:2x2:3,3:#f7dc6f^[fill:2x2:11,11:#f7dc6f" },

    -- Per-face block: a real balloon basket (woven sides, open top).
    { suffix = "ballonkorb", name = "Ballonkorb",
      top    = "[fill:16x16:#b9770e^[fill:12x12:2,2:#7e5109^[fill:8x8:4,4:#5b3a06",
      side   = "[fill:16x16:#b9770e^[fill:16x2:0,4:#7e5109^[fill:16x2:0,10:#7e5109" ..
               "^[fill:2x16:4,0:#7e5109^[fill:2x16:10,0:#7e5109",
      bottom = "[fill:16x16:#5b3a06" },

    -- Eigenes gemaltes Bild als Block? Lege eine PNG (16x16 oder 32x32)
    -- "lernwelt_himmelsdorf_meinbild.png" in den textures/-Ordner und entferne
    -- die zwei Minuszeichen vor der naechsten Zeile:
    -- { suffix = "meinbild", name = "Mein Bild", texture = "lernwelt_himmelsdorf_meinbild.png" },
}

-- Append the seven solid rainbow blocks (one flat colour each).
for _, r in ipairs(RAINBOW) do
    blocks[#blocks + 1] = {
        suffix = "regenbogen_" .. r[1],
        name   = "Regenbogen-Block (" .. r[2] .. ")",
        color  = r[3],
    }
end

-- ------------------------------------------------------------
--  A) THE WHOLE LEARNING WORLD AS ONE DECLARATIVE TABLE
-- ------------------------------------------------------------
lernwelt.register_world({

    -- internal prefix; kept identical to the mod name so all
    -- nodes/items live in the "lernwelt_himmelsdorf:" namespace
    id    = WORLD_ID,
    title = "Himmelsdorf",

    -- --- 1) Peaceful, child-friendly world ---
    config = {
        damage      = false,   -- no damage / no falling deaths (we fly a lot!)
        creative    = true,    -- unlimited blocks
        peaceful    = true,    -- no monsters
        freeze_time = "day",   -- always a bright sky
        no_weather  = true,    -- the engine's weather off; the theme has its own (E)
    },

    -- --- 2) Sky, cloud & rainbow blocks (built above) ---
    blocks = blocks,

    -- --- 3) Learning zones (each gets a placeable learning board) ---
    -- Zone titles double as the "habitat" shown in the logbook.
    zones = {
        {
            id = "regenbogenbruecke", title = "Regenbogenbruecke", color = "#9b59b6",
            activity = "Lauf ueber die leuchtende Regenbogenbruecke und lerne die sieben " ..
                       "Regenbogenfarben in der richtigen Reihenfolge: Rot, Orange, Gelb, " ..
                       "Gruen, Blau, Indigo, Violett. Welche Farbe kommt nach welcher?",
            lehrplan = { "BG.1", "MA.3", "MA.2" },
            tasks = {
                { type = "quiz",
                  question = "Welche Farbe leuchtet im Regenbogen ganz oben (zuerst)?",
                  options = { "Rot", "Schwarz", "Braun" }, answer = 1,
                  done = "Richtig! Ganz oben im Regenbogen leuchtet Rot." },
                { type = "quiz",
                  question = "Wie viele Farben hat ein Regenbogen?",
                  options = { "Sieben", "Zwei", "Hundert" }, answer = 1,
                  done = "Genau! Ein Regenbogen hat sieben Farben." },
                { type = "pattern",
                  -- the start of the rainbow as a pattern to copy (MA.3 / BG.1)
                  sequence = { "#e74c3c", "#e67e22", "#f1c40f" },
                  palette  = { { "#e74c3c", "Rot" }, { "#e67e22", "Orange" },
                               { "#f1c40f", "Gelb" }, { "#3498db", "Blau" } },
                  done = "Super! Rot-Orange-Gelb gelegt - der Anfang des Regenbogens." },
                { type = "rescue", creature = "regenbogen_kolibri", count = 2,
                  done = "Stark! Zwei Regenbogen-Kolibris geholfen." },
            },
        },
        {
            id = "wolkenfelder", title = "Wolkenfelder", color = "#aed6f1",
            activity = "Auf den weichen Wolkenfeldern beobachtest du das Wetter (Sonne, " ..
                       "Wolken, Regen, Gewitter) und uebst oben und unten: Die Wolken " ..
                       "sind ueber uns, der Boden ist tief unter dir.",
            lehrplan = { "NMG.1", "NMG.2", "MA.2" },
            tasks = {
                { type = "quiz",
                  question = "Was faellt bei Regen vom Himmel?",
                  options = { "Wasser-Tropfen", "Steine", "Bonbons" }, answer = 1,
                  done = "Richtig! Bei Regen fallen Wasser-Tropfen vom Himmel." },
                { type = "quiz",
                  question = "Wo sind die Wolken?",
                  options = { "Ueber uns (oben)", "Tief unter der Erde", "Im Meer" },
                  answer = 1,
                  done = "Genau! Die Wolken sind oben, hoch ueber uns." },
                { type = "rescue", creature = "wolkenschaf", count = 2,
                  done = "Klasse! Zwei Wolkenschafen geholfen." },
            },
        },
        {
            id = "ballonhafen", title = "Ballonhafen", color = "#e67e22",
            activity = "Am Ballonhafen starten die Heissluftballons. Lerne, warum ein " ..
                       "Ballon fliegt (warme Luft steigt nach oben!) und finde dich in der " ..
                       "Hoehe zurecht: Was ist ueber dir, was unter dir?",
            lehrplan = { "NMG.3", "MA.2", "D.2" },
            tasks = {
                { type = "quiz",
                  question = "Warum steigt ein Heissluftballon nach oben?",
                  options = { "Warme Luft ist leichter und steigt", "Weil er bunt ist",
                              "Weil er sehr schwer ist" }, answer = 1,
                  done = "Richtig! Warme Luft ist leichter - darum steigt der Ballon." },
                { type = "quiz",
                  question = "Du fliegst sehr hoch. Der Boden ist dann ...?",
                  options = { "weit unter dir", "ueber dir", "neben dem Mond" }, answer = 1,
                  done = "Genau! Je hoeher du bist, desto tiefer ist der Boden unter dir." },
                { type = "rescue", creature = "sturmvogel", count = 2,
                  done = "Toll! Zwei Sturmvoegeln geholfen." },
            },
        },
    },

    -- --- 4) Rescuable sky animals (peaceful; right-click = help) ---
    --  Reusing the engine's gentle "rescue" loop: a right-click helps
    --  the animal, gives hearts, a sound, a counter entry and a rank.
    --  The cloud animals come alive via the theme's own sky spawner (G).
    creatures = {
        {
            id = "regenbogen_kolibri", name = "Regenbogen-Kolibri", zone = "regenbogenbruecke",
            color = "#e74c3c", size = 0.4, speed = 1.6, glow = 7,
            food = "Bluetennektar", power = "Schwirrt bunt durch die Luft",
            heart = "#ff8aa8",
            rescue_text = "Geholfen! Der Kolibri schwirrt bunt davon.",
        },
        {
            id = "sonnenfalter", name = "Sonnenfalter", zone = "regenbogenbruecke",
            color = "#f1c40f", size = 0.5, speed = 1.2,
            food = "Nektar", power = "Bunte Fluegel wie ein Falter",
            heart = "#fdebd0",
            rescue_text = "Geholfen! Der Sonnenfalter flattert ins Licht.",
        },
        {
            id = "sonnenvogel", name = "Sonnenvogel", zone = "regenbogenbruecke",
            color = "#f39c12", size = 0.7, speed = 1.3, glow = 8,
            food = "Sonnenkoerner", power = "Leuchtet warm wie die Sonne",
            heart = "#fcf3cf",
            rescue_text = "Geholfen! Der Sonnenvogel steigt leuchtend in den Himmel.",
        },
        {
            -- legendary, rare: never auto-spawns (egg/manual only)
            id = "regenbogen_pegasus", name = "Regenbogen-Pegasus", zone = "regenbogenbruecke",
            color = "#d2b4ff", size = 1.6, speed = 1.0, glow = 12, rare = true,
            food = "Regenbogenlicht", power = "Ein sehr seltenes Flugpferd mit Regenbogen-Maehne",
            heart = "#e8daef",
            rescue_text = "Der legendaere Regenbogen-Pegasus schenkt dir ein buntes Leuchten!",
        },
        {
            id = "wolkenschaf", name = "Wolkenschaf", zone = "wolkenfelder",
            color = "#f5fbff", size = 0.9, speed = 0.8, family = 2,
            food = "Wolkengras", power = "Weich und flauschig wie eine Wolke",
            heart = "#d6eaf8",
            rescue_text = "Geholfen! Das Wolkenschaf huepft froehlich ueber die Wolken.",
        },
        {
            id = "wolkenkatze", name = "Wolkenkatze", zone = "wolkenfelder",
            color = "#d6eaf8", size = 0.6, speed = 1.2,
            food = "Milch", power = "Schnurrt auf weichen Wolken",
            heart = "#d6eaf8",
            rescue_text = "Geholfen! Die Wolkenkatze schnurrt und rollt sich ein.",
        },
        {
            id = "schwalbe", name = "Schwalbe", zone = "wolkenfelder",
            color = "#34495e", size = 0.5, speed = 1.6,
            food = "Muecken", power = "Fliegt blitzschnell durch die Luft",
            heart = "#aed6f1",
            rescue_text = "Geholfen! Die Schwalbe schiesst pfeilschnell davon.",
        },
        {
            id = "himmelsqualle", name = "Himmelsqualle", zone = "wolkenfelder",
            color = "#aed6f1", size = 0.8, speed = 0.5, glow = 6,
            food = "Sonnenstaub", power = "Schwebt sanft wie eine Qualle am Himmel",
            heart = "#d6eaf8",
            rescue_text = "Geholfen! Die Himmelsqualle schwebt leise weiter.",
        },
        {
            id = "sturmvogel", name = "Sturmvogel", zone = "ballonhafen",
            color = "#5d6d7e", size = 0.8, speed = 1.4,
            food = "Wind", power = "Reitet auf dem Sturm",
            heart = "#d5dbdb",
            rescue_text = "Geholfen! Der Sturmvogel reitet zufrieden auf dem Wind.",
        },
        {
            id = "windgeist", name = "Windgeist", zone = "ballonhafen",
            color = "#eaf6ff", size = 0.6, speed = 1.5, glow = 7,
            food = "frische Luft", power = "Ein wirbelnder, leuchtender Windgeist",
            heart = "#eaf6ff",
            rescue_text = "Geholfen! Der Windgeist wirbelt leuchtend davon.",
        },
        {
            id = "wetterfrosch", name = "Wetterfrosch", zone = "ballonhafen",
            color = "#2ecc71", size = 0.5, speed = 0.9, family = 1,
            food = "Fliegen", power = "Kann das Wetter vorhersagen",
            heart = "#abebc6",
            rescue_text = "Geholfen! Der Wetterfrosch quakt - morgen wird es schoen!",
        },
        {
            id = "donnervogel", name = "Donnervogel", zone = "ballonhafen",
            color = "#34495e", size = 1.2, speed = 1.2, glow = 9,
            food = "Gewitter", power = "Seine Fluegel klingen wie Donner",
            heart = "#aed6f1",
            rescue_text = "Geholfen! Der Donnervogel rauscht grollend in die Wolken.",
        },
    },

    -- --- 5) Ranks (3rd field = colour -> creates a badge item) ---
    ranks = {
        { 0,  "Himmels-Frischling" },
        { 5,  "Wolkenlaeufer" },
        { 10, "Himmels-Forscher", "#3498db" },
        { 25, "Wolken-Freund",    "#27ae60" },
        { 50, "Himmels-Held",     "#f1c40f" },
    },

    -- --- 6) Logbook item ---
    logbook = { title = "Himmels-Logbuch", item_color = "#aed6f1" },

    -- --- 7) Plain texts for curriculum codes (for /lernplan & boards) ---
    kompetenzen = {
        ["NMG.1"] = "Das Wetter beobachten und beschreiben (Sonne, Wolken, Regen, Gewitter)",
        ["NMG.2"] = "Himmels-Tiere und ihren Lebensraum (die Luft) erkunden",
        ["NMG.3"] = "Phaenomene erklaeren: Warum steigt warme Luft? Warum fliegt ein Ballon?",
        ["MA.2"]  = "Form und Raum: oben/unten, hoch/tief, ueber/unter (Raumorientierung)",
        ["MA.3"]  = "Muster und Reihen legen und fortsetzen (Regenbogen-Farben)",
        ["BG.1"]  = "Farben kennen und gestalten (die sieben Regenbogenfarben)",
        ["D.2"]   = "Tiere und Wetter benennen und beschreiben",
    },
})

-- ============================================================
--  THEME EXTRAS  (self-contained Lua the engine cannot express)
-- ============================================================

-- ------------------------------------------------------------
--  B) EXTRA: HEISSLUFTBALLON  (drivable, flying vehicle)
--  Not part of the engine - a self-contained mount the theme adds
--  on its own. The theme's signature lesson on FLUG-PHYSIK: warm
--  air rises, so the balloon goes up. Place -> right-click to board
--  -> W/S fly forward/back, A/D steer, jump = up, sneak = down,
--  right-click = get off. A second player can fly along.
-- ------------------------------------------------------------
local BALLOON_SPEED = 6

core.register_entity(L("heissluftballon"), {
    initial_properties = {
        physical = true, collide_with_objects = true,
        collisionbox = { -0.8, -0.8, -0.8, 0.8, 1.6, 0.8 },
        visual = "cube", visual_size = { x = 1.6, y = 2.4, z = 1.6 },
        textures = {
            "[fill:16x16:#e74c3c^[fill:16x4:0,6:#f1c40f^[fill:16x4:0,12:#3498db",  -- top
            "[fill:16x16:#7e5109",                                                -- bottom (basket)
            "[fill:16x16:#e74c3c^[fill:16x4:0,6:#f1c40f^[fill:16x4:0,12:#3498db",  -- sides (balloon)
            "[fill:16x16:#e74c3c^[fill:16x4:0,6:#f1c40f^[fill:16x4:0,12:#3498db",
            "[fill:16x16:#e74c3c^[fill:16x4:0,6:#f1c40f^[fill:16x4:0,12:#3498db",
            "[fill:16x16:#e74c3c^[fill:16x4:0,6:#f1c40f^[fill:16x4:0,12:#3498db",
        },
    },
    _driver = nil, _passenger = nil, _puff = 0,

    on_rightclick = function(self, clicker)
        if not (clicker and clicker:is_player()) then return end
        local name = clicker:get_player_name()
        if self._driver == name then
            clicker:set_detach()
            clicker:set_eye_offset({ x = 0, y = 0, z = 0 }, { x = 0, y = 0, z = 0 })
            self._driver = nil
            core.chat_send_player(name, "Du steigst aus dem Ballon aus.")
        elseif self._passenger == name then
            clicker:set_detach()
            clicker:set_eye_offset({ x = 0, y = 0, z = 0 }, { x = 0, y = 0, z = 0 })
            self._passenger = nil
            core.chat_send_player(name, "Du steigst als Mitflieger aus.")
        elseif not self._driver then
            clicker:set_attach(self.object, "", { x = 3, y = -2, z = 0 }, { x = 0, y = 0, z = 0 })
            self._driver = name
            core.chat_send_player(name,
                "Ballon startet! W/S fliegen, A/D lenken, Springen = hoch (warme Luft!), " ..
                "Schleichen = runter, Rechtsklick = aussteigen. " ..
                "(Ein zweiter Spieler kann mitfliegen!)")
        elseif not self._passenger then
            clicker:set_attach(self.object, "", { x = -3, y = -2, z = 0 }, { x = 0, y = 0, z = 0 })
            self._passenger = name
            core.chat_send_player(name, "Du fliegst als Mitflieger mit! Rechtsklick = aussteigen.")
        end
    end,

    on_step = function(self, dtime)
        -- no gravity: a balloon hangs in the air (warm air carries it)
        self.object:set_acceleration({ x = 0, y = 0, z = 0 })
        local driver = self._driver and core.get_player_by_name(self._driver)
        if not driver then
            -- empty balloon drifts gently down to the ground
            self.object:set_velocity({ x = 0, y = -0.4, z = 0 })
            self._driver = nil
            return
        end
        local ctrl = driver:get_player_control()
        local yaw  = self.object:get_yaw()
        if ctrl.left  then yaw = yaw + 0.04 end
        if ctrl.right then yaw = yaw - 0.04 end
        self.object:set_yaw(yaw)
        local dir = core.yaw_to_dir(yaw)
        local fwd = (ctrl.up and BALLOON_SPEED) or (ctrl.down and -BALLOON_SPEED * 0.5) or 0
        local vy  = (ctrl.jump and BALLOON_SPEED * 0.7) or (ctrl.sneak and -BALLOON_SPEED * 0.7) or 0
        self.object:set_velocity({ x = dir.x * fwd, y = vy, z = dir.z * fwd })

        -- a small warm-air puff while rising / flying
        if ctrl.jump or fwd ~= 0 then
            self._puff = (self._puff or 0) + dtime
            if self._puff > 0.25 then
                self._puff = 0
                local p = self.object:get_pos()
                core.add_particlespawner({
                    amount = 5, time = 0.2,
                    minpos = vector.subtract(p, 0.4), maxpos = vector.add(p, 0.4),
                    minvel = { x = -0.2, y = 0.6, z = -0.2 },
                    maxvel = { x = 0.2,  y = 1.2, z = 0.2 },
                    minexptime = 0.4, maxexptime = 0.9, minsize = 1, maxsize = 2,
                    texture = "[fill:8x8:#f9e79f",
                })
            end
        end
    end,
})

core.register_craftitem(L("heissluftballon"), {
    description     = "Heissluftballon (Fahrzeug, fliegt)\nPlatzieren, dann Rechtsklick zum Einsteigen",
    inventory_image = "[fill:16x16:#e74c3c^[fill:16x4:0,2:#f1c40f^[fill:16x3:0,7:#3498db" ..
                      "^[fill:6x4:5,11:#7e5109",
    on_place = function(itemstack, placer, pointed_thing)
        if pointed_thing.type ~= "node" or not (placer and placer:is_player()) then
            return itemstack
        end
        local pos = pointed_thing.above
        pos.y = pos.y + 1.0
        core.add_entity(pos, L("heissluftballon"))
        if not core.is_creative_enabled(placer:get_player_name()) then
            itemstack:take_item()
        end
        return itemstack
    end,
})

-- ------------------------------------------------------------
--  C) EXTRA: REGENBOGEN  (a block that cycles the seven colours)
--  A self-contained light show for the Regenbogenbruecke: each
--  rainbow node has a node timer and, every few seconds, swaps to
--  the next colour (rot -> orange -> gelb -> gruen -> blau ->
--  indigo -> violett -> ...). Beautiful AND a gentle lesson about
--  the rainbow's colour order (BG.1 / MA.3). Place the base
--  "regenbogen" block; the coloured steps appear on their own.
-- ------------------------------------------------------------
local RAINBOW_TIME = 3

-- the first colour (rot) doubles as the placeable base "regenbogen"
-- block; the other six are the not-in-creative cycle steps. This map
-- gives the real registered node name for any step (so violett -> rot
-- points back at the base, not a missing "regenbogen_glanz_rot").
local function rb_node(idx)
    if idx == 1 then return L("regenbogen") end
    return L("regenbogen_glanz_" .. RAINBOW[idx][1])
end

for i, r in ipairs(RAINBOW) do
    local colour   = r[3]
    local is_base  = (i == 1)
    local nextname = rb_node((i % #RAINBOW) + 1)
    local groups   = { cracky = 3, oddly_breakable_by_hand = 2 }
    if not is_base then groups.not_in_creative_inventory = 1 end

    local nodename = rb_node(i)

    core.register_node(nodename, {
        description = is_base
            and "Regenbogen (leuchtet und wechselt langsam die Farbe)"
            or  "Regenbogen (" .. r[2] .. ")",
        tiles = { "[fill:16x16:" .. colour .. "^[fill:16x3:0,3:#ffffff^[fill:16x2:0,11:#ffffff" },
        paramtype         = "light",
        light_source      = 12,
        groups            = groups,
        drop              = L("regenbogen"),
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
--  E) EXTRA: WETTER-STATION  (the theme's weather feature)
--  The engine turns the game's own weather off (no scary storms by
--  default), so the theme brings a friendly, controllable weather
--  of its own: right-click the Wetter-Station to cycle the weather
--  for everyone - Sonne -> Wolken -> Regen -> Gewitter -> Regenbogen.
--  Each state changes the sky, the clouds, adds rain particles and
--  announces itself. A hands-on lesson about weather (NMG.1).
--  (Defined before D so the starter kit can hand out the station.)
-- ------------------------------------------------------------
local WEATHER = {
    { id = "sonne",     name = "Sonne",     sky = "#87ceeb", clouds = "#ffffff",
      density = 0.2, regular = true,
      desc = "Die Sonne scheint! Warme Luft steigt nach oben." },
    { id = "wolken",    name = "Wolken",    sky = "#b0c4de", clouds = "#cfd8dc",
      density = 0.6,
      desc = "Viele Wolken ziehen vorbei. Es wird grauer." },
    { id = "regen",     name = "Regen",     sky = "#7f8c9b", clouds = "#5d6d7e",
      density = 0.8, rain = true, rain_color = "#85c1e9",
      desc = "Es regnet! Wasser-Tropfen fallen vom Himmel." },
    { id = "gewitter",  name = "Gewitter",  sky = "#3b4a59", clouds = "#2c3e50",
      density = 0.9, rain = true, rain_color = "#5dade2", thunder = true,
      desc = "Gewitter! Dunkle Wolken, Blitz und Donner." },
    { id = "regenbogen", name = "Regenbogen", sky = "#aed6f1", clouds = "#ffffff",
      density = 0.3, regular = true, rainbow = true,
      desc = "Nach dem Regen kommt der Regenbogen - sieben Farben am Himmel!" },
}

local current_weather = 1
local rain_spawners   = {}   -- player name -> particlespawner id

local function stop_rain(name)
    if rain_spawners[name] then
        core.delete_particlespawner(rain_spawners[name])
        rain_spawners[name] = nil
    end
end

local function apply_weather_to_player(player)
    local name = player:get_player_name()
    local w    = WEATHER[current_weather]

    if w.regular then
        player:set_sky({ type = "regular" })
    else
        player:set_sky({ type = "plain", base_color = w.sky, clouds = true })
    end
    player:set_clouds({ color = w.clouds, density = w.density or 0.4 })

    stop_rain(name)
    if w.rain then
        -- an endless, player-attached rain curtain above the head
        rain_spawners[name] = core.add_particlespawner({
            amount = 70, time = 0,
            attached  = player,
            minpos = { x = -10, y = 12, z = -10 },
            maxpos = { x =  10, y = 14, z =  10 },
            minvel = { x = 0, y = -13, z = 0 }, maxvel = { x = 0, y = -16, z = 0 },
            minexptime = 1.0, maxexptime = 1.4, minsize = 1, maxsize = 2,
            texture = "[fill:1x6:" .. (w.rain_color or "#85c1e9"),
        })
    end
end

local function apply_weather()
    for _, player in ipairs(core.get_connected_players()) do
        apply_weather_to_player(player)
    end
end

core.register_node(L("wetterstation"), {
    description = "Wetter-Station\nRechtsklick = Wetter wechseln " ..
                  "(Sonne -> Wolken -> Regen -> Gewitter -> Regenbogen)",
    tiles = {
        -- top: a little weather vane / dial
        "[fill:16x16:#5d6d7e^[fill:10x10:3,3:#aed6f1^[fill:4x4:6,2:#f1c40f^[fill:3x3:3,10:#3498db",
        "[fill:16x16:#34495e",
        "[fill:16x16:#5d6d7e^[fill:16x3:0,6:#aed6f1^[fill:4x4:6,2:#f1c40f",
    },
    paramtype2        = "facedir",
    groups            = { cracky = 2, oddly_breakable_by_hand = 2 },
    is_ground_content = false,
    on_rightclick = function(pos, node, clicker)
        if not (clicker and clicker:is_player()) then return end
        current_weather = (current_weather % #WEATHER) + 1
        apply_weather()
        local w = WEATHER[current_weather]
        for _, p in ipairs(core.get_connected_players()) do
            local pn = p:get_player_name()
            core.chat_send_player(pn, "Wetter: " .. w.name .. " - " .. w.desc)
        end
        -- a small effect at the station
        core.add_particlespawner({
            amount = 14, time = 0.3,
            minpos = vector.subtract(pos, 0.4), maxpos = vector.add(pos, 0.6),
            minvel = { x = -0.5, y = 1, z = -0.5 }, maxvel = { x = 0.5, y = 2, z = 0.5 },
            minexptime = 0.4, maxexptime = 0.9, minsize = 1, maxsize = 3,
            texture = "[fill:8x8:" .. w.sky,
        })
        if w.thunder then
            core.sound_play(WORLD_ID .. "_donner", { gain = 0.7 })
        else
            core.sound_play("lernwelt_rescue", { to_player = clicker:get_player_name(), gain = 0.5 })
        end
    end,
})

-- new players (and respawns) get the current weather
core.register_on_joinplayer(function(player)
    core.after(1.0, function()
        if player and player:is_player() then apply_weather_to_player(player) end
    end)
end)
core.register_on_leaveplayer(function(player)
    stop_rain(player:get_player_name())
end)

-- ------------------------------------------------------------
--  F) EXTRA: REGENBOGEN PFLANZEN  (a seed that grows a colour block)
--  A seed you place; after a while it grows into a random rainbow
--  colour block. Each grown one adds to a personal counter.
--  Reinforces the theme's colour focus (Regenbogenfarben).
-- ------------------------------------------------------------
local SEED_GROWN = {}
for _, r in ipairs(RAINBOW) do SEED_GROWN[#SEED_GROWN + 1] = "regenbogen_" .. r[1] end
local GROW_TIME = 18

core.register_node(L("regenbogen_samen"), {
    description = "Regenbogen-Samen\nSetzen - waechst zu einem bunten Regenbogen-Block",
    drawtype = "plantlike",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    floodable = false,
    tiles = { "[fill:16x16:#2ecc71^[fill:4x8:6,3:#e74c3c^[fill:4x4:6,2:#f1c40f" },
    inventory_image = "[fill:16x16:#2ecc71^[fill:4x8:6,3:#e74c3c^[fill:4x4:6,2:#f1c40f",
    selection_box = { type = "fixed", fixed = { -0.3, -0.5, -0.3, 0.3, 0.3, 0.3 } },
    groups = { dig_immediate = 3, oddly_breakable_by_hand = 3 },
    after_place_node = function(pos, placer)
        if placer and placer:is_player() then
            core.get_meta(pos):set_string("planter", placer:get_player_name())
        end
        core.get_node_timer(pos):start(GROW_TIME)
    end,
    on_timer = function(pos)
        local planter = core.get_meta(pos):get_string("planter")
        core.set_node(pos, { name = L(SEED_GROWN[math.random(#SEED_GROWN)]) })
        if planter ~= "" then
            local p = core.get_player_by_name(planter)
            if p then
                local meta = p:get_meta()
                local n = meta:get_int("lernwelt_himmelsdorf:regenbogen") + 1
                meta:set_int("lernwelt_himmelsdorf:regenbogen", n)
                core.sound_play("lernwelt_rescue", { to_player = planter, gain = 0.6 })
                core.chat_send_player(planter, "Ein Regenbogen-Block ist gewachsen! Bunte Bloecke: " .. n)
            end
        end
        return false
    end,
})

-- ------------------------------------------------------------
--  H) EXTRA: HOEHENMESSER  (altimeter -> oben/unten, Raumorientierung)
--  Hold it and left-click: it tells you how high you are and whether
--  that is high up or close to the ground. A tiny, hands-on lesson in
--  spatial orientation (MA.2 oben/unten, hoch/tief).
-- ------------------------------------------------------------
core.register_craftitem(L("hoehenmesser"), {
    description     = "Hoehenmesser\nLinksklick = zeigt deine Hoehe (oben/unten)",
    inventory_image = "[fill:16x16:#d6dbdf^[fill:10x10:3,3:#34495e^[fill:2x6:7,4:#f1c40f" ..
                      "^[fill:5x2:6,7:#e74c3c",
    on_use = function(itemstack, user)
        if not (user and user:is_player()) then return end
        local name = user:get_player_name()
        local y    = math.floor(user:get_pos().y)
        local hint
        if y >= 40 then hint = "Sehr hoch oben - der Boden ist weit unter dir!"
        elseif y >= 15 then hint = "Hoch oben in der Luft."
        elseif y >= 0  then hint = "Eher unten, nah am Boden."
        else hint = "Tief unten." end
        core.chat_send_player(name, "Hoehenmesser: Du bist auf Hoehe " .. y .. ". " .. hint)
        return itemstack
    end,
})

-- ------------------------------------------------------------
--  D) EXTRA: STARTER KIT  (handed out once on first join)
--  Makes the world testable right away: the logbook, the camera,
--  the balloon, a weather station, rainbow seeds, an altimeter, a
--  rainbow block, a stack of each sky/cloud/rainbow block and one
--  spawn egg per sky animal (the engine registers the eggs when a
--  mob API is present; missing items are simply skipped).
--  Turn off via the setting "lernwelt_himmelsdorf_starter_kit".
-- ------------------------------------------------------------
local STARTER_BLOCKS = {
    "wolke", "wolke_glas", "wolkenziegel", "schwebeland", "himmelsstein",
    "sonnenblock", "sternenblock", "wolkenlampe",
    "muster_regenbogen", "muster_wolke", "muster_sonne", "muster_stern",
    "ballonkorb", "regenbogen",
    "regenbogen_rot", "regenbogen_orange", "regenbogen_gelb", "regenbogen_gruen",
    "regenbogen_blau", "regenbogen_indigo", "regenbogen_violett",
}
-- Spawn-egg item names match the creature ids (world_id:creature_id)
local STARTER_EGGS = {
    "regenbogen_kolibri", "sonnenfalter", "sonnenvogel", "regenbogen_pegasus",
    "wolkenschaf", "wolkenkatze", "schwalbe", "himmelsqualle",
    "sturmvogel", "windgeist", "wetterfrosch", "donnervogel",
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
    give_if_exists(inv, L("heissluftballon"))
    give_if_exists(inv, L("hoehenmesser"))
    give_if_exists(inv, L("wetterstation") .. " 2")
    give_if_exists(inv, L("regenbogen_samen") .. " 5")
    for _, suffix in ipairs(STARTER_BLOCKS) do
        give_if_exists(inv, L(suffix) .. " 10")
    end
    for _, cid in ipairs(STARTER_EGGS) do
        give_if_exists(inv, L(cid))
    end
    core.chat_send_player(player:get_player_name(),
        "Himmelsdorf: Startausruestung erhalten - Himmels-Logbuch, Kamera, Heissluftballon, " ..
        "Hoehenmesser, Wetter-Station, Regenbogen-Samen, Wolken-/Himmels-/Regenbogen-Bloecke " ..
        "und Spawn-Eier. Tipp: '/himmelsdorf_wolkenstadt' baut dir eine ganze Wolkenstadt. " ..
        "Viel Spass hoch oben!")
end

core.register_on_joinplayer(function(player)
    if not core.settings:get_bool("lernwelt_himmelsdorf_starter_kit", true) then return end
    local meta = player:get_meta()
    if meta:get_int("lernwelt_himmelsdorf:starter_given") == 1 then return end
    meta:set_int("lernwelt_himmelsdorf:starter_given", 1)
    -- slight delay so the inventory exists and the message is seen
    core.after(1.5, function()
        if player and player:is_player() then give_starter_kit(player) end
    end)
end)

-- ------------------------------------------------------------
--  G) ANIMAL SKY SPAWNER  (a living sky)
--  The engine's built-in spawner only places water animals, so this
--  small, backend-agnostic spawner brings the sky animals to life:
--  every so often it tries to add one non-rare animal on a solid
--  surface (a cloud platform / the floating island) with air above,
--  near a player, capped so the sky never gets crowded. Turn off
--  with the setting "lernwelt_spawn_creatures".
-- ------------------------------------------------------------
local function sky_spawn_list()
    local list  = {}
    local world = lernwelt.worlds[WORLD_ID]
    for _, c in ipairs((world or {}).creatures or {}) do
        if not c.rare then list[#list + 1] = L(c.id) end
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

    local list = sky_spawn_list()
    if #list == 0 then return end

    for _, player in ipairs(core.get_connected_players()) do
        if math.random() < 0.6 then
            local pp   = player:get_pos()
            local ang  = math.random() * math.pi * 2
            local dist = 8 + math.random(0, 14)
            local cx   = math.floor(pp.x + math.cos(ang) * dist)
            local cz   = math.floor(pp.z + math.sin(ang) * dist)

            -- look near the player's height for a surface with air above
            local spawn_pos
            for dy = 4, -6, -1 do
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
--  I) EXTRA: BASE COMMANDS  (Schwebeinsel, Wolkenstadt, test station)
--  Ready-made builds in front of you. All need the "server"
--  privilege (automatic in single-player).
-- ------------------------------------------------------------
local BOARDS = {
    L("tafel_regenbogenbruecke"),
    L("tafel_wolkenfelder"),
    L("tafel_ballonhafen"),
}

-- A simple floating island: a round cloud platform with grassy
-- floating land in the middle and one learning board.
core.register_chatcommand("himmelsdorf_schwebeinsel", {
    description = "Baut eine kleine Schwebeinsel vor dir (Wolken-Plattform, Inselboden, eine Lern-Tafel)",
    privs = { server = true },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then return false, "Dieser Befehl funktioniert nur im Spiel." end
        local b  = vector.round(player:get_pos())
        local fy = b.y - 1
        local cz = b.z + 5          -- centre of the island
        local R  = 4

        for dx = -R, R do
            for dz = -R, R do
                local d = math.sqrt(dx * dx + dz * dz)
                if d <= R + 0.3 then
                    local x, z = b.x + dx, cz + dz
                    -- cloud rim, grassy land in the middle
                    local mat = (d <= R - 2) and L("schwebeland") or L("wolke")
                    core.set_node({ x = x, y = fy, z = z }, { name = mat })
                    -- a little rock hanging below the centre
                    if d <= 1 then
                        core.set_node({ x = x, y = fy - 1, z = z }, { name = L("himmelsstein") })
                    end
                end
            end
        end
        -- a learning board and a warm lamp on the island
        core.set_node({ x = b.x, y = fy + 1, z = cz }, { name = L("wolkenlampe") })
        if core.registered_nodes[L("tafel_wolkenfelder")] then
            core.set_node({ x = b.x, y = fy + 1, z = cz + R - 1 },
                { name = L("tafel_wolkenfelder"), param2 = 2 })
        end
        return true, "Schwebeinsel gebaut! Eine Wolken-Plattform mit Inselboden schwebt vor dir " ..
                     "- mit einer Lern-Tafel."
    end,
})

-- The signature base: a whole WOLKENSTADT - a big cloud platform
-- with the three learning boards, a glowing rainbow bridge, a sun,
-- a weather station, a balloon and a rainbow seed.
core.register_chatcommand("himmelsdorf_wolkenstadt", {
    description = "Baut eine ganze Wolkenstadt vor dir (Plattform, 3 Tafeln, Regenbogenbruecke, " ..
                  "Wetter-Station, Ballon)",
    privs = { server = true },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then return false, "Dieser Befehl funktioniert nur im Spiel." end
        local b    = vector.round(player:get_pos())
        local fy   = b.y - 1
        local z0   = b.z + 2
        local W    = 6                -- half-width (x: -6..6)
        local DEEP = 14               -- depth (z: 0..14)

        -- the cloud floor
        for dx = -W, W do
            for dz = 0, DEEP do
                core.set_node({ x = b.x + dx, y = fy, z = z0 + dz }, { name = L("wolke") })
            end
        end

        -- a glowing rainbow bridge arching across the middle (start
        -- each node's colour timer, since set_node skips after_place_node)
        for dx = -W, W do
            local arc = math.floor(2.5 + 2 * math.sin((dx + W) / (2 * W) * math.pi))
            local rp  = { x = b.x + dx, y = fy + arc, z = z0 + 7 }
            core.set_node(rp, { name = L("regenbogen") })
            core.get_node_timer(rp):start(RAINBOW_TIME)
        end

        -- three learning boards along the back
        local xs = { -4, 0, 4 }
        for i, board in ipairs(BOARDS) do
            if core.registered_nodes[board] then
                core.set_node({ x = b.x + xs[i], y = fy + 1, z = z0 + DEEP - 1 },
                    { name = board, param2 = 2 })
            end
        end

        -- a sun, a weather station and a rainbow seed
        core.set_node({ x = b.x - W + 1, y = fy + 3, z = z0 + 2 }, { name = L("sonnenblock") })
        core.set_node({ x = b.x + W - 1, y = fy + 1, z = z0 + 2 }, { name = L("wetterstation") })
        core.set_node({ x = b.x + W - 2, y = fy + 1, z = z0 + 4 }, { name = L("regenbogen_samen") })
        core.get_node_timer({ x = b.x + W - 2, y = fy + 1, z = z0 + 4 }):start(GROW_TIME)

        -- a balloon ready to board, near the entrance
        core.add_entity({ x = b.x, y = fy + 2, z = z0 + 2 }, L("heissluftballon"))

        return true, "Wolkenstadt gebaut! Ueber dir spannt sich eine leuchtende Regenbogenbruecke, " ..
                     "links scheint eine Sonne, rechts stehen Wetter-Station und Regenbogen-Samen. " ..
                     "Vorne wartet ein Heissluftballon, hinten die drei Lern-Tafeln."
    end,
})

-- A small test station: a cloud floor, the three boards, a balloon,
-- a weather station and a rainbow block.
core.register_chatcommand("himmelsdorf_teststation", {
    description = "Baut eine kleine Test-Station vor dir (Wolkenboden, 3 Lern-Tafeln, " ..
                  "Ballon, Wetter-Station, Regenbogen)",
    privs = { server = true },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then return false, "Dieser Befehl funktioniert nur im Spiel." end
        local base    = vector.round(player:get_pos())
        local floor_y = base.y - 1

        for dx = -3, 3 do
            for dz = 2, 6 do
                core.set_node({ x = base.x + dx, y = floor_y, z = base.z + dz }, { name = L("wolke") })
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

        -- a weather station, a glowing rainbow and a rainbow seed
        core.set_node({ x = base.x - 2, y = floor_y + 1, z = base.z + 2 }, { name = L("wetterstation") })
        core.set_node({ x = base.x + 2, y = floor_y + 1, z = base.z + 2 }, { name = L("regenbogen") })
        core.get_node_timer({ x = base.x + 2, y = floor_y + 1, z = base.z + 2 }):start(RAINBOW_TIME)

        -- a balloon ready to board
        core.add_entity({ x = base.x, y = floor_y + 2, z = base.z + 4 }, L("heissluftballon"))

        return true, "Test-Station gebaut! Drei Lern-Tafeln, eine Wetter-Station, ein leuchtender " ..
                     "Regenbogen und ein Heissluftballon stehen vor dir (Richtung +Z)."
    end,
})

-- ------------------------------------------------------------
--  AMBIENT-SOUND  (wind / birdsong)
--  Plays a gentle sky sound to each player now and then. The .ogg
--  files are optional (missing = silent, only a warning).
-- ------------------------------------------------------------
local amb_timer, amb_next = 0, 45
core.register_globalstep(function(dtime)
    amb_timer = amb_timer + dtime
    if amb_timer < amb_next then return end
    amb_timer = 0
    amb_next = 35 + math.random(0, 40)
    for _, player in ipairs(core.get_connected_players()) do
        local snd = (math.random() < 0.5) and "_wind" or "_voegel"
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

core.log("action", "[lernwelt_himmelsdorf] Theme 'Himmelsdorf' registered (on lernwelt engine).")
