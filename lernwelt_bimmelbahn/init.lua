-- ============================================================
--  THEME:  BIMMELBAHN-LAND  (little colourful trains)
--  A brand-free railway learning world built ON TOP of the
--  reusable "lernwelt" engine. Almost everything below is one
--  declarative register_world{...} call - blocks, learning
--  zones, friendly passengers, logbook, ranks and badges all
--  come from the engine.
--
--  The base is a "Hauptbahnhof" (main station). The world is made
--  of several COLOURFUL VILLAGES, connected by rails:
--    * Hauptbahnhof - the central station (plan the routes)
--    * Rotdorf      - the red village
--    * Gelbdorf     - the yellow village
--    * Blaudorf     - the blue village
--    * Gruendorf    - the green village
--
--  Learning goals: ROUTES & the ORDER of the stations (sequence
--  thinking, MI "Reihenfolge"), simple SWITCH/SIGNAL logic
--  (a tiny, simplified Mesecons / Basic-Trains idea: wenn-dann),
--  and matching COLOURS to villages. Tagged to the Swiss
--  curriculum (Lehrplan 21, cycle 1): mainly MI (Medien und
--  Informatik), Mathematik (Muster/Reihen) and BG (Farben).
--
--  Things the engine cannot express live as small pieces of
--  custom code after register_world:
--    B) the drivable "Bimmelbahn" (a little steam train, 2 seats)
--    C) a starter kit handed out on first join (quick testing)
--    D) a ready-made test station (chat command)
--    E) "ROUTEN-AUFTRAG" - visit the colour stations in the right
--       ORDER (the heart: sequence / Reihenfolge)
--    F) WEICHE + SIGNAL + a self-running demo train (switch logic)
--    G) a gentle passenger spawner so the villages feel alive
--    H) a bigger Hauptbahnhof base (chat command)
--    I) ambient sound (whistle + station bell)
--    J) letter blocks A-Z (station names) + number blocks 0-9
--    K) a "Wagen-Parade" command: line up colourful wagons
--
--  The mod name equals the world id ("lernwelt_bimmelbahn"), so
--  all nodes/items live in the "lernwelt_bimmelbahn:" namespace.
--
--  Content is authored in German (ASCII: ae/oe/ue), like the
--  other example themes. The engine's own UI is translated
--  separately via lernwelt/locale/*.tr.
-- ============================================================

local WORLD_ID = "lernwelt_bimmelbahn"
local function L(suffix) return WORLD_ID .. ":" .. suffix end

-- The four village colours used everywhere (stations, routes,
-- wagons, pattern tasks). id -> display name + hex.
local COLORS = {
    { id = "rot",   name = "Rot",   hex = "#e74c3c" },
    { id = "gelb",  name = "Gelb",  hex = "#f1c40f" },
    { id = "blau",  name = "Blau",  hex = "#3498db" },
    { id = "gruen", name = "Gruen", hex = "#27ae60" },
}
local function color_name(id)
    for _, c in ipairs(COLORS) do if c.id == id then return c.name end end
    return id
end

-- ------------------------------------------------------------
--  A) THE WHOLE LEARNING WORLD AS ONE DECLARATIVE TABLE
-- ------------------------------------------------------------
lernwelt.register_world({

    -- internal prefix; kept identical to the mod name so all
    -- nodes/items live in the "lernwelt_bimmelbahn:" namespace
    id    = WORLD_ID,
    title = "Bimmelbahn-Land",

    -- --- 1) Peaceful, child-friendly world ---
    config = {
        damage      = false,   -- no damage / no dying
        creative    = true,    -- unlimited blocks
        peaceful    = true,    -- no monsters
        freeze_time = "day",   -- always bright (no scary nights)
        no_weather  = true,
    },

    -- --- 2) Railway + village blocks (no PNG needed) ---
    blocks = {
        { suffix = "bahnsteig",    name = "Bahnsteig",            color = "#bdc3c7" },
        { suffix = "kies",         name = "Gleisbett (Schotter)", color = "#95a5a6" },
        { suffix = "backstein",    name = "Bahnhofs-Backstein",   color = "#c0392b" },
        { suffix = "holzbohle",    name = "Holz-Bohle",           color = "#8d6e3a" },
        { suffix = "bahnhofsglas", name = "Bahnhofs-Glas",        color = "#aaddff", glass = true },
        { suffix = "bahnhofslampe", name = "Bahnhofs-Lampe",      color = "#fff7cc", glow = 12 },

        -- The four colourful village house blocks (colour matching).
        { suffix = "haus_rot",   name = "Haus (Rotdorf)",   color = "#e74c3c" },
        { suffix = "haus_gelb",  name = "Haus (Gelbdorf)",  color = "#f1c40f" },
        { suffix = "haus_blau",  name = "Haus (Blaudorf)",  color = "#3498db" },
        { suffix = "haus_gruen", name = "Haus (Gruendorf)", color = "#27ae60" },

        -- Patterned decoration blocks (procedural, no image files needed).
        -- The "texture" field is a Luanti texture-modifier string: a base
        -- "[fill" plus overlaid "^[fill:WxH:X,Y:#colour" rectangles.
        { suffix = "schiene", name = "Schiene (Gleis)",
          texture = "[fill:16x16:#6e552c^[fill:16x2:0,2:#4a3520^[fill:16x2:0,12:#4a3520" ..
                    "^[fill:2x16:3,0:#7f8c8d^[fill:2x16:11,0:#7f8c8d" },
        { suffix = "muster_bahnuebergang", name = "Bahnuebergang-Block",
          texture = "[fill:16x16:#2c3e50^[fill:16x3:0,1:#f1c40f" ..
                    "^[fill:16x3:0,7:#f1c40f^[fill:16x3:0,13:#f1c40f" },
        { suffix = "muster_zugfenster", name = "Zug-Fenster-Block",
          texture = "[fill:16x16:#c0392b^[fill:6x6:2,3:#aaddff" ..
                    "^[fill:6x6:8,3:#aaddff^[fill:14x2:1,11:#7d3c30" },
        { suffix = "muster_backstein", name = "Backstein-Block",
          texture = "[fill:16x16:#c0392b^[fill:16x1:0,5:#922b21^[fill:16x1:0,11:#922b21" ..
                    "^[fill:1x5:7,0:#922b21^[fill:1x6:0,6:#922b21^[fill:1x6:15,6:#922b21" ..
                    "^[fill:1x5:7,12:#922b21" },
        { suffix = "muster_schach", name = "Bahnhofsboden-Block",
          texture = "[fill:16x16:#ecf0f1^[fill:8x8:0,0:#34495e^[fill:8x8:8,8:#34495e" },
        { suffix = "muster_konfetti", name = "Konfetti-Block",
          texture = "[fill:16x16:#ffffff^[fill:3x3:2,2:#e74c3c^[fill:3x3:11,3:#3498db" ..
                    "^[fill:3x3:6,7:#f1c40f^[fill:3x3:1,11:#27ae60^[fill:3x3:12,11:#e74c3c" },

        -- The four colourful wagons (used by the "Wagen-Parade").
        { suffix = "wagen_rot",   name = "Wagen (rot)",
          texture = "[fill:16x16:#e74c3c^[fill:5x5:2,3:#fdf2e9^[fill:5x5:9,3:#fdf2e9^[fill:14x2:1,12:#7d3c30" },
        { suffix = "wagen_gelb",  name = "Wagen (gelb)",
          texture = "[fill:16x16:#f1c40f^[fill:5x5:2,3:#fdf2e9^[fill:5x5:9,3:#fdf2e9^[fill:14x2:1,12:#7d6608" },
        { suffix = "wagen_blau",  name = "Wagen (blau)",
          texture = "[fill:16x16:#3498db^[fill:5x5:2,3:#fdf2e9^[fill:5x5:9,3:#fdf2e9^[fill:14x2:1,12:#21618c" },
        { suffix = "wagen_gruen", name = "Wagen (gruen)",
          texture = "[fill:16x16:#27ae60^[fill:5x5:2,3:#fdf2e9^[fill:5x5:9,3:#fdf2e9^[fill:14x2:1,12:#196f3d" },

        -- Per-face blocks: a real station clock and a suitcase crate.
        { suffix = "bahnhofsuhr", name = "Bahnhofs-Uhr",
          top    = "[fill:16x16:#ffffff^[fill:14x14:1,1:#ecf0f1^[fill:2x6:7,2:#2c3e50" ..
                   "^[fill:5x2:7,7:#2c3e50^[fill:2x2:7,7:#c0392b",
          side   = "[fill:16x16:#c0392b^[fill:16x1:0,5:#922b21^[fill:16x1:0,11:#922b21",
          bottom = "[fill:16x16:#7d3c30" },
        { suffix = "koffer", name = "Reise-Koffer",
          top    = "[fill:16x16:#8d6e3a^[fill:6x2:5,0:#5d4326^[fill:16x2:0,7:#5d4326",
          side   = "[fill:16x16:#8d6e3a^[fill:16x2:0,5:#5d4326^[fill:16x2:0,10:#5d4326^[fill:3x2:6,2:#cda36a",
          bottom = "[fill:16x16:#5d4326" },

        -- Prellbock (buffer stop) - end of the track.
        { suffix = "prellbock", name = "Prellbock (Gleis-Ende)",
          texture = "[fill:16x16:#34495e^[fill:16x4:0,2:#e74c3c^[fill:16x4:0,10:#e74c3c" },

        -- Eigenes gemaltes Bild als Block? Lege eine PNG (16x16 oder 32x32)
        -- "lernwelt_bimmelbahn_meinbild.png" in den textures/-Ordner und entferne
        -- die zwei Minuszeichen vor der naechsten Zeile:
        -- { suffix = "meinbild", name = "Mein Bild", texture = "lernwelt_bimmelbahn_meinbild.png" },
    },

    -- --- 3) Learning zones (each gets a placeable learning board) ---
    -- The Hauptbahnhof teaches routes/order; each village teaches its
    -- colour. Zone titles double as the "home" shown in the logbook.
    zones = {
        {
            id = "hauptbahnhof", title = "Hauptbahnhof", color = "#34495e",
            activity = "Routen planen: in welcher REIHENFOLGE faehrt der Zug die " ..
                       "bunten Doerfer an? Hol dir am Fahrplan-Pult einen Fahrauftrag " ..
                       "und halte an den Stationen in der richtigen Reihenfolge.",
            lehrplan = { "MI.1", "MA.2", "NMG.7" },
            tasks = {
                { type = "pattern",
                  sequence = { "#e74c3c", "#3498db", "#f1c40f" },
                  palette  = { { "#e74c3c", "Rot" }, { "#f1c40f", "Gelb" },
                               { "#3498db", "Blau" }, { "#27ae60", "Gruen" } },
                  done = "Super! Die Route stimmt: Rot - Blau - Gelb." },
                { type = "quiz", question = "Was machst du an einer WEICHE?",
                  options = { "Den Weg umstellen", "Schlafen", "Picknick machen" }, answer = 1,
                  done = "Richtig! An der Weiche stellst du den Weg um - links oder rechts." },
                { type = "quiz", question = "Reihenfolge: erst Rot, dann Blau. Welche Station kommt ZUERST?",
                  options = { "Rot", "Blau" }, answer = 1,
                  done = "Richtig! Zuerst Rot, dann Blau." },
                { type = "rescue", creature = "schaffner_maus", count = 1,
                  done = "Klasse! Die Schaffner-Maus am Bahnhof begruesst." },
            },
        },
        {
            id = "rotdorf", title = "Rotdorf", color = "#e74c3c",
            activity = "Das ROTE Dorf: rote Haeuser und rote Fahrgaeste. " ..
                       "Welche Dinge sind rot? Farben zuordnen.",
            lehrplan = { "BG.1", "D.2", "MA.1" },
            tasks = {
                { type = "quiz", question = "Welche Farbe hat dieses Dorf?",
                  options = { "Rot", "Blau", "Gruen" }, answer = 1,
                  done = "Richtig! Rotdorf ist rot." },
                { type = "pattern",
                  sequence = { "#e74c3c", "#f1c40f", "#e74c3c" },
                  palette  = { { "#e74c3c", "Rot" }, { "#f1c40f", "Gelb" }, { "#3498db", "Blau" } },
                  done = "Super! Muster Rot - Gelb - Rot gelegt." },
                { type = "rescue", creature = "rote_reisekatze", count = 1,
                  done = "Toll! Die rote Reise-Katze steigt ein." },
            },
        },
        {
            id = "gelbdorf", title = "Gelbdorf", color = "#f1c40f",
            activity = "Das GELBE Dorf: gelbe Haeuser und gelbe Fahrgaeste. " ..
                       "Farben zuordnen und Fahrgaeste zaehlen.",
            lehrplan = { "BG.1", "MA.1", "D.2" },
            tasks = {
                { type = "quiz", question = "Welche Farbe hat dieses Dorf?",
                  options = { "Gelb", "Rot", "Blau" }, answer = 1,
                  done = "Richtig! Gelbdorf ist gelb." },
                { type = "quiz", question = "Am Bahnsteig warten 2 Entlein. Wie viele sind das?",
                  options = { "2", "3", "5" }, answer = 1,
                  done = "Richtig gezaehlt! Es sind 2 Entlein." },
                { type = "rescue", creature = "gelbes_entlein", count = 2,
                  done = "Klasse! Zwei gelbe Entlein abgeholt." },
            },
        },
        {
            id = "blaudorf", title = "Blaudorf", color = "#3498db",
            activity = "Das BLAUE Dorf: blaue Haeuser und blaue Fahrgaeste. " ..
                       "Farben zuordnen und die Wagen zaehlen.",
            lehrplan = { "BG.1", "MA.1", "MA.2" },
            tasks = {
                { type = "quiz", question = "Welche Farbe hat dieses Dorf?",
                  options = { "Blau", "Gelb", "Gruen" }, answer = 1,
                  done = "Richtig! Blaudorf ist blau." },
                { type = "quiz", question = "Der Zug hat 4 Wagen. Wie viele sind das?",
                  options = { "4", "2", "6" }, answer = 1,
                  done = "Richtig gezaehlt! Vier Wagen." },
                { type = "rescue", creature = "blauer_papagei", count = 1,
                  done = "Toll! Der blaue Reise-Papagei ruft 'Einsteigen!'." },
            },
        },
        {
            id = "gruendorf", title = "Gruendorf", color = "#27ae60",
            activity = "Das GRUENE Dorf: gruene Haeuser und gruene Fahrgaeste. " ..
                       "Farben zuordnen und ein Muster legen.",
            lehrplan = { "BG.1", "MA.2", "D.2" },
            tasks = {
                { type = "quiz", question = "Welche Farbe hat dieses Dorf?",
                  options = { "Gruen", "Rot", "Gelb" }, answer = 1,
                  done = "Richtig! Gruendorf ist gruen." },
                { type = "pattern",
                  sequence = { "#27ae60", "#3498db", "#27ae60", "#3498db" },
                  palette  = { { "#27ae60", "Gruen" }, { "#3498db", "Blau" }, { "#e74c3c", "Rot" } },
                  done = "Super! Muster Gruen - Blau - Gruen - Blau gelegt." },
                { type = "rescue", creature = "gruener_frosch", count = 2,
                  done = "Klasse! Zwei gruene Reise-Froesche abgeholt." },
            },
        },
    },

    -- --- 4) Friendly passengers (peaceful; right-click = greet/board) ---
    creatures = {
        -- Hauptbahnhof - the station crew
        {
            id = "schaffner_maus", name = "Schaffner-Maus", zone = "hauptbahnhof",
            color = "#95a5a6", size = 0.7, speed = 1.0,
            food = "Kaese-Brote", power = "Ruft die Stationen aus",
            heart = "#d5dbdb",
            rescue_text = "Begruesst! Die Schaffner-Maus winkt mit der Kelle: 'Einsteigen bitte!'",
        },
        {
            id = "bahnhofs_hund", name = "Bahnhofs-Hund", zone = "hauptbahnhof",
            color = "#a0522d", size = 0.9, speed = 1.1, family = 1,
            food = "Hundekuchen", power = "Bewacht den Bahnhof",
            heart = "#e6b89c",
            rescue_text = "Begruesst! Der Bahnhofs-Hund wedelt freudig mit dem Schwanz.",
        },
        {
            id = "gepaeck_igel", name = "Gepaeck-Igel", zone = "hauptbahnhof",
            color = "#6e552c", size = 0.6, speed = 0.7,
            food = "Beeren", power = "Traegt die Koffer",
            heart = "#c8b08a",
            rescue_text = "Begruesst! Der Gepaeck-Igel rollt einen Koffer zum Zug.",
        },

        -- Rotdorf
        {
            id = "rote_reisekatze", name = "Rote Reise-Katze", zone = "rotdorf",
            color = "#e74c3c", size = 0.7, speed = 1.1,
            food = "Milch", power = "Schnurrt im Zug",
            heart = "#f5b7b1",
            rescue_text = "Begruesst! Die rote Reise-Katze springt schnurrend in den Wagen.",
        },
        {
            id = "roter_fuchs", name = "Reise-Fuchs", zone = "rotdorf",
            color = "#d35400", size = 0.8, speed = 1.2,
            food = "Beeren", power = "Kennt alle Wege",
            heart = "#edbb99",
            rescue_text = "Begruesst! Der Reise-Fuchs kennt jede Strecke und winkt dir zu.",
        },

        -- Gelbdorf
        {
            id = "gelbes_entlein", name = "Gelbes Entlein", zone = "gelbdorf",
            color = "#f1c40f", size = 0.6, speed = 0.9, family = 1,
            food = "Koerner", power = "Watschelt zum Zug",
            heart = "#f9e79f",
            rescue_text = "Begruesst! Das gelbe Entlein watschelt schnatternd auf den Bahnsteig.",
        },
        {
            id = "sonnen_kanari", name = "Sonnen-Kanari", zone = "gelbdorf",
            color = "#f7dc6f", size = 0.5, speed = 1.3,
            food = "Koerner", power = "Singt das Abfahrtslied",
            heart = "#fcf3cf",
            rescue_text = "Begruesst! Der Sonnen-Kanari traellert das Abfahrtslied. Tirili!",
        },

        -- Blaudorf
        {
            id = "blauer_papagei", name = "Blauer Reise-Papagei", zone = "blaudorf",
            color = "#3498db", size = 0.7, speed = 1.0,
            food = "Nuesse", power = "Ruft 'Einsteigen!'",
            heart = "#aed6f1",
            rescue_text = "Begruesst! Der blaue Papagei ruft laut: 'Einsteigen! Tueren schliessen!'",
        },
        {
            id = "blaues_haeschen", name = "Blaues Reise-Haeschen", zone = "blaudorf",
            color = "#5dade2", size = 0.6, speed = 1.2, family = 1,
            food = "Karotten", power = "Huepft auf den Bahnsteig",
            heart = "#d4e6f1",
            rescue_text = "Begruesst! Das blaue Haeschen huepft froehlich auf den Bahnsteig.",
        },

        -- Gruendorf
        {
            id = "gruener_frosch", name = "Gruener Reise-Frosch", zone = "gruendorf",
            color = "#27ae60", size = 0.6, speed = 1.0, family = 1,
            food = "Fliegen", power = "Quakt den Fahrplan",
            heart = "#abebc6",
            rescue_text = "Begruesst! Der gruene Reise-Frosch quakt vergnuegt den Fahrplan.",
        },
        {
            id = "gruene_schildkroete", name = "Gruene Schildkroete", zone = "gruendorf",
            color = "#52be80", size = 0.7, speed = 0.4,
            food = "Salat", power = "Reist ganz gemuetlich",
            heart = "#d5f5e3",
            rescue_text = "Begruesst! Die gruene Schildkroete reist gemuetlich und laechelt.",
        },

        -- legendary, rare: never auto-spawns (spawn egg / manual only)
        {
            id = "goldene_reise_eule", name = "Goldene Reise-Eule", zone = "hauptbahnhof",
            color = "#f1c40f", size = 0.8, speed = 0.9, glow = 8, rare = true,
            food = "Sternenlicht", power = "Sehr selten, leuchtet golden",
            heart = "#fff2a8",
            rescue_text = "Die seltene Goldene Reise-Eule landet auf dem Bahnsteig und leuchtet golden!",
        },
    },

    -- --- 5) Ranks (3rd field = colour -> creates a badge item) ---
    ranks = {
        { 0,  "Fahrgast" },
        { 5,  "Schaffner-Lehrling" },
        { 10, "Schaffner",   "#3498db" },
        { 25, "Lokfuehrer",  "#27ae60" },
        { 50, "Bahnchef",    "#f1c40f" },
    },

    -- --- 6) Logbook item ---
    logbook = { title = "Bahnhofs-Logbuch", item_color = "#c0392b" },

    -- --- 7) Plain texts for curriculum codes (for /lernplan & boards) ---
    kompetenzen = {
        ["MI.1"]  = "Ablaeufe und Reihenfolgen planen (Routen, Stationen ordnen)",
        ["MI.2"]  = "Einfache Logik: Weichen und Signale stellen (wenn - dann)",
        ["MA.1"]  = "Mengen erfassen und zaehlen (Wagen, Stationen, Fahrgaeste)",
        ["MA.2"]  = "Muster und Reihen ordnen und fortsetzen",
        ["NMG.7"] = "Verkehr und Wege: die Eisenbahn kennenlernen",
        ["BG.1"]  = "Farben erkennen und zuordnen",
        ["TTG.2"] = "Technik verstehen: Schienen, Weichen, Signale",
        ["D.2"]   = "Stationen und Farben benennen",
        ["BS.2"]  = "Sich geschickt bewegen (ein- und aussteigen)",
    },
})

-- ============================================================
--  THEME EXTRAS  (self-contained Lua the engine cannot express)
-- ============================================================

-- ------------------------------------------------------------
--  B) EXTRA: BIMMELBAHN  (drivable little steam train)
--  Not part of the engine - a self-contained vehicle the theme
--  adds on its own. A friendly red loco that rolls on the ground.
--  Controls: place -> right-click to board -> W/S drive, A/D
--  steer, jump = whistle (toot!) + a small hop, right-click =
--  exit. A second player (parent + child) can ride along.
-- ------------------------------------------------------------
local TRAIN_SPEED = 6

core.register_entity(L("bimmelbahn"), {
    initial_properties = {
        physical = true, collide_with_objects = true,
        collisionbox = { -0.6, -0.4, -0.9, 0.6, 0.5, 0.9 },
        visual = "cube", visual_size = { x = 1.2, y = 0.95, z = 1.8 },
        textures = {
            "[fill:16x16:#c0392b^[fill:6x6:5,2:#2c3e50",          -- top (with chimney)
            "[fill:16x16:#7d3c30",                                -- bottom
            "[fill:16x16:#c0392b^[fill:6x6:2,3:#aaddff^[fill:6x6:8,3:#aaddff", -- right (window car)
            "[fill:16x16:#c0392b^[fill:6x6:2,3:#aaddff^[fill:6x6:8,3:#aaddff", -- left
            "[fill:16x16:#922b21^[fill:8x8:4,4:#2c3e50^[fill:4x4:6,6:#f1c40f", -- front (boiler + lamp)
            "[fill:16x16:#c0392b^[fill:6x6:5,5:#2c3e50",          -- back
        },
    },
    _driver = nil, _passenger = nil, _steam = 0,

    on_rightclick = function(self, clicker)
        if not (clicker and clicker:is_player()) then return end
        local name = clicker:get_player_name()
        if self._driver == name then
            clicker:set_detach()
            clicker:set_eye_offset({ x = 0, y = 0, z = 0 }, { x = 0, y = 0, z = 0 })
            self._driver = nil
            core.chat_send_player(name, "Du steigst aus der Bimmelbahn aus.")
        elseif self._passenger == name then
            clicker:set_detach()
            clicker:set_eye_offset({ x = 0, y = 0, z = 0 }, { x = 0, y = 0, z = 0 })
            self._passenger = nil
            core.chat_send_player(name, "Du steigst als Mitfahrer aus.")
        elseif not self._driver then
            clicker:set_attach(self.object, "", { x = 0, y = 6, z = 2 }, { x = 0, y = 0, z = 0 })
            self._driver = name
            core.chat_send_player(name,
                "Bimmelbahn gestartet! W/S fahren, A/D lenken, Springen = pfeifen (tuut!) " ..
                "und kleiner Hops, Rechtsklick = aussteigen. (Ein zweiter Spieler kann mitfahren!)")
        elseif not self._passenger then
            clicker:set_attach(self.object, "", { x = 0, y = 6, z = -6 }, { x = 0, y = 0, z = 0 })
            self._passenger = name
            core.chat_send_player(name, "Du faehrst als Mitfahrer mit! Rechtsklick = aussteigen.")
        end
    end,

    on_step = function(self, dtime)
        -- gravity keeps the train on the ground
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
        local fwd = (ctrl.up and TRAIN_SPEED) or (ctrl.down and -TRAIN_SPEED * 0.5) or 0
        local v   = self.object:get_velocity()
        local vy  = v and v.y or 0
        if ctrl.jump and math.abs(vy) < 0.1 then
            vy = 4                                   -- a small hop
            self._whistled = (self._whistled or 0)
            if self._whistled <= 0 then
                core.sound_play(WORLD_ID .. "_pfiff",
                    { object = self.object, gain = 0.8, max_hear_distance = 32 })
                self._whistled = 0.6
            end
        end
        self._whistled = math.max(0, (self._whistled or 0) - dtime)
        self.object:set_velocity({ x = dir.x * fwd, y = vy, z = dir.z * fwd })

        -- a little steam puff from the chimney while driving
        if fwd ~= 0 then
            self._steam = (self._steam or 0) + dtime
            if self._steam > 0.18 then
                self._steam = 0
                local p = self.object:get_pos()
                core.add_particlespawner({
                    amount = 6, time = 0.2,
                    minpos = { x = p.x - 0.3, y = p.y + 0.6, z = p.z - 0.3 },
                    maxpos = { x = p.x + 0.3, y = p.y + 1.0, z = p.z + 0.3 },
                    minvel = { x = -0.2, y = 0.6, z = -0.2 },
                    maxvel = { x = 0.2,  y = 1.4, z = 0.2 },
                    minexptime = 0.5, maxexptime = 1.1, minsize = 1, maxsize = 3,
                    texture = "[fill:8x8:#ecf0f1",
                })
            end
        end
    end,
})

core.register_craftitem(L("bimmelbahn"), {
    description     = "Bimmelbahn (Zug)\nPlatzieren, dann Rechtsklick zum Einsteigen",
    inventory_image = "[fill:16x16:#c0392b^[fill:6x6:2,4:#aaddff^[fill:5x5:9,4:#2c3e50" ..
                      "^[fill:4x4:1,1:#7f8c8d^[fill:16x3:0,13:#34495e",
    on_place = function(itemstack, placer, pointed_thing)
        if pointed_thing.type ~= "node" or not (placer and placer:is_player()) then
            return itemstack
        end
        local pos = pointed_thing.above
        pos.y = pos.y + 0.5
        core.add_entity(pos, L("bimmelbahn"))
        if not core.is_creative_enabled(placer:get_player_name()) then
            itemstack:take_item()
        end
        return itemstack
    end,
})

-- ------------------------------------------------------------
--  E) EXTRA: ROUTEN-AUFTRAG  (visit stations in the right ORDER)
--  The heart of the world and the core "Reihenfolge" lesson:
--  the Fahrplan-Pult gives you a route of three colour stations,
--  e.g. "Rot -> Blau -> Gelb". You then stop at the matching
--  STATION SIGNS (Stations-Schilder) in EXACTLY that order. Each
--  correct stop advances the route; a wrong stop resets it. A
--  finished route counts up a personal "Routen" counter with
--  milestones. Fits MI.1 (Ablaeufe/Reihenfolgen) and MA.2.
-- ------------------------------------------------------------
local KEY_ROUTE = WORLD_ID .. ":route"
local KEY_IDX   = WORLD_ID .. ":route_idx"
local KEY_DONE  = WORLD_ID .. ":routen"

local ROUTE_MILESTONES = {
    [3]  = "Routen-Planer",
    [8]  = "Schaffner",
    [15] = "Lokfuehrer",
}

local function get_route(player)
    local rstr = player:get_meta():get_string(KEY_ROUTE)
    if rstr == "" then return nil end
    local route = {}
    for s in rstr:gmatch("[^,]+") do route[#route + 1] = s end
    return route
end

-- Pick a fresh random route of 3 distinct colours.
local function assign_route(player)
    local pool = { "rot", "gelb", "blau", "gruen" }
    for i = #pool, 2, -1 do
        local j = math.random(i)
        pool[i], pool[j] = pool[j], pool[i]
    end
    local route = { pool[1], pool[2], pool[3] }
    local meta = player:get_meta()
    meta:set_string(KEY_ROUTE, table.concat(route, ","))
    meta:set_int(KEY_IDX, 0)
    return route
end

local function route_as_text(route)
    local names = {}
    for _, id in ipairs(route) do names[#names + 1] = color_name(id) end
    return table.concat(names, " - ")
end

-- Show the Fahrplan (assign a new route if there is none).
local function show_fahrplan(player)
    local route = get_route(player)
    if not route then route = assign_route(player) end
    local idx  = player:get_meta():get_int(KEY_IDX)
    local name = player:get_player_name()

    -- vertical layout, one station per row (clearer for kids)
    local f = {
        "formspec_version[4]", "size[9,6]",
        "box[0,0;9,1;#34495e]",
        "label[0.4,0.5;Fahrplan - halte an den Stationen DER REIHE NACH]",
        "label[0.4,1.4;Deine Route:]",
    }
    local y = 1.9
    for i, id in ipairs(route) do
        local hex = "#888888"
        for _, c in ipairs(COLORS) do if c.id == id then hex = c.hex end end
        local mark = (i <= idx) and "[OK] geschafft"
            or ((i == idx + 1) and "<- als naechstes anhalten" or "")
        f[#f + 1] = ("box[0.6,%f;0.7,0.7;%s]"):format(y, hex)
        f[#f + 1] = ("label[1.6,%f;%d. Station %s   %s]"):format(y + 0.35, i, color_name(id), mark)
        y = y + 0.9
    end
    f[#f + 1] = "label[0.4,5.0;Tipp: Rechtsklick auf das passende Stations-Schild.]"
    f[#f + 1] = "button[6.0,5.1;2.6,0.7;neu;Neue Route]"
    core.show_formspec(name, "lernwelt_bimmelbahn:fahrplan", table.concat(f))
end

-- A player stops at a colour station (right-click on a sign).
local function station_checkin(player, cid, cname)
    local name  = player:get_player_name()
    local route = get_route(player)
    if not route then
        core.chat_send_player(name,
            "Du hast noch keinen Fahrauftrag. Hol dir am Fahrplan-Pult eine Route " ..
            "(oder tippe /bimmelbahn_route).")
        return
    end
    local meta = player:get_meta()
    local idx  = meta:get_int(KEY_IDX)
    local want = route[idx + 1]
    if cid == want then
        idx = idx + 1
        meta:set_int(KEY_IDX, idx)
        if idx >= #route then
            -- route complete!
            meta:set_string(KEY_ROUTE, "")
            meta:set_int(KEY_IDX, 0)
            local n = meta:get_int(KEY_DONE) + 1
            meta:set_int(KEY_DONE, n)
            core.sound_play("lernwelt_rankup", { to_player = name, gain = 1.0 })
            core.chat_send_player(name,
                "Geschafft! Du hast die ganze Route in der richtigen Reihenfolge " ..
                "gefahren. Gefahrene Routen: " .. n .. ".")
            local title = ROUTE_MILESTONES[n]
            if title then
                core.chat_send_player(name, "Toll gefahren! Du bist jetzt: " .. title .. "!")
            end
        else
            core.sound_play("lernwelt_rescue", { to_player = name, gain = 0.8 })
            core.chat_send_player(name,
                "Station " .. cname .. " erreicht! Weiter zur naechsten Station: " ..
                color_name(route[idx + 1]) .. ".")
        end
    else
        meta:set_int(KEY_IDX, 0)
        core.chat_send_player(name,
            "Das war die falsche Station (" .. cname .. "). Deine Route beginnt wieder " ..
            "bei: " .. color_name(route[1]) .. ". Tipp: in der richtigen Reihenfolge halten!")
    end
end

-- Station signs: one node per village colour. Right-click = stop here.
for _, c in ipairs(COLORS) do
    core.register_node(L("schild_" .. c.id), {
        description = "Stations-Schild " .. c.name ..
                      "\nRechtsklick: an dieser Station halten",
        drawtype = "nodebox", paramtype = "light", paramtype2 = "facedir",
        sunlight_propagates = true,
        tiles = { "[fill:16x16:#6e552c^[fill:12x8:2,1:" .. c.hex ..
                  "^[fill:4x4:6,2:#ffffff" },
        node_box = { type = "fixed", fixed = {
            { -0.1, -0.5, -0.1, 0.1, 0.15, 0.1 },     -- the post
            { -0.45, 0.15, -0.06, 0.45, 0.5, 0.06 },  -- the colour board
        } },
        groups = { cracky = 3, oddly_breakable_by_hand = 2 },
        is_ground_content = false,
        on_rightclick = function(pos, node, clicker)
            if clicker and clicker:is_player() then
                station_checkin(clicker, c.id, c.name)
            end
        end,
    })
end

-- Fahrplan-Pult: right-click to get / view your route.
core.register_node(L("fahrplan"), {
    description = "Fahrplan-Pult\nRechtsklick: Fahrauftrag (Route) holen / ansehen",
    drawtype = "nodebox", paramtype = "light", paramtype2 = "facedir",
    sunlight_propagates = true,
    tiles = { "[fill:16x16:#34495e^[fill:12x8:2,1:#ecf0f1" ..
              "^[fill:3x2:3,3:#e74c3c^[fill:3x2:7,3:#3498db^[fill:3x2:11,3:#f1c40f" },
    node_box = { type = "fixed", fixed = {
        { -0.4, -0.5, 0.2, 0.4, 0.0, 0.4 },     -- the slanted desk
        { -0.1, -0.5, -0.1, 0.1, 0.1, 0.1 },    -- a little stand
    } },
    groups = { cracky = 3, oddly_breakable_by_hand = 2 },
    is_ground_content = false,
    on_rightclick = function(pos, node, clicker)
        if clicker and clicker:is_player() then show_fahrplan(clicker) end
    end,
})

core.register_on_player_receive_fields(function(player, formname, fields)
    if formname ~= "lernwelt_bimmelbahn:fahrplan" then return end
    if fields.neu then
        assign_route(player)
        show_fahrplan(player)
        return true
    end
end)

core.register_chatcommand("bimmelbahn_route", {
    description = "Gibt dir einen neuen Fahrauftrag (Route der Stationen in einer Reihenfolge)",
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then return false, "Dieser Befehl funktioniert nur im Spiel." end
        local route = assign_route(player)
        show_fahrplan(player)
        return true, "Neuer Fahrauftrag: " .. route_as_text(route) ..
                     ". Halte an den Stations-Schildern in dieser Reihenfolge!"
    end,
})

-- ------------------------------------------------------------
--  F) EXTRA: WEICHE + SIGNAL + DEMO-ZUG  (simple switch logic)
--  A tiny, simplified take on Mesecons / Basic Trains so kids
--  meet "wenn - dann" logic by hand:
--    * WEICHE  - right-click toggles the path (geradeaus <-> ab),
--                the arrow on top flips. Pure cause -> effect.
--    * SIGNAL  - right-click toggles red <-> green. It is walk-
--                through (the train can pass), but a RED signal
--                makes the demo train WAIT in front of it.
--    * DEMO-ZUG - a small self-running loco that patrols a short
--                track between two Prellboecke and STOPS at a red
--                signal, GOES at green. Build the whole demo with
--                /bimmelbahn_demo. (MI.2 / TTG.2)
-- ------------------------------------------------------------

-- WEICHE: two node variants that swap on right-click.
local function register_weiche(name_suffix, label, arrow, next_suffix)
    core.register_node(L(name_suffix), {
        description = "Weiche (" .. label .. ")\nRechtsklick: Weg umstellen",
        drawtype = "nodebox", paramtype = "light", paramtype2 = "facedir",
        sunlight_propagates = true,
        tiles = { "[fill:16x16:#6e552c^[fill:16x2:0,2:#4a3520^[fill:16x2:0,12:#4a3520" ..
                  "^[fill:2x16:3,0:#7f8c8d^[fill:2x16:11,0:#7f8c8d" .. arrow },
        node_box = { type = "fixed", fixed = { -0.5, -0.5, -0.5, 0.5, -0.4, 0.5 } },
        groups = { cracky = 3, oddly_breakable_by_hand = 2 },
        is_ground_content = false,
        on_rightclick = function(pos, node, clicker)
            node.name = L(next_suffix)
            core.swap_node(pos, node)
            if clicker and clicker:is_player() then
                core.sound_play("lernwelt_rescue",
                    { to_player = clicker:get_player_name(), gain = 0.5 })
                core.chat_send_player(clicker:get_player_name(),
                    "Weiche umgestellt: jetzt " .. label .. ".")
            end
        end,
    })
end
-- yellow arrow overlays: straight (up) vs. turning (to the right)
register_weiche("weiche_gerade", "geradeaus",
    "^[fill:2x10:7,3:#f1c40f^[fill:6x2:5,3:#f1c40f", "weiche_ab")
register_weiche("weiche_ab", "nach rechts",
    "^[fill:10x2:3,7:#f1c40f^[fill:2x6:11,3:#f1c40f", "weiche_gerade")

-- SIGNAL: red <-> green, walk-through so the train can pass.
local function register_signal(name_suffix, label, lamp, next_suffix)
    core.register_node(L(name_suffix), {
        description = "Signal (" .. label .. ")\nRechtsklick: umschalten (rot/gruen)",
        drawtype = "nodebox", paramtype = "light", paramtype2 = "facedir",
        sunlight_propagates = true, walkable = false,
        light_source = 6,
        tiles = { "[fill:16x16:#2c3e50^[fill:8x16:4,0:#34495e" .. lamp },
        node_box = { type = "fixed", fixed = {
            { -0.1, -0.5, -0.1, 0.1, 0.5, 0.1 },     -- the mast
            { -0.25, 0.1, -0.25, 0.25, 0.5, 0.25 },  -- the lamp head
        } },
        groups = { cracky = 3, oddly_breakable_by_hand = 2 },
        is_ground_content = false,
        on_rightclick = function(pos, node, clicker)
            node.name = L(next_suffix)
            core.swap_node(pos, node)
            if clicker and clicker:is_player() then
                core.sound_play("lernwelt_rescue",
                    { to_player = clicker:get_player_name(), gain = 0.5 })
                core.chat_send_player(clicker:get_player_name(),
                    "Signal steht jetzt auf " .. label .. ".")
            end
        end,
    })
end
register_signal("signal_rot",   "ROT (Zug haelt)",  "^[fill:6x6:5,2:#e74c3c", "signal_gruen")
register_signal("signal_gruen", "GRUEN (Zug faehrt)", "^[fill:6x6:5,8:#2ecc71", "signal_rot")

-- DEMO-ZUG: a small autonomous loco that patrols a straight track,
-- reverses at a Prellbock (or any wall) and WAITS at a red signal.
core.register_entity(L("demo_zug"), {
    initial_properties = {
        physical = true, collide_with_objects = false,
        collisionbox = { -0.4, -0.4, -0.4, 0.4, 0.4, 0.4 },
        visual = "cube", visual_size = { x = 0.9, y = 0.8, z = 0.9 },
        textures = {
            "[fill:16x16:#16a085^[fill:6x6:5,2:#2c3e50",
            "[fill:16x16:#0e6655",
            "[fill:16x16:#16a085^[fill:5x5:3,4:#aaddff^[fill:5x5:8,4:#aaddff",
            "[fill:16x16:#16a085^[fill:5x5:3,4:#aaddff^[fill:5x5:8,4:#aaddff",
            "[fill:16x16:#117a65^[fill:6x6:5,5:#f1c40f",
            "[fill:16x16:#16a085",
        },
    },
    _dir = nil, _steam = 0,

    on_step = function(self, dtime)
        self.object:set_acceleration({ x = 0, y = -9, z = 0 })
        local pos = self.object:get_pos()
        if not pos then return end
        self._dir = self._dir or { x = 1, y = 0, z = 0 }
        local v  = self.object:get_velocity()
        local vy = v and v.y or 0

        -- reverse if a solid wall / Prellbock is directly ahead
        local fp = {
            x = math.floor(pos.x + self._dir.x + 0.5),
            y = math.floor(pos.y + 0.5),
            z = math.floor(pos.z + self._dir.z + 0.5),
        }
        local fn = core.get_node(fp).name
        local fd = core.registered_nodes[fn]
        if fn == L("prellbock") or (fd and fd.walkable ~= false and fn ~= "air"
            and fn ~= "ignore") then
            self._dir = { x = -self._dir.x, y = 0, z = -self._dir.z }
        end

        -- look a few nodes ahead for a RED signal -> wait
        local stop = false
        for i = 1, 3 do
            local p = {
                x = math.floor(pos.x + self._dir.x * i + 0.5),
                y = math.floor(pos.y + 0.5),
                z = math.floor(pos.z + self._dir.z * i + 0.5),
            }
            for dy = 0, 1 do
                if core.get_node({ x = p.x, y = p.y + dy, z = p.z }).name == L("signal_rot") then
                    stop = true
                end
            end
        end

        local spd = stop and 0 or 2.5
        self.object:set_yaw(core.dir_to_yaw(self._dir))
        self.object:set_velocity({ x = self._dir.x * spd, y = vy, z = self._dir.z * spd })

        if spd > 0 then
            self._steam = (self._steam or 0) + dtime
            if self._steam > 0.25 then
                self._steam = 0
                core.add_particlespawner({
                    amount = 4, time = 0.2,
                    minpos = { x = pos.x - 0.2, y = pos.y + 0.5, z = pos.z - 0.2 },
                    maxpos = { x = pos.x + 0.2, y = pos.y + 0.9, z = pos.z + 0.2 },
                    minvel = { x = -0.1, y = 0.5, z = -0.1 },
                    maxvel = { x = 0.1, y = 1.0, z = 0.1 },
                    minexptime = 0.4, maxexptime = 0.8, minsize = 1, maxsize = 2,
                    texture = "[fill:8x8:#d7f0ea",
                })
            end
        end
    end,
})

core.register_chatcommand("bimmelbahn_demo", {
    description = "Baut eine kleine Demo-Strecke mit Signal: schalte das Signal auf rot, " ..
                  "dann haelt der Demo-Zug; gruen = er faehrt weiter (Weichen-/Signal-Logik)",
    privs = { server = true },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then return false, "Dieser Befehl funktioniert nur im Spiel." end
        local b  = vector.round(player:get_pos())
        local fy = b.y - 1
        local z  = b.z + 3
        -- a straight east-west track (rails at floor level, x: -7..7)
        for dx = -7, 7 do
            core.set_node({ x = b.x + dx, y = fy, z = z }, { name = L("schiene") })
            -- clear the running space above the rails
            core.set_node({ x = b.x + dx, y = fy + 1, z = z }, { name = "air" })
            core.set_node({ x = b.x + dx, y = fy + 2, z = z }, { name = "air" })
        end
        -- a Prellbock (buffer stop) at the train's own level at each end, so
        -- the demo train "sees" it ahead and reverses before the end
        core.set_node({ x = b.x - 7, y = fy + 1, z = z }, { name = L("prellbock") })
        core.set_node({ x = b.x + 7, y = fy + 1, z = z }, { name = L("prellbock") })
        -- a green signal on the track (toggle it to red to stop the train)
        core.set_node({ x = b.x + 3, y = fy + 1, z = z }, { name = L("signal_gruen") })
        -- the self-running demo train in the middle
        local zug = core.add_entity({ x = b.x, y = fy + 1.4, z = z }, L("demo_zug"))
        local le  = zug and zug:get_luaentity()
        if le then le._dir = { x = 1, y = 0, z = 0 } end
        return true, "Demo-Strecke gebaut! Der gruene Zug faehrt hin und her. " ..
                     "Rechtsklick auf das Signal stellt es auf ROT - dann HAELT der Zug. " ..
                     "Wieder gruen = er faehrt weiter. So funktioniert die Logik einer Bahn!"
    end,
})

-- ------------------------------------------------------------
--  C) EXTRA: STARTER KIT  (handed out once on first join)
--  Makes the world testable right away: the logbook, the camera,
--  the Bimmelbahn, the Fahrplan-Pult, station signs, signals, a
--  weiche, track + building blocks and one spawn egg per
--  passenger (the engine registers the eggs when a mob API is
--  present; missing items are simply skipped).
--  Turn off via the setting "lernwelt_bimmelbahn_starter_kit".
-- ------------------------------------------------------------
local STARTER_BLOCKS = {
    "schiene", "bahnsteig", "kies", "backstein", "holzbohle",
    "bahnhofsglas", "bahnhofslampe", "prellbock",
    "haus_rot", "haus_gelb", "haus_blau", "haus_gruen",
}
local STARTER_PARTS = {
    "schild_rot", "schild_gelb", "schild_blau", "schild_gruen",
    "fahrplan", "signal_gruen", "weiche_gerade",
}
-- Spawn-egg item names match the creature ids (world_id:creature_id)
local STARTER_EGGS = {
    "schaffner_maus", "bahnhofs_hund", "gepaeck_igel",
    "rote_reisekatze", "roter_fuchs",
    "gelbes_entlein", "sonnen_kanari",
    "blauer_papagei", "blaues_haeschen",
    "gruener_frosch", "gruene_schildkroete", "goldene_reise_eule",
}

-- Add an item only if it is actually registered (robust across
-- games with or without a mob API).
local function give_if_exists(inv, itemstring)
    local nm = ItemStack(itemstring):get_name()
    if core.registered_items[nm] then
        inv:add_item("main", itemstring)
    end
end

local function give_starter_kit(player)
    local inv = player:get_inventory()
    if not inv then return end
    give_if_exists(inv, L("logbuch"))
    give_if_exists(inv, L("kamera"))
    give_if_exists(inv, L("bimmelbahn"))
    for _, suffix in ipairs(STARTER_BLOCKS) do
        give_if_exists(inv, L(suffix) .. " 20")
    end
    for _, suffix in ipairs(STARTER_PARTS) do
        give_if_exists(inv, L(suffix))
    end
    for _, cid in ipairs(STARTER_EGGS) do
        give_if_exists(inv, L(cid))
    end
    core.chat_send_player(player:get_player_name(),
        "Bimmelbahn-Land: Startausruestung erhalten - Logbuch, Kamera, Bimmelbahn, " ..
        "Fahrplan-Pult, Stations-Schilder, Signal, Weiche, Schienen, Bau-Bloecke und " ..
        "Spawn-Eier sind in deinem Inventar. Viel Spass beim Fahren!")
end

core.register_on_joinplayer(function(player)
    if not core.settings:get_bool("lernwelt_bimmelbahn_starter_kit", true) then return end
    local meta = player:get_meta()
    if meta:get_int("lernwelt_bimmelbahn:starter_given") == 1 then return end
    meta:set_int("lernwelt_bimmelbahn:starter_given", 1)
    -- slight delay so the inventory exists and the message is seen
    core.after(1.5, function()
        if player and player:is_player() then give_starter_kit(player) end
    end)
end)

-- ------------------------------------------------------------
--  G) EXTRA: PASSENGER LAND SPAWNER  (living villages)
--  The engine's built-in spawner only places water animals, so
--  this small, backend-agnostic spawner brings the passengers to
--  life: every so often it tries to add one non-rare passenger on
--  solid ground with air above, near a player, capped so the
--  villages never get crowded. Off with "lernwelt_spawn_creatures".
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
--  "/bimmelbahn_teststation" builds a small ready-made station in
--  front of you: a platform floor, the five learning boards, a
--  Fahrplan-Pult, a short track with the four colour station signs
--  and a Bimmelbahn. Handy for testing or for an adult to prepare
--  the world. Priv: server.
-- ------------------------------------------------------------
local STATION_BOARDS = {
    L("tafel_hauptbahnhof"),
    L("tafel_rotdorf"),
    L("tafel_gelbdorf"),
    L("tafel_blaudorf"),
    L("tafel_gruendorf"),
}

local function build_test_station(player)
    local base    = vector.round(player:get_pos())
    local floor_y = base.y - 1
    local floor   = L("bahnsteig")

    -- a 9 wide (x: -4..4) x 6 deep (z: +2..+7) platform in front of you
    for dx = -4, 4 do
        for dz = 2, 7 do
            core.set_node({ x = base.x + dx, y = floor_y, z = base.z + dz }, { name = floor })
        end
    end

    -- the five learning boards along the back, panels facing back to you
    local xs = { -4, -2, 0, 2, 4 }
    for i, board in ipairs(STATION_BOARDS) do
        if core.registered_nodes[board] then
            core.set_node({ x = base.x + xs[i], y = floor_y + 1, z = base.z + 3 },
                { name = board, param2 = 2 })
        end
    end

    -- the Fahrplan-Pult in the middle
    core.set_node({ x = base.x, y = floor_y + 1, z = base.z + 5 }, { name = L("fahrplan") })

    -- a short track with the four colour station signs
    for dx = -3, 3 do
        core.set_node({ x = base.x + dx, y = floor_y, z = base.z + 7 }, { name = L("schiene") })
    end
    local signs = { "schild_rot", "schild_gelb", "schild_blau", "schild_gruen" }
    local sx = { -3, -1, 1, 3 }
    for i, s in ipairs(signs) do
        core.set_node({ x = base.x + sx[i], y = floor_y + 1, z = base.z + 6 }, { name = L(s) })
    end

    -- a Bimmelbahn ready to board
    core.add_entity({ x = base.x, y = floor_y + 1.5, z = base.z + 7 }, L("bimmelbahn"))
end

core.register_chatcommand("bimmelbahn_teststation", {
    description = "Baut eine kleine Bimmelbahn-Test-Station vor dir " ..
                  "(Bahnsteig, 5 Lern-Tafeln, Fahrplan-Pult, Stations-Schilder, Bimmelbahn)",
    privs = { server = true },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then
            return false, "Dieser Befehl funktioniert nur im Spiel."
        end
        build_test_station(player)
        return true, "Test-Station gebaut! Sie steht vor dir Richtung Norden (+Z): " ..
                     "Bahnsteig, fuenf Lern-Tafeln, Fahrplan-Pult, die vier farbigen " ..
                     "Stations-Schilder und eine Bimmelbahn."
    end,
})

-- ------------------------------------------------------------
--  H) EXTRA: GROSSER HAUPTBAHNHOF  (chat command)
--  "/bimmelbahn_hauptbahnhof" builds a bigger glass station hall
--  in front of you: a platform, a glass shell with a doorway, the
--  five learning boards, a Fahrplan-Pult, the colour station signs
--  along a track and a Bimmelbahn. Priv: server.
-- ------------------------------------------------------------
core.register_chatcommand("bimmelbahn_hauptbahnhof", {
    description = "Baut einen groesseren Hauptbahnhof vor dir " ..
                  "(Glashalle, Tafeln, Fahrplan-Pult, Stations-Schilder, Bimmelbahn)",
    privs = { server = true },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then return false, "Dieser Befehl funktioniert nur im Spiel." end
        local b     = vector.round(player:get_pos())
        local glass = L("bahnhofsglas")
        local floor = L("bahnsteig")
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
        -- the five boards along the back wall
        local boards = { "tafel_hauptbahnhof", "tafel_rotdorf", "tafel_gelbdorf",
                         "tafel_blaudorf", "tafel_gruendorf" }
        local xs = { -4, -2, 0, 2, 4 }
        for i, bd in ipairs(boards) do
            local nn = L(bd)
            if core.registered_nodes[nn] then
                core.set_node({ x = b.x + xs[i], y = fy + 1, z = z0 + 1 }, { name = nn, param2 = 2 })
            end
        end
        -- the Fahrplan-Pult in the hall
        core.set_node({ x = b.x, y = fy + 1, z = z0 + 3 }, { name = L("fahrplan") })
        -- a track with the four colour station signs across the hall
        for dx = -4, 4 do
            core.set_node({ x = b.x + dx, y = fy, z = z0 + 2 * R - 1 }, { name = L("schiene") })
        end
        local signs = { "schild_rot", "schild_gelb", "schild_blau", "schild_gruen" }
        local sx = { -3, -1, 1, 3 }
        for i, s in ipairs(signs) do
            core.set_node({ x = b.x + sx[i], y = fy + 1, z = z0 + 2 * R - 2 }, { name = L(s) })
        end
        core.add_entity({ x = b.x, y = fy + 1.5, z = z0 + R }, L("bimmelbahn"))
        return true, "Hauptbahnhof gebaut! Glashalle mit Tuer, fuenf Tafeln, Fahrplan-Pult, " ..
                     "die vier Stations-Schilder an einem Gleis und eine Bimmelbahn."
    end,
})

-- ------------------------------------------------------------
--  K) EXTRA: WAGEN-PARADE  (line up colourful wagons in order)
--  "/bimmelbahn_wagen" places a little train of colourful wagons
--  in front of you in a fixed colour ORDER (rot, gelb, gruen,
--  blau) - a hands-on colour + sequence exercise (BG.1 / MA.2 /
--  MI.1). Priv: server (it places nodes).
-- ------------------------------------------------------------
core.register_chatcommand("bimmelbahn_wagen", {
    description = "Stellt einen bunten Wagen-Zug der Reihe nach vor dir auf " ..
                  "(Farben und Reihenfolge)",
    privs = { server = true },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then return false, "Dieser Befehl funktioniert nur im Spiel." end
        local b  = vector.round(player:get_pos())
        local fy = b.y
        local order = { "wagen_rot", "wagen_gelb", "wagen_gruen", "wagen_blau" }
        -- a tiny loco at the front, then the wagons in colour order
        local x = b.x - 2
        core.set_node({ x = x, y = fy, z = b.z + 3 }, { name = L("muster_zugfenster") })
        for _, w in ipairs(order) do
            x = x + 1
            core.set_node({ x = x, y = fy, z = b.z + 3 }, { name = L(w) })
            -- little rails underneath
            core.set_node({ x = x, y = fy - 1, z = b.z + 3 }, { name = L("schiene") })
        end
        core.set_node({ x = b.x - 2, y = fy - 1, z = b.z + 3 }, { name = L("schiene") })
        return true, "Wagen-Parade aufgestellt: Lok, dann die Wagen in der Reihenfolge " ..
                     "ROT - GELB - GRUEN - BLAU. Sag die Farben der Reihe nach auf!"
    end,
})

-- ------------------------------------------------------------
--  I) EXTRA: AMBIENT-SOUND  (distant whistle + station bell)
--  Plays a gentle train whistle or a station bell to each player
--  now and then. The .ogg files are optional (missing = silent,
--  only a warning).
-- ------------------------------------------------------------
local amb_timer, amb_next = 0, 45
core.register_globalstep(function(dtime)
    amb_timer = amb_timer + dtime
    if amb_timer < amb_next then return end
    amb_timer = 0
    amb_next = 35 + math.random(0, 40)
    for _, player in ipairs(core.get_connected_players()) do
        local snd = (math.random() < 0.5) and "_pfiff" or "_bimmel"
        core.sound_play(WORLD_ID .. snd, { to_player = player:get_player_name(), gain = 0.4 })
    end
end)

-- ------------------------------------------------------------
--  J) EXTRA: BUCHSTABEN-BLOECKE (A-Z) + ZAHLEN-BLOECKE (0-9)
--  A tiny 5x7 pixel font rendered into each block's texture with
--  layered "[fill" - no image files. Nice for "Deutsch / benennen"
--  (lay out STATION NAMES like ROTDORF) and for "Mathematik /
--  zaehlen" (lay out how many wagons or stations). For Umlauts use
--  AE/OE/UE.
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
        tiles = { glyph_texture(rows, "#ecf0f1", "#c0392b") },
        groups = { cracky = 3, oddly_breakable_by_hand = 2 },
        is_ground_content = false,
    })
end

for digit, rows in pairs(DIGITS) do
    core.register_node(L("zahl_" .. digit), {
        description = "Zahl " .. digit,
        tiles = { glyph_texture(rows, "#d6eaf8", "#2471a3") },
        groups = { cracky = 3, oddly_breakable_by_hand = 2 },
        is_ground_content = false,
    })
end

core.log("action", "[lernwelt_bimmelbahn] Theme 'Bimmelbahn-Land' registered (on lernwelt engine).")
