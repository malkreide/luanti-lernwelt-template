-- ============================================================
--  THEME:  BAUMHAUS-FORSCHER  (a jungle treehouse explorer world)
--  A brand-free learning world built ON TOP of the reusable
--  "lernwelt" engine. Almost everything below is one declarative
--  register_world{...} call - blocks, learning zones, rescuable
--  jungle animals, logbook, ranks and badges all come from the
--  engine.
--
--  The theme's heart is SPATIAL ORIENTATION ("Raumorientierung",
--  NMG.3): the storeys of the forest (oben/unten - canopy, ground,
--  river, ruins) and a SCHNITZELJAGD (treasure hunt) whose hints
--  are PICTURES shown in Bilderrahmen (item frames). Children read
--  a picture + a direction (Norden/Osten/oben/unten ...), walk
--  there, find the next frame, and finally a treasure.
--
--  Things the engine cannot express live as small pieces of custom
--  code after register_world:
--    B) the rideable "Reit-Papagei" (parrot mount up into the canopy)
--    C) BILDERRAHMEN: item frames that show a picture hint; place
--       your own, right-click to cycle the picture, sneak+right-click
--       to choose one - the theme's special feature (Bildhinweise)
--    D) SCHNITZELJAGD: "/baumhaus_schnitzeljagd" lays out a chain of
--       picture-hint frames with directions, ending at a treasure
--    E) FORSCHER-KOMPASS: tells you which way you face (N/O/S/W), how
--       high you are (which forest storey) and where the next hint is
--    F) climbable Liane + Strickleiter (go up/down = oben/unten)
--    G) a starter kit handed out on first join (for quick testing)
--    H) a gentle ground spawner so jungle friends appear near you
--    ... plus the signature BAUMHAUS base, a test station, ambient
--        jungle sound and drifting leaves.
--
--  The mod name equals the world id ("lernwelt_baumhaus"), so all
--  nodes/items live in the "lernwelt_baumhaus:" namespace.
--
--  Content is authored in German (ASCII: ae/oe/ue), like the other
--  example themes. The engine's own UI is translated separately via
--  lernwelt/locale/*.tr.
-- ============================================================

local WORLD_ID = "lernwelt_baumhaus"

-- ------------------------------------------------------------
--  A) THE WHOLE LEARNING WORLD AS ONE DECLARATIVE TABLE
-- ------------------------------------------------------------
lernwelt.register_world({

    -- internal prefix; kept identical to the mod name so all
    -- nodes/items live in the "lernwelt_baumhaus:" namespace
    id    = WORLD_ID,
    title = "Baumhaus-Forscher",

    -- --- 1) Peaceful, child-friendly world ---
    -- A bright jungle day, frozen so the world stays sunny and safe
    -- while children explore the storeys of the forest in peace.
    config = {
        damage      = false,   -- no damage / no dying
        creative    = true,    -- unlimited blocks
        peaceful    = true,    -- no monsters
        freeze_time = "day",   -- a bright, sunny jungle
        no_weather  = true,
    },

    -- --- 2) Jungle / treehouse building blocks (no PNG) ---
    -- "texture" is a Luanti texture modifier: a base "[fill" plus
    -- overlays "^[fill:WxH:X,Y:#colour" - patterns without any files.
    blocks = {
        -- Blaetterdach (canopy leaves, for the storeys-of-the-forest idea)
        { suffix = "blatt_hell", name = "Blatt (hell)",
          texture = "[fill:16x16:#58c46f^[fill:3x3:2,2:#7fd99a^[fill:2x2:11,4:#3fae5a" ..
                    "^[fill:3x3:6,9:#3fae5a^[fill:2x2:12,11:#7fd99a^[fill:2x2:3,12:#3fae5a" },
        { suffix = "blatt_mittel", name = "Blatt (gruen)",
          texture = "[fill:16x16:#3fae5a^[fill:3x3:2,3:#2e8b46^[fill:2x2:10,2:#58c46f" ..
                    "^[fill:3x3:11,9:#2e8b46^[fill:2x2:5,11:#58c46f^[fill:2x2:7,7:#2e8b46" },
        { suffix = "blatt_dunkel", name = "Blatt (dunkel)",
          texture = "[fill:16x16:#1e8449^[fill:3x3:2,2:#176b3a^[fill:2x2:11,4:#2e8b46" ..
                    "^[fill:3x3:6,9:#176b3a^[fill:2x2:12,11:#2e8b46^[fill:2x2:3,12:#176b3a" },
        { suffix = "blatt_gelb", name = "Blatt (herbstgelb)",
          texture = "[fill:16x16:#9ccc4f^[fill:3x3:2,2:#b7d96e^[fill:2x2:11,4:#7fae33" ..
                    "^[fill:3x3:6,9:#7fae33^[fill:2x2:12,11:#b7d96e^[fill:2x2:3,12:#7fae33" },

        -- Baumstamm (per-face: bark on the sides, growth rings on top/bottom)
        { suffix = "baumstamm", name = "Baum-Stamm",
          top    = "[fill:16x16:#9c6b3a^[fill:12x12:2,2:#7a4f28^[fill:8x8:4,4:#9c6b3a" ..
                   "^[fill:4x4:6,6:#7a4f28",
          side   = "[fill:16x16:#6e4b2a^[fill:2x16:2,0:#5a3c20^[fill:2x16:7,0:#5a3c20" ..
                   "^[fill:2x16:12,0:#5a3c20^[fill:16x2:0,5:#7e5a34",
          bottom = "[fill:16x16:#7a4f28" },
        { suffix = "wurzelholz", name = "Wurzel-Holz",
          texture = "[fill:16x16:#5a3c20^[fill:3x16:1,0:#4a3018^[fill:2x16:6,0:#6e4b2a" ..
                    "^[fill:3x16:11,0:#4a3018^[fill:16x2:0,8:#6e4b2a" },

        -- Baumhaus-Bauteile (treehouse planks, walls, windows, bridge)
        { suffix = "planke", name = "Baumhaus-Planke",
          texture = "[fill:16x16:#c08a4e^[fill:16x1:0,4:#9a6a36^[fill:16x1:0,9:#9a6a36" ..
                    "^[fill:16x1:0,14:#9a6a36" },
        { suffix = "wand", name = "Baumhaus-Wand",
          texture = "[fill:16x16:#b9844f^[fill:2x16:3,0:#8a5e34^[fill:2x16:10,0:#8a5e34" ..
                    "^[fill:16x2:0,7:#8a5e34" },
        { suffix = "fenster", name = "Baumhaus-Fenster", color = "#aaddff", glass = true },
        { suffix = "bruecke", name = "Haenge-Bruecke (Planke)",
          texture = "[fill:16x16:#a9763f^[fill:16x2:0,1:#7a5230^[fill:16x2:0,13:#7a5230" ..
                    "^[fill:2x16:6,0:#8a5e34^[fill:2x16:9,0:#8a5e34" },

        -- Boden & Fluss
        { suffix = "waldboden", name = "Dschungel-Boden",
          texture = "[fill:16x16:#5a7a2a^[fill:3x2:2,3:#46611f^[fill:2x2:10,5:#46611f" ..
                    "^[fill:2x2:6,10:#6e8f37^[fill:2x2:12,11:#46611f^[fill:2x2:3,12:#6e8f37" },
        { suffix = "schlamm", name = "Fluss-Schlamm",
          texture = "[fill:16x16:#6b5230^[fill:3x3:2,3:#574226^[fill:2x2:10,8:#574226" ..
                    "^[fill:2x2:6,11:#7c6038" },
        { suffix = "flusskiesel", name = "Fluss-Kiesel",
          texture = "[fill:16x16:#9aa7ad^[fill:4x3:2,3:#7e8b91^[fill:3x3:10,8:#b6c2c7" ..
                    "^[fill:3x2:6,11:#7e8b91^[fill:2x2:3,11:#b6c2c7" },
        { suffix = "seerose", name = "Seerosen-Block", glow = 2,
          texture = "[fill:16x16:#2e7d6b^[fill:10x10:3,3:#27ae60^[fill:4x4:6,6:#e84393" },

        -- Alte Ruinen (mossy temple stone, vines, gold)
        { suffix = "ruinenstein", name = "Ruinen-Stein",
          texture = "[fill:16x16:#8d8478^[fill:8x7:0,0:#9a9184^[fill:7x8:9,8:#7c7468" ..
                    "^[fill:16x1:0,7:#6e675c^[fill:1x16:8,0:#6e675c" },
        { suffix = "moosstein", name = "Moos-Ruinenstein",
          texture = "[fill:16x16:#8d8478^[fill:3x3:2,2:#3fae5a^[fill:2x2:11,4:#2e8b46" ..
                    "^[fill:3x2:6,11:#3fae5a^[fill:2x2:12,12:#2e8b46^[fill:16x1:0,7:#6e675c" },
        { suffix = "rankenstein", name = "Ranken-Stein",
          texture = "[fill:16x16:#8d8478^[fill:2x12:4,2:#2e8b46^[fill:2x10:11,4:#2e8b46" ..
                    "^[fill:2x2:4,8:#3fae5a^[fill:2x2:11,10:#3fae5a^[fill:2x2:7,5:#3fae5a" },
        { suffix = "goldader", name = "Gold-Ader (Ruine)", glow = 4,
          texture = "[fill:16x16:#8d8478^[fill:4x3:2,3:#f1c40f^[fill:3x3:9,8:#f5d76e" ..
                    "^[fill:2x2:6,11:#f1c40f^[fill:2x2:12,4:#f5d76e" },
        { suffix = "ziegel", name = "Tempel-Ziegel",
          texture = "[fill:16x16:#b58a5e^[fill:7x3:0,0:#caa074^[fill:7x3:8,4:#caa074" ..
                    "^[fill:7x3:0,8:#caa074^[fill:7x3:8,12:#caa074^[fill:16x1:0,3:#8a6740" },
    },

    -- --- 3) Learning zones (each gets a placeable learning board) ---
    -- Zone titles double as the "habitat" shown in the logbook.
    -- The theme is built around Raumorientierung (NMG.3): the storeys
    -- of the forest, directions, and following picture hints.
    zones = {
        {
            id = "blaetterdach", title = "Blaetterdach", color = "#27ae60",
            activity = "Die oberste Etage des Waldes erkunden. Tiere OBEN im " ..
                       "Blaetterdach entdecken und benennen, Blaetter von hell " ..
                       "nach dunkel ordnen, oben und unten unterscheiden.",
            lehrplan = { "NMG.3", "NMG.2", "MA.3" },
            tasks = {
                { type = "quiz", question = "Wo findest du den Papagei?",
                  options = { "Oben im Blaetterdach", "Unten am Boden", "Im Fluss" }, answer = 1,
                  done = "Richtig! Papageien leben ganz oben im Blaetterdach." },
                { type = "pattern",
                  sequence = { "#a9dfbf", "#58c46f", "#1e8449" },
                  palette  = { { "#a9dfbf", "Hell" }, { "#58c46f", "Gruen" }, { "#1e8449", "Dunkel" } },
                  done = "Super! Blaetter von hell nach dunkel gelegt." },
                { type = "rescue", creature = "affe", count = 2,
                  done = "Stark! Zwei Affen sind wieder im Baum." },
            },
        },
        {
            id = "fluss", title = "Fluss", color = "#3498db",
            activity = "Am Wasser forschen: Wer schwimmt im Fluss? Tiere am und " ..
                       "im Wasser entdecken, und ueberlegen, wohin ein Fluss " ..
                       "fliesst (bergab).",
            lehrplan = { "NMG.2", "NMG.3", "D.2" },
            tasks = {
                { type = "quiz", question = "Wer schwimmt im Fluss?",
                  options = { "Der Fisch", "Das Faultier" }, answer = 1,
                  done = "Genau! Der Fisch schwimmt, das Faultier haengt im Baum." },
                { type = "quiz", question = "Wohin fliesst ein Fluss?",
                  options = { "Bergab (nach unten)", "Bergauf (nach oben)" }, answer = 1,
                  done = "Richtig! Wasser fliesst immer nach unten, bergab." },
                { type = "rescue", creature = "frosch", count = 2,
                  done = "Klasse! Zwei Froesche zurueck an den Fluss gebracht." },
            },
        },
        {
            id = "ruinen", title = "Alte Ruinen", color = "#8d8478",
            activity = "In den alten Ruinen auf Schnitzeljagd gehen: Bild-Hinweisen " ..
                       "in den Rahmen folgen, Pfeile lesen (Norden/Osten, oben/unten) " ..
                       "und den Weg zum Schatz finden.",
            lehrplan = { "NMG.3", "MA.3", "D.2" },
            tasks = {
                { type = "quiz", question = "Wie heisst das Spiel, bei dem du Bild-Hinweisen folgst?",
                  options = { "Schnitzeljagd", "Verstecken" }, answer = 1,
                  done = "Genau! Bei der Schnitzeljagd folgst du Bild-Hinweisen." },
                { type = "quiz", question = "Ein Pfeil zeigt nach OBEN. Wohin gehst du?",
                  options = { "Hinauf (klettern)", "Hinunter" }, answer = 1,
                  done = "Richtig! Ein Pfeil nach oben heisst: hinaufklettern." },
                { type = "rescue", creature = "gecko", count = 2,
                  done = "Toll! Zwei Geckos in den Ruinen entdeckt und gerettet." },
            },
        },
    },

    -- --- 4) Rescuable jungle friends (peaceful; right-click = rescue) ---
    creatures = {
        -- Blaetterdach (the canopy - "oben")
        {
            id = "papagei", name = "Papagei", zone = "blaetterdach",
            color = "#e74c3c", size = 0.5, speed = 1.2, family = 1,
            food = "Fruechte", power = "Plappert alles nach",
            heart = "#f5b7b1",
            rescue_text = "Gerettet! Der Papagei flattert bunt ins Blaetterdach.",
        },
        {
            id = "affe", name = "Affe", zone = "blaetterdach",
            color = "#8d6e3a", size = 0.6, speed = 1.1, family = 1,
            food = "Bananen", power = "Klettert blitzschnell",
            heart = "#c8a06e",
            rescue_text = "Gerettet! Der Affe hangelt sich froehlich von Ast zu Ast.",
        },
        {
            id = "faultier", name = "Faultier", zone = "blaetterdach",
            color = "#9c8b6e", size = 0.6, speed = 0.2,
            food = "Blaetter", power = "Ganz langsam und gemuetlich",
            heart = "#d3c7b0",
            rescue_text = "Gerettet! Das Faultier haengt sich seelenruhig in den Baum.",
        },
        {
            id = "tukan", name = "Tukan", zone = "blaetterdach",
            color = "#2c3e50", size = 0.5, speed = 1.0,
            food = "Beeren", power = "Hat einen riesigen bunten Schnabel",
            heart = "#aab7c4",
            rescue_text = "Gerettet! Der Tukan klackert mit dem Schnabel und fliegt los.",
        },
        {
            id = "dschungelfalter", name = "Dschungel-Falter", zone = "blaetterdach",
            color = "#3498db", size = 0.4, speed = 1.2,
            food = "Bluetennektar", power = "Schillernde, blaue Fluegel",
            heart = "#aed6f1",
            rescue_text = "Gerettet! Der Dschungel-Falter schimmert blau davon.",
        },

        -- Fluss (the river)
        {
            id = "frosch", name = "Laubfrosch", zone = "fluss",
            color = "#2ecc71", size = 0.4, speed = 0.9,
            food = "Fliegen", power = "Springt ganz weit",
            heart = "#82e0aa",
            rescue_text = "Gerettet! Der Laubfrosch huepft quakend zum Fluss.",
        },
        {
            id = "fisch", name = "Fisch", zone = "fluss",
            color = "#e67e22", size = 0.4, speed = 1.0, swims = true,
            food = "Algen", power = "Schwimmt flink durchs Wasser",
            heart = "#f0b27a",
            rescue_text = "Gerettet! Der Fisch flitzt mit einem Platscher davon.",
        },
        {
            id = "schildkroete", name = "Schildkroete", zone = "fluss",
            color = "#27ae60", size = 0.5, speed = 0.3, swims = true, family = 2,
            food = "Wasserpflanzen", power = "Traegt ihren Panzer als Haus",
            heart = "#a3e4c0",
            rescue_text = "Gerettet! Die Schildkroete paddelt gemaechlich in den Fluss.",
        },
        {
            id = "reiher", name = "Reiher", zone = "fluss",
            color = "#ecf0f1", size = 0.7, speed = 0.8,
            food = "Fische", power = "Stakst auf langen Beinen durchs Wasser",
            heart = "#f7f9f9",
            rescue_text = "Gerettet! Der Reiher breitet die Fluegel aus und hebt ab.",
        },
        {
            id = "libelle", name = "Libelle", zone = "fluss",
            color = "#1abc9c", size = 0.3, speed = 1.4,
            food = "Muecken", power = "Schwirrt blitzschnell ueber das Wasser",
            heart = "#a3e4d7",
            rescue_text = "Gerettet! Die Libelle schwirrt glitzernd ueber den Fluss.",
        },

        -- Alte Ruinen (the old ruins - shady, mysterious)
        {
            id = "gecko", name = "Gecko", zone = "ruinen",
            color = "#58d68d", size = 0.3, speed = 1.0,
            food = "Insekten", power = "Laeuft sogar Waende hoch",
            heart = "#abebc6",
            rescue_text = "Gerettet! Der Gecko flitzt die Ruinen-Wand hinauf.",
        },
        {
            id = "fledermaus", name = "Fledermaus", zone = "ruinen",
            color = "#6c3483", size = 0.4, speed = 1.3,
            food = "Motten", power = "Hoert im Dunkeln",
            heart = "#bb8fce",
            rescue_text = "Gerettet! Die Fledermaus flattert leise in die Ruine.",
        },
        {
            id = "nashornkaefer", name = "Nashorn-Kaefer", zone = "ruinen",
            color = "#34495e", size = 0.4, speed = 0.5,
            food = "Baumsaft", power = "Stark wie ein kleiner Ochse",
            heart = "#aeb6bf",
            rescue_text = "Gerettet! Der Nashorn-Kaefer brummt schwerfaellig davon.",
        },
        {
            -- legendary, rare: never auto-spawns (egg/manual only)
            id = "goldjaguar", name = "Goldener Jaguar", zone = "ruinen",
            color = "#f1c40f", size = 0.9, speed = 1.3, rare = true,
            food = "Geheimnisse", power = "Sehr selten und majestaetisch",
            heart = "#fff2a8",
            rescue_text = "Der legendaere Goldene Jaguar nickt dir zu und verschwindet im Tempel!",
        },
    },

    -- --- 5) Ranks (3rd field = colour -> creates a badge item) ---
    ranks = {
        { 0,  "Baumhaus-Knirps" },
        { 5,  "Ast-Kletterer" },
        { 10, "Blaetterdach-Forscher", "#2ecc71" },
        { 25, "Ruinen-Entdecker",      "#b9770e" },
        { 50, "Dschungel-Meister",     "#16a085" },
    },

    -- --- 6) Logbook item ---
    logbook = { title = "Forscher-Tagebuch", item_color = "#27ae60" },

    -- --- 7) Plain texts for curriculum codes (for /lernplan & boards) ---
    kompetenzen = {
        ["NMG.3"] = "Raeume erkunden und sich orientieren: oben/unten, die " ..
                    "Stockwerke des Waldes, Pfeilen und Hinweisen folgen",
        ["NMG.2"] = "Tiere im Lebensraum entdecken, beobachten und benennen",
        ["MA.3"]  = "Raum-Orientierung: oben/unten, vorne/hinten, einem Plan und " ..
                    "Pfeilen folgen (Norden/Osten/Sueden/Westen)",
        ["D.2"]   = "Tiere und Dinge benennen und beschreiben",
    },
})

-- ============================================================
--  CUSTOM EXTRAS  (everything the declarative table cannot express)
-- ============================================================

-- ------------------------------------------------------------
--  B) EXTRA: REIT-PAPAGEI  (rideable parrot mount)
--  Not part of the engine - a self-contained flying mount the theme
--  adds on its own. A gentle parrot you ride UP into the canopy and
--  across the river - perfect to explore the "oben" storey.
--  Controls: place -> right-click to mount -> W/S move, A/D steer,
--  jump = up, sneak = down, right-click = dismount. A second player
--  can ride along (Eltern + Kind).
-- ------------------------------------------------------------
local PARROT_SPEED = 5

core.register_entity(WORLD_ID .. ":papagei_mount", {
    initial_properties = {
        physical = true, collide_with_objects = true,
        collisionbox = { -0.5, -0.4, -0.5, 0.5, 0.5, 0.5 },
        visual = "cube", visual_size = { x = 1.0, y = 0.9, z = 1.2 },
        textures = {
            "[fill:16x16:#2980b9", "[fill:16x16:#1f6692",
            "[fill:16x16:#e74c3c", "[fill:16x16:#f1c40f",
            "[fill:16x16:#2c3e50", "[fill:16x16:#27ae60",
        },
    },
    _driver = nil, _passenger = nil, _hum = nil, _feather = 0,

    on_rightclick = function(self, clicker)
        if not (clicker and clicker:is_player()) then return end
        local name = clicker:get_player_name()
        if self._driver == name then
            clicker:set_detach()
            clicker:set_eye_offset({ x = 0, y = 0, z = 0 }, { x = 0, y = 0, z = 0 })
            self._driver = nil
            if self._hum then core.sound_stop(self._hum); self._hum = nil end
            core.chat_send_player(name, "Du steigst vom Papagei ab.")
        elseif self._passenger == name then
            clicker:set_detach()
            clicker:set_eye_offset({ x = 0, y = 0, z = 0 }, { x = 0, y = 0, z = 0 })
            self._passenger = nil
            core.chat_send_player(name, "Du steigst als Mitfahrer ab.")
        elseif not self._driver then
            clicker:set_attach(self.object, "", { x = 0, y = 4, z = 0 }, { x = 0, y = 0, z = 0 })
            self._driver = name
            self._hum = core.sound_play(WORLD_ID .. "_papagei",
                { object = self.object, loop = true, gain = 0.4 })
            core.chat_send_player(name,
                "Papagei geweckt! W/S fliegen, A/D lenken, Springen = HOCH ins " ..
                "Blaetterdach, Schleichen = RUNTER, Rechtsklick = absteigen. " ..
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
            self._driver = nil
            return
        end
        local ctrl = driver:get_player_control()
        local yaw  = self.object:get_yaw()
        if ctrl.left  then yaw = yaw + 0.05 end
        if ctrl.right then yaw = yaw - 0.05 end
        self.object:set_yaw(yaw)
        local dir = core.yaw_to_dir(yaw)
        local fwd = (ctrl.up and PARROT_SPEED) or (ctrl.down and -PARROT_SPEED * 0.5) or 0
        local vy  = (ctrl.jump and PARROT_SPEED * 0.7) or (ctrl.sneak and -PARROT_SPEED * 0.7) or 0
        self.object:set_velocity({ x = dir.x * fwd, y = vy, z = dir.z * fwd })

        -- soft drifting feathers while moving
        if fwd ~= 0 or vy ~= 0 then
            self._feather = (self._feather or 0) + dtime
            if self._feather > 0.3 then
                self._feather = 0
                local p = self.object:get_pos()
                core.add_particlespawner({
                    amount = 4, time = 0.2,
                    minpos = vector.subtract(p, 0.4), maxpos = vector.add(p, 0.4),
                    minvel = { x = -0.2, y = -0.4, z = -0.2 },
                    maxvel = { x = 0.2,  y = -0.1, z = 0.2 },
                    minexptime = 0.8, maxexptime = 1.6, minsize = 1, maxsize = 2,
                    texture = "[fill:8x8:#aed6f1",
                })
            end
        end
    end,
})

core.register_craftitem(WORLD_ID .. ":papagei_mount", {
    description = "Reit-Papagei (Reittier)\nPlatzieren, dann Rechtsklick zum Aufsteigen",
    inventory_image = "[fill:16x16:#2980b9^[fill:6x6:5,3:#e74c3c^[fill:3x3:9,8:#f1c40f" ..
                      "^[fill:2x2:4,6:#2c3e50",
    on_place = function(itemstack, placer, pointed_thing)
        if pointed_thing.type ~= "node" or not (placer and placer:is_player()) then
            return itemstack
        end
        local pos = pointed_thing.above
        pos.y = pos.y + 0.5
        core.add_entity(pos, WORLD_ID .. ":papagei_mount")
        if not core.is_creative_enabled(placer:get_player_name()) then
            itemstack:take_item()
        end
        return itemstack
    end,
})

-- ------------------------------------------------------------
--  C) EXTRA: BILDERRAHMEN  (picture-hint item frames)
--  The theme's special feature: little wooden frames that show a
--  PICTURE (a leaf, a water drop, a stone, a paw, a treasure or a
--  direction arrow). Children "read" the picture as a hint. You can
--  place your own frames and build your OWN treasure hunt:
--    right-click        = cycle to the next picture
--    sneak + right-click = open a chooser to pick any picture
--  Frames placed by the Schnitzeljagd (section D) instead show a
--  text hint with a direction when right-clicked.
--  Everything is drawn procedurally - no image files.
-- ------------------------------------------------------------

-- A wooden frame around a parchment inner field; pictures are drawn
-- into the 12x12 inner area (offset 2,2).
local FRAME_BASE = "[fill:16x16:#7a5230^[fill:12x12:2,2:#efe2c4"

-- key, label, picture overlay (drawn on top of FRAME_BASE)
local PICTURES = {
    { "leer",   "Leer",          "" },
    { "blatt",  "Blatt",         "^[fill:8x2:4,5:#27ae60^[fill:10x2:3,7:#2ecc71" ..
                                  "^[fill:8x2:4,9:#1e8449^[fill:1x7:8,4:#145a32" },
    { "tropfen","Wassertropfen", "^[fill:2x2:7,4:#2980b9^[fill:4x2:6,6:#3498db" ..
                                  "^[fill:6x4:5,8:#5dade2^[fill:4x1:6,11:#2980b9" },
    { "stein",  "Stein",         "^[fill:8x6:4,6:#7f8c8d^[fill:3x2:5,7:#95a5a6" ..
                                  "^[fill:2x2:9,9:#5d6d7e^[fill:2x2:5,10:#5d6d7e" },
    { "baum",   "Baum",          "^[fill:8x5:4,3:#1e8449^[fill:6x2:5,2:#27ae60" ..
                                  "^[fill:2x5:7,8:#6e4b2a" },
    { "pranke", "Tier-Spur",     "^[fill:4x3:6,9:#5d4037^[fill:2x2:5,5:#5d4037" ..
                                  "^[fill:2x2:9,5:#5d4037^[fill:2x2:4,7:#5d4037^[fill:2x2:10,7:#5d4037" },
    { "schatz", "Schatz",        "^[fill:8x5:4,8:#b9770e^[fill:8x2:4,7:#f1c40f" ..
                                  "^[fill:2x2:7,9:#7a5230^[fill:2x2:7,4:#fff2a8" },
    { "pfeil_nord", "Pfeil Norden", "^[fill:2x2:7,3:#c0392b^[fill:4x2:6,5:#c0392b" ..
                                  "^[fill:6x2:5,7:#c0392b^[fill:2x3:7,9:#c0392b" },
    { "pfeil_sued", "Pfeil Sueden", "^[fill:2x3:7,3:#c0392b^[fill:6x2:5,6:#c0392b" ..
                                  "^[fill:4x2:6,8:#c0392b^[fill:2x2:7,10:#c0392b" },
    { "pfeil_ost",  "Pfeil Osten",  "^[fill:6x2:4,7:#c0392b^[fill:2x6:9,5:#c0392b" ..
                                  "^[fill:2x2:11,7:#c0392b" },
    { "pfeil_west", "Pfeil Westen", "^[fill:6x2:6,7:#c0392b^[fill:2x6:5,5:#c0392b" ..
                                  "^[fill:2x2:3,7:#c0392b" },
    { "pfeil_hoch", "Pfeil hoch (oben)", "^[fill:2x2:7,3:#2980b9^[fill:6x2:5,5:#2980b9" ..
                                  "^[fill:2x6:7,7:#2980b9" },
    { "pfeil_runter", "Pfeil runter (unten)", "^[fill:2x6:7,3:#2980b9" ..
                                  "^[fill:6x2:5,9:#2980b9^[fill:2x2:7,11:#2980b9" },
}

-- key -> index, key -> nodename, and the cycle order
local PIC_INDEX, PIC_NODE = {}, {}
for i, p in ipairs(PICTURES) do PIC_INDEX[p[1]] = i end

local function frame_nodename(key) return WORLD_ID .. ":rahmen_" .. key end
local function pic_label(key) return PICTURES[PIC_INDEX[key] or 1][2] end

-- transient state: which frame each player is choosing a picture for
local rahmen_edit = {}

local function show_rahmen_chooser(player, pos)
    local pname = player:get_player_name()
    rahmen_edit[pname] = pos
    local f = { "formspec_version[4]", "size[10,7]",
        "box[0,0;10,1;#7a5230]",
        "label[0.4,0.5;Bild fuer den Rahmen waehlen:]" }
    local x, y = 0.4, 1.4
    for _, p in ipairs(PICTURES) do
        f[#f + 1] = ("image_button[%f,%f;1.2,1.2;%s;pic_%s;]")
            :format(x, y, FRAME_BASE .. p[3], p[1])
        f[#f + 1] = ("label[%f,%f;%s]"):format(x, y + 1.2, core.formspec_escape(p[2]))
        x = x + 1.6
        if x > 8.6 then x = 0.4; y = y + 2.0 end
    end
    core.show_formspec(pname, WORLD_ID .. ":rahmen_chooser", table.concat(f))
end

local function show_rahmen_hint(player, pos)
    local meta = core.get_meta(pos)
    local key  = meta:get_string("bild")
    if key == "" then key = "leer" end
    local hint = meta:get_string("hinweis")
    local nr   = meta:get_int("nummer")
    local pname = player:get_player_name()

    -- count this station as "found" once per player+position
    local seen_key = "lernwelt_baumhaus:gesehen_" .. core.pos_to_string(pos)
    if player:get_meta():get_int(seen_key) == 0 then
        player:get_meta():set_int(seen_key, 1)
        local m = player:get_meta()
        local n = m:get_int("lernwelt_baumhaus:hinweise") + 1
        m:set_int("lernwelt_baumhaus:hinweise", n)
        core.sound_play("lernwelt_rescue", { to_player = pname, gain = 0.6 })
    end

    local title = (nr > 0) and ("Hinweis Nr. " .. nr) or "Bild-Hinweis"
    local f = { "formspec_version[4]", "size[8,7]",
        "box[0,0;8,1;#27ae60]",
        ("label[0.4,0.5;%s]"):format(core.formspec_escape(title)),
        ("image[2.5,1.4;3,3;%s]"):format(FRAME_BASE .. PICTURES[PIC_INDEX[key] or 1][3]),
        ("textarea[0.4,4.6;7.2,1.6;;;%s]"):format(core.formspec_escape(hint ~= "" and hint or
            ("Das Bild zeigt: " .. pic_label(key) .. "."))),
        "button_exit[3,6.2;2,0.7;ok;Weiter]" }
    core.show_formspec(pname, WORLD_ID .. ":rahmen_hinweis", table.concat(f))
end

for _, p in ipairs(PICTURES) do
    local key   = p[1]
    local nodename = frame_nodename(key)
    PIC_NODE[key] = nodename
    core.register_node(nodename, {
        description = "Bilderrahmen (" .. p[2] .. ")\nRechtsklick = Bild wechseln, " ..
                      "Schleichen+Rechtsklick = Bild waehlen",
        drawtype = "nodebox",
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,
        tiles = { FRAME_BASE .. p[3] },
        inventory_image = FRAME_BASE .. p[3],
        node_box = { type = "fixed", fixed = { -0.5, -0.5, 0.37, 0.5, 0.5, 0.5 } },
        groups = { choppy = 3, oddly_breakable_by_hand = 2,
                   not_in_creative_inventory = (key == "leer") and 0 or 1 },
        -- only the empty frame shows up in creative search; the others
        -- are reached by cycling, but all can be /giveme'd by key
        drop = frame_nodename("leer"),
        is_ground_content = false,
        on_rightclick = function(pos, node, clicker)
            if not (clicker and clicker:is_player()) then return end
            -- Schnitzeljagd frames carry a hint -> show it instead of editing
            if core.get_meta(pos):get_int("jagd") == 1 then
                show_rahmen_hint(clicker, pos)
                return
            end
            if clicker:get_player_control().sneak then
                show_rahmen_chooser(clicker, pos)
            else
                -- cycle to the next picture, keeping orientation
                local cur  = PIC_INDEX[key] or 1
                local nxt  = PICTURES[(cur % #PICTURES) + 1][1]
                core.swap_node(pos, { name = frame_nodename(nxt), param2 = node.param2 })
                core.chat_send_player(clicker:get_player_name(),
                    "Bild im Rahmen: " .. pic_label(nxt))
            end
        end,
    })
end

core.register_on_player_receive_fields(function(player, formname, fields)
    if formname ~= WORLD_ID .. ":rahmen_chooser" then return end
    local pos = rahmen_edit[player:get_player_name()]
    if not pos then return true end
    for _, p in ipairs(PICTURES) do
        if fields["pic_" .. p[1]] then
            local node = core.get_node(pos)
            if node.name:sub(1, #WORLD_ID + 8) == WORLD_ID .. ":rahmen_" then
                core.swap_node(pos, { name = frame_nodename(p[1]), param2 = node.param2 })
                core.chat_send_player(player:get_player_name(),
                    "Bild im Rahmen: " .. p[2])
            end
            rahmen_edit[player:get_player_name()] = nil
            return true
        end
    end
    return true
end)

-- ------------------------------------------------------------
--  D) EXTRA: SCHNITZELJAGD  (picture-hint treasure hunt)
--  "/baumhaus_schnitzeljagd" lays out a chain of Bilderrahmen on
--  small posts around you. Each frame shows a PICTURE + a text hint
--  pointing to the NEXT one with a real direction (Norden/Osten/...
--  and - for the canopy post - "weiter oben"). The chain ends at a
--  treasure chest. A pure Raumorientierung exercise (NMG.3): read a
--  picture, follow the direction, find the next clue. Priv: server.
-- ------------------------------------------------------------

-- The four storeys of the forest as treasure-chest milestones.
local SCHATZ_MILESTONES = {
    [1] = "Schatzsucher",
    [3] = "Karten-Leser",
    [5] = "Schatzmeister",
}

-- pick the matching arrow picture + spoken direction from a->b
local function direction_to(from, to)
    local dx, dz, dy = to.x - from.x, to.z - from.z, to.y - from.y
    local pic, word
    if math.abs(dy) >= 3 and math.abs(dy) >= math.max(math.abs(dx), math.abs(dz)) then
        if dy > 0 then pic, word = "pfeil_hoch", "nach OBEN (klettere hinauf)"
        else pic, word = "pfeil_runter", "nach UNTEN" end
    elseif math.abs(dx) >= math.abs(dz) then
        if dx > 0 then pic, word = "pfeil_ost", "nach OSTEN" else pic, word = "pfeil_west", "nach WESTEN" end
    else
        if dz > 0 then pic, word = "pfeil_nord", "nach NORDEN" else pic, word = "pfeil_sued", "nach SUEDEN" end
    end
    if math.abs(dy) >= 2 then
        word = word .. (dy > 0 and " und etwas hoeher" or " und etwas tiefer")
    end
    return pic, word
end

-- place a hint frame on a post at base+offset; returns its world pos
local function place_hint(base, off, pic, hint, nr)
    local fx, fz = base.x + off.dx, base.z + off.dz
    local fy     = base.y + (off.dy or 0)
    -- build a little post from the ground up to the frame
    for y = base.y - 1, fy - 1 do
        core.set_node({ x = fx, y = y, z = fz }, { name = WORLD_ID .. ":baumstamm" })
    end
    -- a rope ladder on tall posts so children can climb to read it
    if (off.dy or 0) >= 3 then
        for y = base.y, fy - 1 do
            core.set_node({ x = fx, y = y, z = fz + 1 }, { name = WORLD_ID .. ":strickleiter" })
        end
    end
    local pos = { x = fx, y = fy, z = fz }
    core.set_node(pos, { name = frame_nodename(pic) })
    local meta = core.get_meta(pos)
    meta:set_int("jagd", 1)
    meta:set_string("hinweis", hint)
    meta:set_int("nummer", nr)
    meta:set_string("infotext", "Bild-Hinweis Nr. " .. nr .. " (rechtsklick)")
    return pos
end

core.register_chatcommand("baumhaus_schnitzeljagd", {
    description = "Legt eine Schnitzeljagd mit Bild-Hinweisen vor dir an " ..
                  "(Bilderrahmen mit Pfeilen -> Schatz)",
    privs = { server = true },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then return false, "Dieser Befehl funktioniert nur im Spiel." end
        local b = vector.round(player:get_pos())

        -- A small course: four hint posts (one up high = "oben") and a
        -- treasure. Each station's hint points to the NEXT station.
        local stations = {
            { dx = -5, dz = 4,  dy = 1 },   -- 1 start (west)
            { dx =  5, dz = 4,  dy = 1 },   -- 2 east
            { dx =  5, dz = 11, dy = 4 },   -- 3 north + HIGH (canopy/oben)
            { dx = -5, dz = 11, dy = 1 },   -- 4 west again
        }
        local treasure = { dx = 0, dz = 8, dy = 1 }

        local function world(off) return { x = b.x + off.dx, y = b.y + off.dy, z = b.z + off.dz } end

        for i, st in ipairs(stations) do
            local nextoff = stations[i + 1] or treasure
            local pic, word = direction_to(world(st), world(nextoff))
            local target = (i < #stations) and "zum naechsten Bild" or "zum SCHATZ"
            local hint = ("Gehe %s, %s. Such dort den naechsten Rahmen."):format(word, target)
            if i == #stations then
                hint = ("Fast geschafft! Gehe %s %s."):format(word, target)
            end
            place_hint(b, st, pic, hint, i)
        end

        -- the treasure chest at the end
        local tp = world(treasure)
        for y = b.y - 1, tp.y - 1 do
            core.set_node({ x = tp.x, y = y, z = tp.z }, { name = WORLD_ID .. ":ziegel" })
        end
        core.set_node(tp, { name = WORLD_ID .. ":schatzkiste" })

        return true, "Schnitzeljagd gelegt! Start ist der Rahmen links vor dir " ..
                     "(Westen). Rechtsklick auf einen Rahmen zeigt das Bild und den " ..
                     "naechsten Pfeil. Folge ihnen bis zum Schatz!"
    end,
})

-- ------------------------------------------------------------
--  TREASURE CHEST  (the reward at the end of a Schnitzeljagd)
--  Right-click once = reward + a personal "Schaetze" counter with
--  milestones. Drops nothing when broken; this is a goal node.
-- ------------------------------------------------------------
local SCHATZ_LOOT = { "goldader", "blatt_gelb", "papagei_mount" }

core.register_node(WORLD_ID .. ":schatzkiste", {
    description = "Schatzkiste\nRechtsklick = Schatz oeffnen",
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    tiles = {
        "[fill:16x16:#7a5230^[fill:16x4:0,0:#f1c40f^[fill:2x2:7,5:#b9770e",  -- top (lid band)
        "[fill:16x16:#6e4b2a",
        "[fill:16x16:#8a5e34^[fill:16x3:0,6:#f1c40f^[fill:2x4:7,8:#b9770e", -- sides (lock)
    },
    groups = { choppy = 2, oddly_breakable_by_hand = 2 },
    is_ground_content = false,
    on_rightclick = function(pos, node, clicker)
        if not (clicker and clicker:is_player()) then return end
        local name = clicker:get_player_name()
        local meta = clicker:get_meta()
        local n = meta:get_int("lernwelt_baumhaus:schaetze") + 1
        meta:set_int("lernwelt_baumhaus:schaetze", n)
        core.sound_play("lernwelt_rankup", { to_player = name, gain = 1.0 })
        -- a little sparkle
        core.add_particlespawner({
            amount = 30, time = 0.4,
            minpos = vector.subtract(pos, 0.4), maxpos = vector.add(pos, 0.6),
            minvel = { x = -0.5, y = 1, z = -0.5 }, maxvel = { x = 0.5, y = 2.5, z = 0.5 },
            minexptime = 0.6, maxexptime = 1.4, minsize = 1, maxsize = 2,
            glow = 12, texture = "[fill:8x8:#fff2a8",
        })
        core.chat_send_player(name, "Schatz gefunden! Du hast schon " .. n ..
            " Schaetze entdeckt. Etwas Gold wandert in dein Inventar.")
        local inv = clicker:get_inventory()
        if inv then
            for _, suffix in ipairs(SCHATZ_LOOT) do
                local it = WORLD_ID .. ":" .. suffix
                if core.registered_items[it] then inv:add_item("main", it) end
            end
        end
        local title = SCHATZ_MILESTONES[n]
        if title then
            core.chat_send_player(name, "Glueckwunsch! Du bist jetzt: " .. title .. "!")
        end
    end,
})

-- ------------------------------------------------------------
--  E) EXTRA: FORSCHER-KOMPASS  (spatial-orientation helper)
--  A pocket helper for Raumorientierung: left-click tells you which
--  way you FACE (Norden/Osten/Sueden/Westen), HOW HIGH you are above
--  the ground (which storey of the forest) and the direction to the
--  NEAREST Schnitzeljagd hint frame. Pure NMG.3 / MA.3 support.
-- ------------------------------------------------------------
local function facing_word(yaw)
    local dir = core.yaw_to_dir(yaw)
    if math.abs(dir.x) >= math.abs(dir.z) then
        return dir.x > 0 and "Osten" or "Westen"
    else
        return dir.z > 0 and "Norden" or "Sueden"
    end
end

-- how many blocks of air below the player (height above solid ground)
local function height_above_ground(pos)
    local p = vector.round(pos)
    for dy = 0, 24 do
        local n   = core.get_node({ x = p.x, y = p.y - 1 - dy, z = p.z }).name
        local def = core.registered_nodes[n]
        if n == "ignore" then return nil end
        if def and def.walkable ~= false and n ~= "air" then return dy end
    end
    return 25
end

-- all frame node names, for nearest-hint scanning
local FRAME_NODE_NAMES = {}
for _, p in ipairs(PICTURES) do FRAME_NODE_NAMES[#FRAME_NODE_NAMES + 1] = frame_nodename(p[1]) end

local function nearest_hint_dir(pos)
    local r = 32
    local found = core.find_nodes_in_area(
        { x = pos.x - r, y = pos.y - 16, z = pos.z - r },
        { x = pos.x + r, y = pos.y + 16, z = pos.z + r },
        FRAME_NODE_NAMES)
    local best, best_d
    for _, fp in ipairs(found or {}) do
        if core.get_meta(fp):get_int("jagd") == 1 then
            local d = vector.distance(pos, fp)
            if not best_d or d < best_d then best, best_d = fp, d end
        end
    end
    if not best then return nil end
    local _, word = direction_to(pos, best)
    return word, math.floor(best_d + 0.5)
end

core.register_craftitem(WORLD_ID .. ":kompass", {
    description = "Forscher-Kompass\nLinksklick = Richtung, Hoehe & naechster Hinweis",
    inventory_image = "[fill:16x16:#7a5230^[fill:12x12:2,2:#ecf0f1^[fill:2x6:7,3:#c0392b" ..
                      "^[fill:2x5:7,8:#34495e^[fill:4x4:6,6:#bdc3c7",
    on_use = function(itemstack, user)
        if not (user and user:is_player()) then return itemstack end
        local name = user:get_player_name()
        local face = facing_word(user:get_look_horizontal())
        local h    = height_above_ground(user:get_pos())
        local storey
        if h == nil then storey = "(Boden unbekannt)"
        elseif h <= 1 then storey = "ganz UNTEN auf dem Waldboden"
        elseif h <= 4 then storey = h .. " Bloecke ueber dem Boden (mittleres Stockwerk)"
        else storey = h .. " Bloecke hoch - OBEN im Blaetterdach" end
        core.chat_send_player(name, "Kompass: Du schaust nach " .. face ..
            ". Du bist " .. storey .. ".")
        local dirword, dist = nearest_hint_dir(user:get_pos())
        if dirword then
            core.chat_send_player(name, "Naechster Bild-Hinweis: " .. dirword ..
                " (ca. " .. dist .. " Bloecke). Folge dem Pfeil!")
        else
            core.chat_send_player(name, "Kein Schnitzeljagd-Hinweis in der Naehe. " ..
                "Tipp: /baumhaus_schnitzeljagd legt eine an.")
        end
        return itemstack
    end,
})

-- ------------------------------------------------------------
--  F) EXTRA: KLETTERN  (climbable Liane + Strickleiter)
--  Going up and down is the heart of "Stockwerke des Waldes". Two
--  climbable nodes let children reach the canopy and return - a
--  hands-on oben/unten experience. Place them on a wall or post.
-- ------------------------------------------------------------
core.register_node(WORLD_ID .. ":liane", {
    description = "Liane (kletterbar)\nAn eine Wand setzen und hochklettern",
    drawtype = "plantlike",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    climbable = true,
    floodable = false,
    tiles = { "[fill:16x16:#1e8449^[fill:3x16:5,0:#2e8b46^[fill:2x16:10,0:#176b3a" ..
              "^[fill:2x2:6,3:#58c46f^[fill:2x2:10,9:#58c46f" },
    inventory_image = "[fill:16x16:#1e8449^[fill:3x16:5,0:#2e8b46^[fill:2x16:10,0:#176b3a",
    selection_box = { type = "fixed", fixed = { -0.4, -0.5, -0.4, 0.4, 0.5, 0.4 } },
    groups = { snappy = 3, oddly_breakable_by_hand = 3 },
})

core.register_node(WORLD_ID .. ":strickleiter", {
    description = "Strickleiter (kletterbar)\nHoch ins Blaetterdach, runter zum Boden",
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    sunlight_propagates = true,
    walkable = false,
    climbable = true,
    floodable = false,
    tiles = { "[fill:16x16:#00000000^[fill:2x16:3,0:#9a6a36^[fill:2x16:11,0:#9a6a36" ..
              "^[fill:16x2:0,2:#c08a4e^[fill:16x2:0,8:#c08a4e^[fill:16x2:0,14:#c08a4e" },
    use_texture_alpha = "clip",
    inventory_image = "[fill:16x16:#c08a4e^[fill:2x16:3,0:#9a6a36^[fill:2x16:11,0:#9a6a36" ..
                      "^[fill:16x2:0,2:#7a5230^[fill:16x2:0,8:#7a5230^[fill:16x2:0,14:#7a5230",
    node_box = { type = "fixed", fixed = { -0.5, -0.5, 0.4, 0.5, 0.5, 0.5 } },
    groups = { snappy = 3, oddly_breakable_by_hand = 3 },
})

-- ------------------------------------------------------------
--  G) EXTRA: STARTER KIT  (handed out once on first join)
--  Makes the world testable right away: logbook, camera, the
--  Forscher-Kompass, the Reit-Papagei, climbable Lianen + ladders,
--  a stack of each building block, some empty Bilderrahmen to build
--  your own hints, and one spawn egg per jungle friend (the engine
--  registers eggs when a mob API is present; missing items skipped).
--  Turn off via the setting "lernwelt_baumhaus_starter_kit".
-- ------------------------------------------------------------
local STARTER_BLOCKS = {
    "blatt_hell", "blatt_mittel", "blatt_dunkel", "blatt_gelb",
    "baumstamm", "planke", "wand", "fenster", "bruecke",
    "waldboden", "flusskiesel", "seerose",
    "ruinenstein", "moosstein", "rankenstein", "ziegel", "goldader",
    "liane", "strickleiter",
}
-- Spawn-egg item names match the creature ids (world_id:creature_id)
local STARTER_EGGS = {
    "papagei", "affe", "faultier", "tukan", "dschungelfalter",
    "frosch", "fisch", "schildkroete", "reiher", "libelle",
    "gecko", "fledermaus", "nashornkaefer", "goldjaguar",
}

local function give_if_exists(inv, itemstring)
    local nm = ItemStack(itemstring):get_name()
    if core.registered_items[nm] then inv:add_item("main", itemstring) end
end

local function give_starter_kit(player)
    local inv = player:get_inventory()
    if not inv then return end
    give_if_exists(inv, WORLD_ID .. ":logbuch")
    give_if_exists(inv, WORLD_ID .. ":kamera")
    give_if_exists(inv, WORLD_ID .. ":kompass")
    give_if_exists(inv, WORLD_ID .. ":papagei_mount")
    give_if_exists(inv, WORLD_ID .. ":rahmen_leer 6")
    for _, suffix in ipairs(STARTER_BLOCKS) do
        give_if_exists(inv, WORLD_ID .. ":" .. suffix .. " 10")
    end
    for _, cid in ipairs(STARTER_EGGS) do
        give_if_exists(inv, WORLD_ID .. ":" .. cid)
    end
    core.chat_send_player(player:get_player_name(),
        "Baumhaus-Forscher: Startausruestung erhalten - Forscher-Tagebuch, Kamera, " ..
        "Kompass, Reit-Papagei, Bilderrahmen, Lianen, Strickleitern, Bau-Bloecke und " ..
        "Spawn-Eier sind in deinem Inventar. Tipp: /baumhaus_bauen baut dein Baumhaus!")
end

core.register_on_joinplayer(function(player)
    if not core.settings:get_bool("lernwelt_baumhaus_starter_kit", true) then return end
    local meta = player:get_meta()
    if meta:get_int("lernwelt_baumhaus:starter_given") == 1 then return end
    meta:set_int("lernwelt_baumhaus:starter_given", 1)
    core.after(1.5, function()
        if player and player:is_player() then give_starter_kit(player) end
    end)
end)

-- ------------------------------------------------------------
--  H) EXTRA: GROUND SPAWNER  (a living jungle)
--  The engine's built-in spawner only places water animals, so this
--  small, backend-agnostic spawner brings the land jungle friends to
--  life: every so often it tries to add one non-rare, non-swimming
--  creature on solid ground with air above, near a player, capped so
--  the jungle never gets crowded. Off with "lernwelt_spawn_creatures".
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
--  I) EXTRA: BAUMHAUS BAUEN  (the signature base)
--  "/baumhaus_bauen" builds the world's home base in front of you:
--  a big tree with a thick trunk, a high platform with a railing,
--  a leafy canopy on top, a Strickleiter + Lianen to climb (oben!),
--  the three learning boards up on the platform, two Bilderrahmen at
--  different heights (to show the storeys: oben/unten) and a
--  Reit-Papagei waiting at the foot of the tree. Priv: server.
-- ------------------------------------------------------------
core.register_chatcommand("baumhaus_bauen", {
    description = "Baut ein grosses Baumhaus (Basis) vor dir - mit Plattform, " ..
                  "Blaetterdach, Strickleiter, Lern-Tafeln, Bilderrahmen und Papagei",
    privs = { server = true },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then return false, "Dieser Befehl funktioniert nur im Spiel." end
        local b      = vector.round(player:get_pos())
        local trunk  = WORLD_ID .. ":baumstamm"
        local plank  = WORLD_ID .. ":planke"
        local leaf   = WORLD_ID .. ":blatt_mittel"
        local leaf2  = WORLD_ID .. ":blatt_dunkel"
        local rail   = WORLD_ID .. ":wand"
        local PH      = 6                 -- platform height above ground
        local fy      = b.y               -- ground level (feet)
        local cx, cz  = b.x, b.z + 5      -- tree centre, a bit in front

        -- 2x2 trunk from the ground up through the platform into the canopy
        for dy = 0, PH + 4 do
            for _, o in ipairs({ { 0, 0 }, { 1, 0 }, { 0, 1 }, { 1, 1 } }) do
                core.set_node({ x = cx + o[1], y = fy + dy, z = cz + o[2] }, { name = trunk })
            end
        end

        -- the platform: a 9x9 plank floor with a low wall (railing)
        local R = 4
        for dx = -R, R do
            for dz = -R, R do
                local x, z = cx + dx, cz + dz
                -- leave the 2x2 trunk holes open
                local in_trunk = (dx == 0 or dx == 1) and (dz == 0 or dz == 1)
                if not in_trunk then
                    core.set_node({ x = x, y = fy + PH, z = z }, { name = plank })
                end
                -- railing around the rim, with a gap at the front (south) for the ladder
                if math.abs(dx) == R or math.abs(dz) == R then
                    local gap = (dz == -R and (dx == 0 or dx == 1))
                    if not gap then
                        core.set_node({ x = x, y = fy + PH + 1, z = z }, { name = rail })
                    end
                end
            end
        end

        -- a Strickleiter up the south face of the trunk + a Liane beside it
        for dy = 1, PH do
            core.set_node({ x = cx, y = fy + dy, z = cz - 1 },
                { name = WORLD_ID .. ":strickleiter", param2 = 4 })
            core.set_node({ x = cx + 1, y = fy + dy, z = cz - 1 },
                { name = WORLD_ID .. ":liane" })
        end

        -- a leafy canopy dome above the platform (the "oben" storey)
        for dy = 2, 5 do
            local cr = R + 2 - dy
            for dx = -cr, cr do
                for dz = -cr, cr do
                    if dx * dx + dz * dz <= cr * cr + 1 then
                        local node = (math.random() < 0.5) and leaf or leaf2
                        core.set_node({ x = cx + dx, y = fy + PH + 3 + dy, z = cz + dz },
                            { name = node })
                    end
                end
            end
        end

        -- the three learning boards UP on the platform, facing the ladder
        local boards = { "tafel_blaetterdach", "tafel_fluss", "tafel_ruinen" }
        local xs = { -2, 0, 2 }
        for i, bd in ipairs(boards) do
            local nn = WORLD_ID .. ":" .. bd
            if core.registered_nodes[nn] then
                core.set_node({ x = cx + xs[i], y = fy + PH + 1, z = cz + R - 1 },
                    { name = nn, param2 = 2 })
            end
        end

        -- two Bilderrahmen to teach the storeys: one low ("unten", a paw),
        -- one high on the platform ("oben", a leaf)
        local low = { x = cx + 3, y = fy + 2, z = cz - 1 }
        core.set_node(low, { name = frame_nodename("pranke") })
        core.get_meta(low):set_string("infotext", "Bild-Hinweis: hier UNTEN am Boden")
        local high = { x = cx - R + 1, y = fy + PH + 1, z = cz - R + 1 }
        core.set_node(high, { name = frame_nodename("blatt") })
        core.get_meta(high):set_string("infotext", "Bild-Hinweis: hier OBEN im Blaetterdach")

        -- a Reit-Papagei waiting at the foot of the tree
        core.add_entity({ x = cx + 0.5, y = fy + 0.5, z = cz - 2 }, WORLD_ID .. ":papagei_mount")

        return true, "Baumhaus gebaut! Klettere die Strickleiter HOCH (oder nimm den " ..
                     "Papagei): oben warten die drei Lern-Tafeln und ein Bild-Hinweis. " ..
                     "Unten am Stamm haengt ein zweiter Rahmen - so siehst du die " ..
                     "Stockwerke des Waldes (oben/unten)."
    end,
})

-- ------------------------------------------------------------
--  J) EXTRA: TEST STATION  (chat command for quick setup)
--  "/baumhaus_teststation" builds a small ready-made spot in front
--  of you: a forest floor, the three learning boards, a Reit-Papagei,
--  a row of Bilderrahmen to try (cycle the pictures!) and a short
--  Strickleiter to climb. Handy for testing. Priv: server.
-- ------------------------------------------------------------
local STATION_BOARDS = {
    WORLD_ID .. ":tafel_blaetterdach",
    WORLD_ID .. ":tafel_fluss",
    WORLD_ID .. ":tafel_ruinen",
}

core.register_chatcommand("baumhaus_teststation", {
    description = "Baut eine kleine Baumhaus-Test-Station vor dir " ..
                  "(Boden, 3 Lern-Tafeln, Papagei, Bilderrahmen, Strickleiter)",
    privs = { server = true },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then return false, "Dieser Befehl funktioniert nur im Spiel." end
        local base    = vector.round(player:get_pos())
        local floor_y = base.y - 1
        local floor   = WORLD_ID .. ":waldboden"

        for dx = -3, 3 do
            for dz = 2, 5 do
                core.set_node({ x = base.x + dx, y = floor_y, z = base.z + dz }, { name = floor })
            end
        end

        local xs = { -2, 0, 2 }
        for i, board in ipairs(STATION_BOARDS) do
            if core.registered_nodes[board] then
                core.set_node({ x = base.x + xs[i], y = floor_y + 1, z = base.z + 3 },
                    { name = board, param2 = 2 })
            end
        end

        -- a row of Bilderrahmen to try (right-click to cycle the picture)
        core.set_node({ x = base.x - 3, y = floor_y + 1, z = base.z + 5 },
            { name = frame_nodename("blatt") })
        core.set_node({ x = base.x - 1, y = floor_y + 1, z = base.z + 5 },
            { name = frame_nodename("tropfen") })
        core.set_node({ x = base.x + 1, y = floor_y + 1, z = base.z + 5 },
            { name = frame_nodename("stein") })
        core.set_node({ x = base.x + 3, y = floor_y + 1, z = base.z + 5 },
            { name = frame_nodename("pfeil_hoch") })

        -- a short Strickleiter to climb (oben/unten)
        for dy = 1, 4 do
            core.set_node({ x = base.x + 3, y = floor_y + dy, z = base.z + 2 },
                { name = WORLD_ID .. ":strickleiter", param2 = 2 })
        end

        core.add_entity({ x = base.x, y = floor_y + 1.5, z = base.z + 4 },
            WORLD_ID .. ":papagei_mount")

        return true, "Test-Station gebaut! Sie steht vor dir Richtung Norden (+Z): " ..
                     "Dschungel-Boden, drei Lern-Tafeln, ein Reit-Papagei, vier " ..
                     "Bilderrahmen zum Ausprobieren und eine Strickleiter zum Klettern."
    end,
})

-- ------------------------------------------------------------
--  K) EXTRA: AMBIENT-SOUND  (gentle jungle birds / insects)
--  Plays a gentle jungle sound to each player now and then. The
--  .ogg files are optional (missing = silent, only a warning).
-- ------------------------------------------------------------
local amb_timer, amb_next = 0, 45
core.register_globalstep(function(dtime)
    amb_timer = amb_timer + dtime
    if amb_timer < amb_next then return end
    amb_timer = 0
    amb_next = 35 + math.random(0, 40)
    for _, player in ipairs(core.get_connected_players()) do
        local snd = (math.random() < 0.5) and "_dschungel" or "_ambient"
        core.sound_play(WORLD_ID .. snd, { to_player = player:get_player_name(), gain = 0.4 })
    end
end)

-- ------------------------------------------------------------
--  L) EXTRA: TREIBENDE BLAETTER  (cosy drifting leaves)
--  A purely visual touch: soft leaves drift down around each player
--  - the jungle feels alive. Throttled and silent (no gameplay).
-- ------------------------------------------------------------
local leaf_timer = 0
core.register_globalstep(function(dtime)
    leaf_timer = leaf_timer + dtime
    if leaf_timer < 3.0 then return end
    leaf_timer = 0
    for _, player in ipairs(core.get_connected_players()) do
        local p = player:get_pos()
        core.add_particlespawner({
            amount = 6, time = 3.0,
            minpos = { x = p.x - 6, y = p.y + 4, z = p.z - 6 },
            maxpos = { x = p.x + 6, y = p.y + 8, z = p.z + 6 },
            minvel = { x = -0.3, y = -0.6, z = -0.3 },
            maxvel = { x = 0.3,  y = -0.2, z = 0.3 },
            minacc = { x = -0.1, y = -0.1, z = -0.1 },
            maxacc = { x = 0.1,  y = 0,    z = 0.1 },
            minexptime = 3.0, maxexptime = 6.0, minsize = 1, maxsize = 2,
            texture = "[fill:8x8:#2e8b46",
            playername = player:get_player_name(),
        })
    end
end)

core.log("action", "[lernwelt_baumhaus] Theme 'Baumhaus-Forscher' registered (on lernwelt engine).")
