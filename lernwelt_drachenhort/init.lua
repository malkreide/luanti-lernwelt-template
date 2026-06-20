-- ============================================================
--  THEME:  DRACHENHORT  (friendly dragons)
--  A brand-free dragon learning world built ON TOP of the
--  reusable "lernwelt" engine. Almost everything below is one
--  declarative register_world{...} call - blocks, learning
--  zones, friendly (rescuable/befriendable) dragons, logbook,
--  ranks and badges all come from the engine.
--
--  The theme's heart is RAISING A BABY DRAGON: hatch an egg,
--  then feed the baby again and again (with a patience cooldown)
--  until it trusts you and is tamed. This teaches Verantwortung
--  (responsibility) and Geduld (patience) - and counting eggs and
--  matching colours live on the learning boards (Lehrplan 21:
--  MA.1 + NMG).
--
--  Things the engine cannot express live as small pieces of
--  custom code after register_world:
--    B) a rideable, FLYING dragon mount (Reitdrache)
--    C) baby dragons + feeding + Animalia/mobs_redo-style taming
--    D) hatchable eggs (Brut-Ei) and colourful counting eggs
--    E) a starter kit handed out on first join (quick testing)
--    F) a land spawner so wild dragons appear around you
--    ...plus test/base commands, ambient sound and letter blocks.
--
--  The mod name equals the world id ("lernwelt_drachenhort"), so
--  all nodes/items live in the "lernwelt_drachenhort:" namespace.
--
--  Content is authored in German (ASCII: ae/oe/ue), like the
--  other example themes. The engine's own UI is translated
--  separately via lernwelt/locale/*.tr.
-- ============================================================

local WORLD_ID = "lernwelt_drachenhort"

-- ------------------------------------------------------------
--  A) THE WHOLE LEARNING WORLD AS ONE DECLARATIVE TABLE
-- ------------------------------------------------------------
lernwelt.register_world({

    -- internal prefix; kept identical to the mod name so all
    -- nodes/items live in the "lernwelt_drachenhort:" namespace
    id    = WORLD_ID,
    title = "Drachenhort",

    -- --- 1) Peaceful, child-friendly world ---
    config = {
        damage      = false,   -- no damage / no dying
        creative    = true,    -- unlimited blocks
        peaceful    = true,    -- no monsters
        freeze_time = "day",   -- always bright (no scary nights)
        no_weather  = true,
    },

    -- --- 2) Colourful dragon blocks (no PNG needed) ---
    blocks = {
        { suffix = "drachenstein_rot",   name = "Drachenstein (rot)",   color = "#c0392b", glow = 3 },
        { suffix = "drachenstein_blau",  name = "Drachenstein (blau)",  color = "#2980b9", glow = 3 },
        { suffix = "drachenstein_gruen", name = "Drachenstein (gruen)", color = "#27ae60", glow = 3 },
        { suffix = "drachenstein_gelb",  name = "Drachenstein (gelb)",  color = "#f1c40f", glow = 3 },
        { suffix = "drachenstein_lila",  name = "Drachenstein (lila)",  color = "#8e44ad", glow = 3 },
        { suffix = "bergstein",          name = "Bergstein",            color = "#7f8c8d" },
        { suffix = "wolkenblock",        name = "Wolkenblock",          color = "#eaf2fb", glow = 4 },
        { suffix = "kristallglas",       name = "Kristallglas",         color = "#d2b4ff", glass = true },

        -- "Kalte Lava": glowing-but-cooled crater rock. Purely decorative
        -- and completely safe (no damage) - the crater is lava-FREE.
        { suffix = "kalte_lava", name = "Kalte Lava (ungefaehrlich)",
          texture = "[fill:16x16:#922b21^[fill:5x5:1,2:#e67e22^[fill:4x4:9,3:#f39c12" ..
                    "^[fill:5x4:6,9:#e67e22^[fill:3x3:1,11:#f39c12^[fill:3x3:11,10:#f39c12",
          glow = 7 },

        -- Patterned decoration blocks (procedural, no image files needed).
        -- The "texture" field is a Luanti texture-modifier string: a base
        -- "[fill" plus overlaid "^[fill:WxH:X,Y:#colour" rectangles.
        { suffix = "schuppen_rot", name = "Drachenschuppen (rot)",
          texture = "[fill:16x16:#c0392b^[fill:3x3:1,1:#e74c3c^[fill:3x3:7,1:#e74c3c" ..
                    "^[fill:3x3:13,1:#e74c3c^[fill:3x3:4,5:#e74c3c^[fill:3x3:10,5:#e74c3c" ..
                    "^[fill:3x3:1,9:#e74c3c^[fill:3x3:7,9:#e74c3c^[fill:3x3:13,9:#e74c3c" },
        { suffix = "schuppen_gruen", name = "Drachenschuppen (gruen)",
          texture = "[fill:16x16:#1e8449^[fill:3x3:1,1:#2ecc71^[fill:3x3:7,1:#2ecc71" ..
                    "^[fill:3x3:13,1:#2ecc71^[fill:3x3:4,5:#2ecc71^[fill:3x3:10,5:#2ecc71" ..
                    "^[fill:3x3:1,9:#2ecc71^[fill:3x3:7,9:#2ecc71^[fill:3x3:13,9:#2ecc71" },
        { suffix = "drachenauge", name = "Drachenauge-Block",
          texture = "[fill:16x16:#f1c40f^[fill:14x8:1,4:#ffffff^[fill:6x6:5,5:#27ae60" ..
                    "^[fill:3x3:7,7:#1a1a1a" },
        { suffix = "ei_muster", name = "Ei-Muster-Block",
          texture = "[fill:16x16:#34495e^[fill:5x7:2,2:#f5e6c8^[fill:5x7:9,2:#f5e6c8" ..
                    "^[fill:5x7:2,9:#f5e6c8^[fill:5x7:9,9:#f5e6c8" },
        { suffix = "berg_muster", name = "Bergstein (gemustert)",
          texture = "[fill:16x16:#7f8c8d^[fill:8x8:0,0:#566573^[fill:8x8:8,8:#566573" },
        { suffix = "rahmen_gold", name = "Gold-Rahmen-Block",
          texture = "[fill:16x16:#b7950b^[fill:12x12:2,2:#f1c40f" },

        -- The dragon hoard: a heap of gold (a "Hort" is a dragon's treasure).
        { suffix = "goldhort", name = "Goldhort",
          texture = "[fill:16x16:#7e5109^[fill:4x4:2,9:#f1c40f^[fill:4x4:7,10:#f7dc6f" ..
                    "^[fill:4x4:11,9:#f1c40f^[fill:4x4:4,6:#f7dc6f^[fill:4x4:9,6:#f1c40f" ..
                    "^[fill:3x3:6,3:#f7dc6f" },

        -- Per-face block: a real nest (straw rim on top, twigs on the sides).
        { suffix = "nest", name = "Drachennest",
          top    = "[fill:16x16:#8d6e3a^[fill:10x10:3,3:#3b2a16" ..
                   "^[fill:4x4:4,4:#a0712f^[fill:4x4:8,8:#a0712f^[fill:4x4:8,4:#a0712f",
          side   = "[fill:16x16:#a0712f^[fill:16x2:0,3:#7e5109^[fill:16x2:0,8:#7e5109" ..
                   "^[fill:16x2:0,12:#7e5109",
          bottom = "[fill:16x16:#7e5109" },

        -- Eigenes gemaltes Bild als Block? Lege eine PNG (16x16 oder 32x32)
        -- "lernwelt_drachenhort_meinbild.png" in den textures/-Ordner und entferne
        -- die zwei Minuszeichen vor der naechsten Zeile:
        -- { suffix = "meinbild", name = "Mein Bild", texture = "lernwelt_drachenhort_meinbild.png" },
    },

    -- --- 3) Learning zones (each gets a placeable learning board) ---
    -- Zone titles double as the "habitat" shown in the logbook.
    zones = {
        {
            id = "berg", title = "Drachenberg", color = "#7f8c8d",
            activity = "Hoch im Berg legen die Drachen ihre Eier. Eier zaehlen, " ..
                       "Drachen-Farben zuordnen und grosse Felsendrachen anfreunden.",
            lehrplan = { "MA.1", "NMG.2", "MA.2" },
            tasks = {
                { type = "quiz",
                  question = "Im Nest liegen Eier:  Ei Ei Ei  - wie viele sind das?",
                  options = { "3", "5", "2" }, answer = 1,
                  done = "Richtig! Drei Eier liegen im Nest." },
                { type = "pattern",
                  sequence = { "#c0392b", "#f1c40f", "#c0392b" },
                  palette  = { { "#c0392b", "Rot" }, { "#f1c40f", "Gelb" }, { "#2980b9", "Blau" } },
                  done = "Super! Muster rot-gelb-rot zugeordnet." },
                { type = "rescue", creature = "felsendrache", count = 2,
                  done = "Stark! Zwei Felsendrachen angefreundet." },
            },
        },
        {
            id = "krater", title = "Lavafreier Krater", color = "#e67e22",
            activity = "Im warmen Krater ist die Lava erkaltet - ganz ungefaehrlich. " ..
                       "Glutdrachen-Farben erkennen, Eier zaehlen und Drachen anfreunden.",
            lehrplan = { "NMG.2", "MA.1" },
            tasks = {
                { type = "quiz", question = "Welche Farbe hat der Glutdrache?",
                  options = { "Rot", "Blau", "Gruen" }, answer = 1,
                  done = "Richtig! Der Glutdrache ist rot." },
                { type = "quiz",
                  question = "Zaehle die Eier:  Ei Ei Ei Ei  - wie viele?",
                  options = { "4", "3", "5" }, answer = 1,
                  done = "Richtig! Das sind vier Eier." },
                { type = "rescue", creature = "glutdrache", count = 1,
                  done = "Toll! Den Glutdrachen besaenftigt." },
            },
        },
        {
            id = "himmelsinseln", title = "Himmelsinseln", color = "#5dade2",
            activity = "Schwebende Inseln ueber den Wolken. Wolkendrachen anfreunden, " ..
                       "Farben zuordnen - und lernen, wie man fuer ein Drachenbaby sorgt.",
            lehrplan = { "NMG.1", "NMG.3", "MA.2" },
            tasks = {
                { type = "quiz", question = "Welche Farbe hat eine Wolke?",
                  options = { "Weiss", "Schwarz", "Gruen" }, answer = 1,
                  done = "Richtig! Wolken sind weiss." },
                { type = "pattern",
                  sequence = { "#2980b9", "#eaf2fb", "#2980b9" },
                  palette  = { { "#2980b9", "Blau" }, { "#eaf2fb", "Weiss" }, { "#27ae60", "Gruen" } },
                  done = "Klasse! Himmels-Muster blau-weiss-blau gelegt." },
                { type = "quiz",
                  question = "Ein Drachenbaby braucht...?",
                  options = { "Futter und Geduld", "gar nichts", "viel Laerm" }, answer = 1,
                  done = "Genau! Ein Baby braucht Futter, Pflege und Geduld." },
            },
        },
    },

    -- --- 4) Friendly dragons (peaceful; right-click = befriend) ---
    --  Reusing the engine's gentle "rescue" loop: a right-click calms
    --  the dragon, gives hearts, a sound, a counter entry and a rank.
    creatures = {
        {
            id = "glutdrache", name = "Glutdrache", zone = "krater",
            color = "#e74c3c", size = 1.1, speed = 1.0, family = 1,
            food = "Glut-Beeren", power = "Pustet warme (harmlose) Funken",
            heart = "#ff5fa2",
            rescue_text = "Der Glutdrache schnurrt zufrieden und ist jetzt dein Freund.",
        },
        {
            id = "funkendrache", name = "Funkendrache", zone = "krater",
            color = "#e67e22", size = 0.8, speed = 1.4,
            food = "Beeren", power = "Sprueht bunte Funken",
            heart = "#f8c471",
            rescue_text = "Der Funkendrache wirbelt vor Freude und folgt dir.",
        },
        {
            id = "beerendrache", name = "Beerendrache", zone = "krater",
            color = "#e84393", size = 0.6, speed = 0.9, family = 2,
            food = "suesse Beeren", power = "Ganz klein und verschmust",
            heart = "#f5b7b1",
            rescue_text = "Der kleine Beerendrache kuschelt sich an dich.",
        },
        {
            id = "felsendrache", name = "Felsendrache", zone = "berg",
            color = "#7f8c8d", size = 1.5, speed = 0.6,
            food = "Bergkraeuter", power = "Stark wie ein Fels",
            heart = "#d6dbdf",
            rescue_text = "Der grosse Felsendrache senkt sanft den Kopf - Freundschaft!",
        },
        {
            id = "smaragddrache", name = "Smaragddrache", zone = "berg",
            color = "#27ae60", size = 1.0, speed = 1.0,
            food = "Bergkraeuter", power = "Schuppen glaenzen gruen",
            heart = "#82e0aa",
            rescue_text = "Der Smaragddrache glitzert gruen und ist dein Freund.",
        },
        {
            id = "kristalldrache", name = "Kristalldrache", zone = "berg",
            color = "#9b59b6", size = 0.9, speed = 1.1, glow = 12,
            food = "Kristalle", power = "Leuchtet sanft im Dunkeln",
            heart = "#d2b4ff",
            rescue_text = "Der Kristalldrache leuchtet dir freundlich nach.",
        },
        {
            id = "wolkendrache", name = "Wolkendrache", zone = "himmelsinseln",
            color = "#ecf3fb", size = 1.2, speed = 1.0, family = 2,
            food = "Wolkenflausch", power = "Leicht wie eine Wolke",
            heart = "#d6eaf8",
            rescue_text = "Der Wolkendrache schwebt sanft heran - jetzt seid ihr Freunde.",
        },
        {
            id = "winddrache", name = "Winddrache", zone = "himmelsinseln",
            color = "#5dade2", size = 0.9, speed = 1.8,
            food = "Wind-Beeren", power = "Schnell wie der Wind",
            heart = "#aed6f1",
            rescue_text = "Der Winddrache saust eine Runde und landet bei dir.",
        },
        {
            id = "sonnendrache", name = "Sonnendrache", zone = "himmelsinseln",
            color = "#f1c40f", size = 1.1, speed = 1.0, glow = 8,
            food = "Sonnenstrahlen", power = "Warm und goldgelb",
            heart = "#fff2a8",
            rescue_text = "Der Sonnendrache strahlt - ihr seid Freunde geworden.",
        },
        {
            -- legendary, rare: never auto-spawns (egg/manual only)
            id = "sternendrache", name = "Sternendrache", zone = "himmelsinseln",
            color = "#f9e79f", size = 1.4, speed = 0.8, glow = 14, rare = true,
            food = "Sternenstaub", power = "Sehr selten und magisch",
            heart = "#fff2a8",
            rescue_text = "Der legendaere Sternendrache schenkt dir ein Funkeln am Himmel!",
        },
    },

    -- --- 5) Ranks (3rd field = colour -> creates a badge item) ---
    ranks = {
        { 0,  "Eierhueter" },
        { 5,  "Drachenfreund" },
        { 10, "Drachenreiter",  "#3498db" },
        { 25, "Drachenhueter",  "#27ae60" },
        { 50, "Drachenmeister", "#f1c40f" },
    },

    -- --- 6) Logbook item ---
    logbook = { title = "Drachen-Tagebuch", item_color = "#c0392b" },

    -- --- 7) Plain texts for curriculum codes (for /lernplan & boards) ---
    kompetenzen = {
        ["MA.1"]  = "Mengen erfassen und zaehlen (Eier zaehlen)",
        ["MA.2"]  = "Muster und Farben ordnen und zuordnen",
        ["NMG.1"] = "Verantwortung uebernehmen und fuer ein Tier sorgen",
        ["NMG.2"] = "Tiere und ihre Lebensraeume erkunden",
        ["NMG.3"] = "Geduld ueben, beobachten und warten koennen",
    },
})

-- ============================================================
--  THEME EXTRAS  (self-contained Lua the engine cannot express)
-- ============================================================

local DRAGON_COLORS = {
    "#e74c3c", "#e67e22", "#f1c40f", "#27ae60", "#2980b9", "#9b59b6", "#ecf3fb",
}

-- ------------------------------------------------------------
--  B) EXTRA: REITDRACHE  (rideable, flying dragon mount)
--  Not part of the engine - a self-contained mount the theme
--  adds on its own. Place -> right-click to mount -> W/S fly,
--  A/D steer, jump = up, sneak = down, right-click = dismount.
--  A second player can fly along (parent + child).
-- ------------------------------------------------------------
local DRAGON_SPEED = 6

core.register_entity(WORLD_ID .. ":reitdrache", {
    initial_properties = {
        physical = true, collide_with_objects = true,
        collisionbox = { -0.7, -0.5, -0.7, 0.7, 0.5, 0.7 },
        visual = "cube", visual_size = { x = 1.3, y = 1.0, z = 1.6 },
        textures = {
            "[fill:16x16:#c0392b", "[fill:16x16:#922b21",
            "[fill:16x16:#e74c3c", "[fill:16x16:#e74c3c",
            "[fill:16x16:#f1c40f", "[fill:16x16:#e74c3c",
        },
    },
    _driver = nil, _passenger = nil, _roar = nil, _flap = 0,

    on_rightclick = function(self, clicker)
        if not (clicker and clicker:is_player()) then return end
        local name = clicker:get_player_name()
        if self._driver == name then
            clicker:set_detach()
            clicker:set_eye_offset({ x = 0, y = 0, z = 0 }, { x = 0, y = 0, z = 0 })
            self._driver = nil
            self.object:set_properties({ glow = 0 })
            if self._roar then core.sound_stop(self._roar); self._roar = nil end
            core.chat_send_player(name, "Du steigst vom Reitdrachen ab.")
        elseif self._passenger == name then
            clicker:set_detach()
            clicker:set_eye_offset({ x = 0, y = 0, z = 0 }, { x = 0, y = 0, z = 0 })
            self._passenger = nil
            core.chat_send_player(name, "Du steigst als Mitflieger ab.")
        elseif not self._driver then
            clicker:set_attach(self.object, "", { x = 0, y = 6, z = -2 }, { x = 0, y = 0, z = 0 })
            self._driver = name
            self.object:set_properties({ glow = 9 })
            self._roar = core.sound_play(WORLD_ID .. "_fluegel",
                { object = self.object, loop = true, gain = 0.4 })
            core.chat_send_player(name,
                "Reitdrache geweckt! W/S fliegen, A/D lenken, Springen = hoch, " ..
                "Schleichen = runter, Rechtsklick = absteigen. " ..
                "(Ein zweiter Spieler kann mitfliegen!)")
        elseif not self._passenger then
            clicker:set_attach(self.object, "", { x = -4, y = 6, z = -2 }, { x = 0, y = 0, z = 0 })
            self._passenger = name
            core.chat_send_player(name, "Du fliegst als Mitflieger mit! Rechtsklick = absteigen.")
        end
    end,

    on_step = function(self, dtime)
        self.object:set_acceleration({ x = 0, y = 0, z = 0 })
        local driver = self._driver and core.get_player_by_name(self._driver)
        if not driver then
            self.object:set_velocity({ x = 0, y = 0, z = 0 })
            if self._roar then core.sound_stop(self._roar); self._roar = nil end
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
        local fwd = (ctrl.up and DRAGON_SPEED) or (ctrl.down and -DRAGON_SPEED * 0.5) or 0
        local vy  = (ctrl.jump and DRAGON_SPEED * 0.6) or (ctrl.sneak and -DRAGON_SPEED * 0.6) or 0
        self.object:set_velocity({ x = dir.x * fwd, y = vy, z = dir.z * fwd })

        -- warm spark trail while flying
        if fwd ~= 0 or vy ~= 0 then
            self._flap = (self._flap or 0) + dtime
            if self._flap > 0.25 then
                self._flap = 0
                local p = self.object:get_pos()
                core.add_particlespawner({
                    amount = 6, time = 0.2,
                    minpos = vector.subtract(p, 0.5), maxpos = vector.add(p, 0.5),
                    minvel = { x = -0.3, y = 0.2, z = -0.3 },
                    maxvel = { x = 0.3,  y = 0.8, z = 0.3 },
                    minexptime = 0.5, maxexptime = 1.0, minsize = 1, maxsize = 2,
                    texture = "[fill:8x8:#f39c12",
                })
            end
        end
    end,
})

core.register_craftitem(WORLD_ID .. ":reitdrache", {
    description = "Reitdrache (Reittier, fliegt)\nPlatzieren, dann Rechtsklick zum Aufsteigen",
    inventory_image = "[fill:16x16:#e74c3c^[fill:8x8:4,4:#f1c40f^[fill:4x4:2,6:#c0392b",
    on_place = function(itemstack, placer, pointed_thing)
        if pointed_thing.type ~= "node" or not (placer and placer:is_player()) then
            return itemstack
        end
        local pos = pointed_thing.above
        pos.y = pos.y + 0.5
        core.add_entity(pos, WORLD_ID .. ":reitdrache")
        if not core.is_creative_enabled(placer:get_player_name()) then
            itemstack:take_item()
        end
        return itemstack
    end,
})

-- ------------------------------------------------------------
--  C) EXTRA: DRACHENBABY + FUETTERN + ZAEHMEN
--  The theme's signature learning feature (Verantwortung & Geduld).
--  A baby dragon you feed again and again. Feeding has a PATIENCE
--  cooldown: feed too fast and the baby is "still full - wait a
--  moment". After enough patient feedings the baby TRUSTS you and
--  is tamed (Animalia / mobs_redo style: tame-by-feeding, with an
--  owner). A tamed baby gently follows its person. Fully self-
--  contained, so it works even without any mob API.
-- ------------------------------------------------------------
local FEED_GOAL     = 5    -- patient feedings until the baby is tamed
local FEED_COOLDOWN = 6    -- seconds the baby stays "full" between feeds

local function now_s()
    return core.get_us_time() / 1000000
end

local function baby_textures(col)
    return {
        "[fill:16x16:" .. col, "[fill:16x16:" .. col,
        "[fill:16x16:" .. col, "[fill:16x16:" .. col,
        -- a little face on the front
        "[fill:16x16:" .. col .. "^[fill:3x3:3,5:#ffffff^[fill:3x3:10,5:#ffffff" ..
            "^[fill:2x2:4,6:#1a1a1a^[fill:2x2:11,6:#1a1a1a^[fill:6x2:5,11:#1a1a1a",
        "[fill:16x16:" .. col,
    }
end

core.register_entity(WORLD_ID .. ":drachenbaby", {
    initial_properties = {
        physical = true, collide_with_objects = false,
        collisionbox = { -0.3, -0.3, -0.3, 0.3, 0.3, 0.3 },
        visual = "cube", visual_size = { x = 0.6, y = 0.6, z = 0.6 },
        textures = baby_textures("#e74c3c"),
        static_save = true,
    },
    _fed = 0, _tamed = false, _owner = nil, _last_feed = 0, _color = "#e74c3c", _wander = 0,

    on_activate = function(self, staticdata)
        if staticdata and staticdata ~= "" then
            local d = core.deserialize(staticdata)
            if type(d) == "table" then
                self._fed   = d.fed or 0
                self._tamed = d.tamed or false
                self._owner = d.owner
                self._color = d.color or "#e74c3c"
            end
        end
        self.object:set_properties({
            textures = baby_textures(self._color),
            glow = self._tamed and 6 or 0,
            visual_size = self._tamed and { x = 0.75, y = 0.75, z = 0.75 }
                                       or { x = 0.6, y = 0.6, z = 0.6 },
        })
        self.object:set_acceleration({ x = 0, y = -8, z = 0 })
    end,

    get_staticdata = function(self)
        return core.serialize({
            fed = self._fed, tamed = self._tamed,
            owner = self._owner, color = self._color,
        })
    end,

    on_rightclick = function(self, clicker)
        if not (clicker and clicker:is_player()) then return end
        local name = clicker:get_player_name()
        local pos  = self.object:get_pos()

        if self._tamed then
            core.chat_send_player(name, self._owner == name
                and "Dein Drachenbaby ist satt und gluecklich. Es folgt dir!"
                or  "Dieses Drachenbaby gehoert schon zu " .. (self._owner or "jemandem") .. ".")
            return
        end

        -- Must hold dragon food to feed.
        local wielded = clicker:get_wielded_item()
        if wielded:get_name() ~= WORLD_ID .. ":drachenfutter" then
            core.chat_send_player(name,
                "Das Drachenbaby hat Hunger! Nimm Drachenfutter (Beeren) in die Hand " ..
                "und fuettere es mit Rechtsklick. (" .. self._fed .. "/" .. FEED_GOAL .. " gefuettert)")
            return
        end

        -- Patience: the baby stays full for a while after each feed.
        local wait = FEED_COOLDOWN - (now_s() - (self._last_feed or 0))
        if wait > 0 then
            core.chat_send_player(name,
                "Das Baby ist noch satt - hab Geduld. Warte noch etwa " ..
                math.ceil(wait) .. " Sekunden.")
            return
        end

        -- Feed it.
        self._last_feed = now_s()
        self._fed = self._fed + 1
        if not core.is_creative_enabled(name) then
            wielded:take_item()
            clicker:set_wielded_item(wielded)
        end
        if pos then
            core.add_particlespawner({
                amount = 12, time = 0.3,
                minpos = vector.subtract(pos, 0.4), maxpos = vector.add(pos, 0.4),
                minvel = { x = -0.6, y = 1, z = -0.6 }, maxvel = { x = 0.6, y = 2, z = 0.6 },
                minexptime = 0.5, maxexptime = 1.0, minsize = 2, maxsize = 3,
                texture = "[fill:16x16:#ff5fa2",
            })
        end
        core.sound_play("lernwelt_rescue", { to_player = name, gain = 0.7 })

        if self._fed >= FEED_GOAL then
            -- Tamed! Reward + personal counter.
            self._tamed = true
            self._owner = name
            self.object:set_properties({
                glow = 6, visual_size = { x = 0.75, y = 0.75, z = 0.75 },
            })
            local meta = clicker:get_meta()
            local n = meta:get_int("lernwelt_drachenhort:gezaehmt") + 1
            meta:set_int("lernwelt_drachenhort:gezaehmt", n)
            core.sound_play("lernwelt_rankup", { to_player = name, gain = 1.0 })
            core.chat_send_player(name,
                "Geschafft! Du warst geduldig und hast gut gesorgt - das Drachenbaby " ..
                "vertraut dir jetzt und ist dein Freund! Gezaehmte Drachenbabys: " .. n)
        else
            core.chat_send_player(name,
                "Mmmh, lecker! Das Drachenbaby frisst. (" .. self._fed .. "/" .. FEED_GOAL ..
                ") Komm gleich wieder und fuettere weiter.")
        end
    end,

    on_step = function(self, dtime)
        self._wander = (self._wander or 0) + dtime

        -- A tamed baby gently follows its owner.
        if self._tamed and self._owner then
            local owner = core.get_player_by_name(self._owner)
            if owner then
                local p  = self.object:get_pos()
                local op = owner:get_pos()
                if p and op then
                    local d = vector.distance(p, op)
                    if d > 2.5 and d < 30 then
                        local dir = vector.direction(p, op)
                        local v = self.object:get_velocity()
                        self.object:set_velocity({ x = dir.x * 2, y = v.y, z = dir.z * 2 })
                        self.object:set_yaw(math.atan2(dir.z, dir.x) - math.pi / 2)
                        return
                    end
                end
            end
        end

        -- Otherwise a little idle wander + the occasional "hungry" heart.
        if self._wander > 2 then
            self._wander = 0
            local v = self.object:get_velocity()
            self.object:set_velocity({
                x = math.random(-1, 1), y = v.y, z = math.random(-1, 1),
            })
            if not self._tamed and (now_s() - (self._last_feed or 0)) > FEED_COOLDOWN then
                local pos = self.object:get_pos()
                if pos and math.random() < 0.5 then
                    core.add_particle({
                        pos = { x = pos.x, y = pos.y + 0.6, z = pos.z },
                        velocity = { x = 0, y = 0.6, z = 0 }, expirationtime = 1.0,
                        size = 2, texture = "[fill:16x16:#ff5fa2",
                    })
                end
            end
        end
    end,
})

-- Dragon food (berries) - the item you feed baby dragons with.
core.register_craftitem(WORLD_ID .. ":drachenfutter", {
    description = "Drachenfutter (Beeren)\nIn die Hand nehmen, dann ein Drachenbaby fuettern (Rechtsklick)",
    inventory_image = "[fill:16x16:#3b2a16^[fill:5x5:2,3:#e74c3c^[fill:5x5:9,3:#e74c3c" ..
                      "^[fill:5x5:2,9:#c0392b^[fill:5x5:9,9:#c0392b^[fill:3x3:6,6:#2ecc71",
    groups = { food = 1 },
})

-- ------------------------------------------------------------
--  D) EXTRA: EIER  (hatchable Brut-Ei + colourful counting eggs)
--  - "ei_<farbe>" are inert, egg-shaped nodes in five colours,
--    perfect for COUNTING and COLOUR-SORTING (MA.1 / MA.2).
--  - "brutei" is a warm, glowing egg you place; after a while it
--    HATCHES into a baby dragon you can then raise (see C).
-- ------------------------------------------------------------
local EGG_NODEBOX = {
    type = "fixed",
    fixed = {
        { -0.18, -0.5,  -0.18, 0.18, -0.30, 0.18 },
        { -0.24, -0.32, -0.24, 0.24,  0.06, 0.24 },
        { -0.16,  0.06, -0.16, 0.16,  0.28, 0.16 },
    },
}

local EGG_COLORS = {
    { suffix = "ei_rot",   name = "Drachenei (rot)",   color = "#e74c3c" },
    { suffix = "ei_blau",  name = "Drachenei (blau)",  color = "#2980b9" },
    { suffix = "ei_gruen", name = "Drachenei (gruen)", color = "#27ae60" },
    { suffix = "ei_gelb",  name = "Drachenei (gelb)",  color = "#f1c40f" },
    { suffix = "ei_lila",  name = "Drachenei (lila)",  color = "#8e44ad" },
}

for _, e in ipairs(EGG_COLORS) do
    core.register_node(WORLD_ID .. ":" .. e.suffix, {
        description = e.name .. "\nZum Zaehlen und Farben-Zuordnen",
        drawtype = "nodebox",
        node_box = EGG_NODEBOX,
        selection_box = EGG_NODEBOX,
        tiles = { "[fill:16x16:" .. e.color },
        inventory_image = "[fill:16x16:" .. e.color .. "^[fill:4x6:5,3:#ffffff^[opacity:90",
        paramtype = "light",
        sunlight_propagates = true,
        is_ground_content = false,
        groups = { oddly_breakable_by_hand = 3, dig_immediate = 3 },
    })
end

-- The hatchable "Brut-Ei": place it warm in a nest; it hatches.
local HATCH_TIME = 30

core.register_node(WORLD_ID .. ":brutei", {
    description = "Brut-Ei (warm)\nSetzen - nach kurzer Zeit schluepft ein Drachenbaby",
    drawtype = "nodebox",
    node_box = EGG_NODEBOX,
    selection_box = EGG_NODEBOX,
    tiles = { "[fill:16x16:#f5e6c8^[fill:4x4:6,2:#f39c12^[fill:3x3:3,8:#e67e22" ..
              "^[fill:3x3:10,9:#e67e22" },
    inventory_image = "[fill:16x16:#f5e6c8^[fill:5x5:5,3:#f39c12^[fill:3x3:3,9:#e67e22",
    paramtype = "light",
    light_source = 6,
    sunlight_propagates = true,
    is_ground_content = false,
    groups = { oddly_breakable_by_hand = 3, dig_immediate = 3 },
    after_place_node = function(pos, placer)
        if placer and placer:is_player() then
            core.get_meta(pos):set_string("planter", placer:get_player_name())
        end
        core.get_node_timer(pos):start(HATCH_TIME)
    end,
    on_timer = function(pos)
        local planter = core.get_meta(pos):get_string("planter")
        core.set_node(pos, { name = "air" })
        local obj = core.add_entity({ x = pos.x, y = pos.y + 0.3, z = pos.z },
            WORLD_ID .. ":drachenbaby")
        local le = obj and obj:get_luaentity()
        if le then
            le._color = DRAGON_COLORS[math.random(#DRAGON_COLORS)]
            obj:set_properties({ textures = baby_textures(le._color) })
        end
        core.add_particlespawner({
            amount = 20, time = 0.4,
            minpos = vector.subtract(pos, 0.5), maxpos = vector.add(pos, 0.5),
            minvel = { x = -1, y = 1, z = -1 }, maxvel = { x = 1, y = 2, z = 1 },
            minexptime = 0.6, maxexptime = 1.0, minsize = 2, maxsize = 4,
            texture = "[fill:16x16:#fff2a8",
        })
        if planter ~= "" then
            local p = core.get_player_by_name(planter)
            if p then
                local meta = p:get_meta()
                local n = meta:get_int("lernwelt_drachenhort:ausgebruetet") + 1
                meta:set_int("lernwelt_drachenhort:ausgebruetet", n)
                core.sound_play("lernwelt_rescue", { to_player = planter, gain = 0.7 })
                core.chat_send_player(planter,
                    "Ein Drachenbaby ist geschluepft! Fuettere es geduldig mit Drachenfutter, " ..
                    "bis es dir vertraut. Ausgebruetete Eier: " .. n)
            end
        end
        return false
    end,
})

-- ------------------------------------------------------------
--  E) EXTRA: STARTER KIT  (handed out once on first join)
--  Makes the world testable right away: the logbook, the camera,
--  the Reitdrache, dragon food, a Brut-Ei, a stack of each dragon
--  block + counting eggs, and one spawn egg per dragon (the engine
--  registers those when a mob API is present; missing items are
--  simply skipped). Turn off via "lernwelt_drachenhort_starter_kit".
-- ------------------------------------------------------------
local STARTER_BLOCKS = {
    "drachenstein_rot", "drachenstein_blau", "drachenstein_gruen",
    "drachenstein_gelb", "drachenstein_lila", "bergstein", "wolkenblock",
    "kristallglas", "nest", "goldhort",
    "ei_rot", "ei_blau", "ei_gruen", "ei_gelb", "ei_lila",
}
-- Spawn-egg item names match the creature ids (world_id:creature_id)
local STARTER_EGGS = {
    "glutdrache", "funkendrache", "beerendrache", "felsendrache",
    "smaragddrache", "kristalldrache", "wolkendrache", "winddrache",
    "sonnendrache", "sternendrache",
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
    give_if_exists(inv, WORLD_ID .. ":reitdrache")
    give_if_exists(inv, WORLD_ID .. ":drachenfutter 20")
    give_if_exists(inv, WORLD_ID .. ":brutei 3")
    for _, suffix in ipairs(STARTER_BLOCKS) do
        give_if_exists(inv, WORLD_ID .. ":" .. suffix .. " 10")
    end
    for _, cid in ipairs(STARTER_EGGS) do
        give_if_exists(inv, WORLD_ID .. ":" .. cid)
    end
    core.chat_send_player(player:get_player_name(),
        "Drachenhort: Startausruestung erhalten - Drachen-Tagebuch, Kamera, Reitdrache, " ..
        "Drachenfutter, Brut-Eier, Bau-Bloecke, Zaehl-Eier und Spawn-Eier sind in deinem " ..
        "Inventar. Brut-Ei setzen, Baby fuettern - und losfliegen. Viel Spass!")
end

core.register_on_joinplayer(function(player)
    if not core.settings:get_bool("lernwelt_drachenhort_starter_kit", true) then return end
    local meta = player:get_meta()
    if meta:get_int("lernwelt_drachenhort:starter_given") == 1 then return end
    meta:set_int("lernwelt_drachenhort:starter_given", 1)
    -- slight delay so the inventory exists and the message is seen
    core.after(1.5, function()
        if player and player:is_player() then give_starter_kit(player) end
    end)
end)

-- ------------------------------------------------------------
--  F) EXTRA: LAND SPAWNER  (a living dragon world)
--  The engine's built-in spawner only places water animals, so
--  this small, backend-agnostic spawner brings the land-walking
--  dragons to life: every so often it tries to add one non-rare,
--  non-swimming dragon on solid ground with air above, near a
--  player, capped so the world never gets crowded. Turn off with
--  the setting "lernwelt_spawn_creatures".
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
--  G) EXTRA: TEST STATION  (chat command for quick setup)
--  "/drachenhort_teststation" builds a small ready-made spot in
--  front of you: a stone floor, the three learning boards, a
--  Reitdrache, a row of counting eggs and a Brut-Ei. Handy for
--  testing or for an adult to prepare the world. Priv: server.
-- ------------------------------------------------------------
local STATION_BOARDS = {
    WORLD_ID .. ":tafel_berg",
    WORLD_ID .. ":tafel_krater",
    WORLD_ID .. ":tafel_himmelsinseln",
}

local function build_test_station(player)
    local base    = vector.round(player:get_pos())
    local floor_y = base.y - 1
    local floor   = WORLD_ID .. ":bergstein"

    -- 7 wide (x: -3..3) x 4 deep (z: +2..+5) stone floor in front of you
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

    -- a nest with a row of counting eggs (count them!)
    core.set_node({ x = base.x, y = floor_y + 1, z = base.z + 2 }, { name = WORLD_ID .. ":nest" })
    local eggs = { "ei_rot", "ei_blau", "ei_gruen", "ei_gelb" }
    for i, e in ipairs(eggs) do
        core.set_node({ x = base.x - 2 + i, y = floor_y + 1, z = base.z + 2 },
            { name = WORLD_ID .. ":" .. e })
    end

    -- a Brut-Ei ready to hatch + a Reitdrache ready to ride
    core.set_node({ x = base.x + 3, y = floor_y + 1, z = base.z + 2 }, { name = WORLD_ID .. ":brutei" })
    core.add_entity({ x = base.x, y = floor_y + 1.5, z = base.z + 5 }, WORLD_ID .. ":reitdrache")
end

core.register_chatcommand("drachenhort_teststation", {
    description = "Baut eine kleine Drachenhort-Test-Station vor dir " ..
                  "(Boden, 3 Lern-Tafeln, Zaehl-Eier, Brut-Ei, Reitdrache)",
    privs = { server = true },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then
            return false, "Dieser Befehl funktioniert nur im Spiel."
        end
        build_test_station(player)
        return true, "Test-Station gebaut! Sie steht vor dir Richtung Norden (+Z): " ..
                     "Boden, drei Lern-Tafeln, ein Nest mit Zaehl-Eiern, ein Brut-Ei " ..
                     "und ein Reitdrache."
    end,
})

-- ------------------------------------------------------------
--  H) EXTRA: DRACHENNEST  (the signature base)
--  "/drachenhort_nest" builds a big dragon nest/hort in front of
--  you: a stone platform, a low rim, a golden hoard in the middle
--  surrounded by a clutch of eggs to count, the three learning
--  boards, a Brut-Ei and a Reitdrache. Priv: server.
-- ------------------------------------------------------------
core.register_chatcommand("drachenhort_nest", {
    description = "Baut ein grosses Drachennest vor dir (Plattform, Goldhort, Eier, Tafeln, Reitdrache)",
    privs = { server = true },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then return false, "Dieser Befehl funktioniert nur im Spiel." end
        local b     = vector.round(player:get_pos())
        local stone = WORLD_ID .. ":bergstein"
        local nest  = WORLD_ID .. ":nest"
        local R, fy = 6, b.y - 1
        local z0    = b.z + 2

        -- round-ish platform of stone with a nest rim
        for dx = -R, R do
            for dz = 0, 2 * R do
                local x, z = b.x + dx, z0 + dz
                local ddx, ddz = dx, dz - R
                if ddx * ddx + ddz * ddz <= R * R then
                    core.set_node({ x = x, y = fy, z = z }, { name = stone })
                    -- a one-block nest rim around the edge
                    local edge = (ddx * ddx + ddz * ddz) > (R - 1) * (R - 1)
                    if edge then
                        core.set_node({ x = x, y = fy + 1, z = z }, { name = nest })
                    end
                end
            end
        end

        -- golden hoard in the middle, ringed by a clutch of eggs to count
        local cz = z0 + R
        core.set_node({ x = b.x, y = fy + 1, z = cz }, { name = WORLD_ID .. ":goldhort" })
        local egg_nodes = { "ei_rot", "ei_blau", "ei_gruen", "ei_gelb", "ei_lila" }
        local ring = { { -1, 0 }, { 1, 0 }, { 0, -1 }, { 0, 1 }, { -1, -1 }, { 1, 1 } }
        for i, r in ipairs(ring) do
            core.set_node({ x = b.x + r[1], y = fy + 1, z = cz + r[2] },
                { name = WORLD_ID .. ":" .. egg_nodes[((i - 1) % #egg_nodes) + 1] })
        end

        -- three learning boards along the back
        local boards = { "tafel_berg", "tafel_krater", "tafel_himmelsinseln" }
        local xs = { -2, 0, 2 }
        for i, bd in ipairs(boards) do
            local nn = WORLD_ID .. ":" .. bd
            if core.registered_nodes[nn] then
                core.set_node({ x = b.x + xs[i], y = fy + 1, z = z0 + 1 }, { name = nn, param2 = 2 })
            end
        end

        -- a Brut-Ei to hatch and a Reitdrache to fly
        core.set_node({ x = b.x + 2, y = fy + 1, z = cz }, { name = WORLD_ID .. ":brutei" })
        core.add_entity({ x = b.x, y = fy + 1.5, z = z0 + 2 * R - 1 }, WORLD_ID .. ":reitdrache")

        return true, "Drachennest gebaut! Plattform mit Nest-Rand, Goldhort und Eiern " ..
                     "zum Zaehlen, drei Tafeln, ein Brut-Ei und ein Reitdrache."
    end,
})

-- ------------------------------------------------------------
--  I) EXTRA: DRACHENBABY SPAWNEN  (for testing)
--  "/drachenhort_baby" drops a fresh, hungry baby dragon in front
--  of you to feed and tame. Priv: server.
-- ------------------------------------------------------------
core.register_chatcommand("drachenhort_baby", {
    description = "Setzt ein hungriges Drachenbaby vor dir aus (zum Fuettern/Zaehmen testen)",
    privs = { server = true },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then return false, "Dieser Befehl funktioniert nur im Spiel." end
        local pos = player:get_pos()
        local dir = player:get_look_dir()
        local sp  = { x = pos.x + dir.x * 2, y = pos.y + 1, z = pos.z + dir.z * 2 }
        local obj = core.add_entity(sp, WORLD_ID .. ":drachenbaby")
        local le  = obj and obj:get_luaentity()
        if le then
            le._color = DRAGON_COLORS[math.random(#DRAGON_COLORS)]
            obj:set_properties({ textures = baby_textures(le._color) })
        end
        return true, "Ein Drachenbaby wartet vor dir. Nimm Drachenfutter in die Hand " ..
                     "und fuettere es geduldig (Rechtsklick), bis es dir vertraut."
    end,
})

-- ------------------------------------------------------------
--  J) EXTRA: AMBIENT-SOUND  (gentle dragon calls / wing flaps)
--  Plays a soft dragon sound to each player now and then. The
--  .ogg files are optional (missing = silent, only a warning).
-- ------------------------------------------------------------
local amb_timer, amb_next = 0, 45
core.register_globalstep(function(dtime)
    amb_timer = amb_timer + dtime
    if amb_timer < amb_next then return end
    amb_timer = 0
    amb_next = 35 + math.random(0, 40)
    for _, player in ipairs(core.get_connected_players()) do
        local snd = (math.random() < 0.5) and "_drache" or "_ambient"
        core.sound_play(WORLD_ID .. snd, { to_player = player:get_player_name(), gain = 0.4 })
    end
end)

-- ------------------------------------------------------------
--  K) EXTRA: BUCHSTABEN-BLOECKE  (A-Z, zum Woerterlegen)
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

core.log("action", "[lernwelt_drachenhort] Theme 'Drachenhort' registered (on lernwelt engine).")
