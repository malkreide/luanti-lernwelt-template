-- ============================================================
--  THEME:  SCHATZINSEL  (a friendly-pirate treasure-island world)
--  A brand-free learning world built ON TOP of the reusable
--  "lernwelt" engine. Almost everything below is one declarative
--  register_world{...} call - blocks, learning zones, rescuable
--  island/cave/lagoon animals, logbook, ranks and badges all come
--  from the engine.
--
--  The theme's heart is RAUMORIENTIERUNG (spatial orientation) plus
--  ZAEHLEN (MA.1): friendly pirates read a MAP and a COMPASS, follow
--  directions (Norden/Osten/Sueden/Westen, oben/unten) across three
--  zones - the sunny Insel, the dark Tropfsteinhoehle and the bright
--  Lagune - and COUNT GOLD COINS along the way. A SCHNITZELJAGD
--  (treasure hunt) of picture-hint signposts leads to a treasure.
--
--  Things the engine cannot express live as small pieces of custom
--  code after register_world:
--    B) the drivable "Floss" (a little raft with a sail for the lagoon)
--    C) WEGWEISER: signpost frames that show a PICTURE hint (island,
--       palm, wave, chest, shell, anchor or a direction arrow). Place
--       your own and build your OWN treasure hunt; the theme's special
--       feature (Bildhinweise / Karte lesen).
--    D) SCHNITZELJAGD: "/schatzinsel_schnitzeljagd" lays out a chain of
--       picture-hint signposts with directions, ending at a treasure.
--    E) SCHATZ-KOMPASS: tells you which way you face (N/O/S/W) and
--       where you are (Strand / Hoehle / Mastkorb - oben/unten).
--    F) SCHATZKARTE: points you to the nearest treasure-hunt hint
--       (Karte lesen - read the map, follow the direction).
--    G) GOLDMUENZEN ZAEHLEN: collectible coins with a personal counter
--       and milestones (MA.1) - "/schatzinsel_muenzen" scatters some.
--    H) ZAHLEN-BLOECKE 0-9 to lay out numbers (counting / MA.1).
--    I) climbable Strickleiter (mast rigging - go oben/unten).
--    J) a starter kit handed out on first join (for quick testing).
--    K) a gentle ground spawner so island/cave friends appear near you.
--    ... plus the signature SCHIFF + STEG base, a test station,
--        ambient sea sound and drifting sea spray.
--
--  The mod name equals the world id ("lernwelt_schatzinsel"), so all
--  nodes/items live in the "lernwelt_schatzinsel:" namespace.
--
--  Content is authored in German (ASCII: ae/oe/ue), like the other
--  example themes. The engine's own UI is translated separately via
--  lernwelt/locale/*.tr. The "pirates" here are FRIENDLY: no fighting,
--  no scary skulls - just maps, counting and discovery.
-- ============================================================

local WORLD_ID = "lernwelt_schatzinsel"

-- ------------------------------------------------------------
--  A) THE WHOLE LEARNING WORLD AS ONE DECLARATIVE TABLE
-- ------------------------------------------------------------
lernwelt.register_world({

    -- internal prefix; kept identical to the mod name so all
    -- nodes/items live in the "lernwelt_schatzinsel:" namespace
    id    = WORLD_ID,
    title = "Schatzinsel",

    -- --- 1) Peaceful, child-friendly world ---
    -- A bright, sunny island day, frozen so the world stays safe and
    -- friendly while children read maps and count gold in peace.
    config = {
        damage      = false,   -- no damage / no dying
        creative    = true,    -- unlimited blocks
        peaceful    = true,    -- no monsters
        freeze_time = "day",   -- a bright, sunny island
        no_weather  = true,
    },

    -- --- 2) Island / ship / cave / lagoon building blocks (no PNG) ---
    -- "texture" is a Luanti texture modifier: a base "[fill" plus
    -- overlays "^[fill:WxH:X,Y:#colour" - patterns without any files.
    blocks = {
        -- Strand & Insel (the sunny surface)
        { suffix = "sand", name = "Strand-Sand",
          texture = "[fill:16x16:#e6cf8e^[fill:2x2:3,4:#d8bd74^[fill:2x2:10,6:#f0e0aa" ..
                    "^[fill:2x2:6,11:#d8bd74^[fill:2x2:12,12:#f0e0aa^[fill:2x2:4,9:#d8bd74" },
        { suffix = "sandstein", name = "Sandstein",
          texture = "[fill:16x16:#d2b46e^[fill:16x1:0,5:#bb9c56^[fill:16x1:0,10:#bb9c56" ..
                    "^[fill:1x5:8,0:#bb9c56^[fill:1x5:5,5:#bb9c56^[fill:1x6:11,10:#bb9c56" },
        { suffix = "muschelsand", name = "Sand mit Muschel",
          texture = "[fill:16x16:#e6cf8e^[fill:6x5:5,8:#f5b7b1^[fill:2x5:7,8:#e84393" ..
                    "^[fill:2x2:4,6:#f0e0aa" },

        -- Palme (a friendly palm tree: trunk + fronds)
        { suffix = "palme_stamm", name = "Palmen-Stamm",
          top    = "[fill:16x16:#a9763f^[fill:10x10:3,3:#8a5a2b^[fill:4x4:6,6:#a9763f",
          side   = "[fill:16x16:#8a5a2b^[fill:16x2:0,3:#6e4622^[fill:16x2:0,8:#6e4622" ..
                   "^[fill:16x2:0,13:#6e4622^[fill:2x16:5,0:#a9763f",
          bottom = "[fill:16x16:#6e4622" },
        { suffix = "palme_blatt", name = "Palmen-Blatt",
          texture = "[fill:16x16:#2e8b46^[fill:3x3:2,2:#27ae60^[fill:2x2:11,4:#3fae5a" ..
                    "^[fill:3x3:6,9:#1e8449^[fill:2x2:12,11:#27ae60^[fill:2x2:3,12:#1e8449" },

        -- Schiff & Steg (the ship + dock that form the base)
        { suffix = "planke", name = "Deck-Planke",
          texture = "[fill:16x16:#c08a4e^[fill:16x1:0,4:#9a6a36^[fill:16x1:0,9:#9a6a36" ..
                    "^[fill:16x1:0,14:#9a6a36" },
        { suffix = "schiffsrumpf", name = "Schiffs-Rumpf",
          top    = "[fill:16x16:#7a4f28^[fill:16x2:0,7:#5a3c20",
          side   = "[fill:16x16:#5a3c20^[fill:16x2:0,2:#6e4622^[fill:16x2:0,7:#6e4622" ..
                   "^[fill:16x2:0,12:#6e4622^[fill:2x16:8,0:#4a3018",
          bottom = "[fill:16x16:#4a3018" },
        { suffix = "steg", name = "Steg-Planke",
          texture = "[fill:16x16:#a9763f^[fill:16x2:0,1:#7a5230^[fill:16x2:0,13:#7a5230" ..
                    "^[fill:2x16:6,0:#8a5e34^[fill:2x16:9,0:#8a5e34" },
        { suffix = "segel", name = "Segel",
          texture = "[fill:16x16:#f3ecd8^[fill:16x1:0,5:#dcd2b6^[fill:16x1:0,10:#dcd2b6" ..
                    "^[fill:3x3:6,6:#cfc4a4" },
        { suffix = "tau", name = "Tau-Seil",
          texture = "[fill:16x16:#c9a86a^[fill:16x2:0,2:#a98a4e^[fill:16x2:0,7:#a98a4e" ..
                    "^[fill:16x2:0,12:#a98a4e^[fill:2x16:7,0:#a98a4e" },
        { suffix = "fass", name = "Fass",
          top    = "[fill:16x16:#7a5230^[fill:12x12:2,2:#8a5e34^[fill:6x6:5,5:#6e4622",
          side   = "[fill:16x16:#8a5e34^[fill:16x2:0,2:#5a3c20^[fill:16x2:0,13:#5a3c20" ..
                   "^[fill:16x1:0,7:#caa074",
          bottom = "[fill:16x16:#5a3c20" },
        { suffix = "kajuetenglas", name = "Kajueten-Glas", color = "#aaddff", glass = true },

        -- Insel-Flagge (a FRIENDLY pirate flag - a parrot, not a skull)
        { suffix = "flagge", name = "Insel-Flagge (Papagei)",
          texture = "[fill:16x16:#c0392b^[fill:5x5:6,3:#2ecc71^[fill:2x2:5,5:#e74c3c" ..
                    "^[fill:2x2:9,7:#f1c40f^[fill:2x4:6,8:#1e8449" },

        -- Orientierungs-Deko (compass rose + map block - the theme's motif)
        { suffix = "kompassrose", name = "Kompass-Rose (Block)",
          texture = "[fill:16x16:#efe2c4^[fill:2x14:7,1:#c0392b^[fill:14x2:1,7:#34495e" ..
                    "^[fill:2x2:7,0:#c0392b^[fill:3x3:6,6:#f1c40f^[fill:2x2:7,14:#34495e" },
        { suffix = "karte_block", name = "Schatzkarten-Block",
          texture = "[fill:16x16:#efe2c4^[fill:16x1:0,1:#caa074^[fill:16x1:0,14:#caa074" ..
                    "^[fill:1x16:1,0:#caa074^[fill:1x16:14,0:#caa074^[fill:5x4:9,3:#5dade2" ..
                    "^[fill:2x2:4,9:#c0392b^[fill:6x1:5,9:#c0392b^[fill:2x2:3,4:#2e8b46" },

        -- Tropfsteinhoehle (the dark cave - oben/unten: drips hang DOWN)
        { suffix = "hoehlenstein", name = "Hoehlen-Stein",
          texture = "[fill:16x16:#6e6258^[fill:8x7:0,0:#7a6e62^[fill:7x8:9,8:#5e544c" ..
                    "^[fill:16x1:0,7:#4e463e^[fill:1x16:8,0:#4e463e" },
        { suffix = "tropfstein", name = "Tropfstein",
          texture = "[fill:16x16:#8a8076^[fill:4x12:2,0:#9a9086^[fill:3x10:9,0:#9a9086" ..
                    "^[fill:2x6:6,0:#7a7066^[fill:2x4:12,0:#7a7066^[fill:16x2:0,0:#6e6258" },
        { suffix = "kristall", name = "Leucht-Kristall", glow = 12,
          texture = "[fill:16x16:#34495e^[fill:4x10:3,4:#5dade2^[fill:3x8:9,3:#85c1e9" ..
                    "^[fill:2x6:7,8:#aed6f1^[fill:2x4:12,6:#5dade2" },
        { suffix = "goldader", name = "Gold-Ader", glow = 5,
          texture = "[fill:16x16:#6e6258^[fill:4x3:2,3:#f1c40f^[fill:3x3:9,8:#f5d76e" ..
                    "^[fill:2x2:6,11:#f1c40f^[fill:2x2:12,4:#f5d76e" },
        { suffix = "goldmuenzen", name = "Goldmuenzen-Haufen", glow = 4,
          top    = "[fill:16x16:#a9763f^[fill:4x4:2,2:#f1c40f^[fill:4x4:9,3:#f5d76e" ..
                   "^[fill:4x4:5,8:#f1c40f^[fill:3x3:11,10:#f5d76e^[fill:3x3:2,10:#f1c40f",
          side   = "[fill:16x16:#a9763f^[fill:4x4:1,8:#f1c40f^[fill:4x4:7,9:#f5d76e" ..
                   "^[fill:4x4:11,7:#f1c40f^[fill:3x3:4,5:#f5d76e",
          bottom = "[fill:16x16:#8a5e34" },

        -- Lagune (the bright, shallow water world)
        { suffix = "lagunensand", name = "Lagunen-Sand (hell)",
          texture = "[fill:16x16:#dff0e3^[fill:2x2:3,4:#c6e6d2^[fill:2x2:10,6:#eff8f1" ..
                    "^[fill:2x2:6,11:#c6e6d2^[fill:2x2:12,12:#eff8f1" },
        { suffix = "koralle_pink", name = "Koralle (pink)", color = "#e84393", glow = 4 },
        { suffix = "koralle_blau", name = "Koralle (blau)", color = "#3498db", glow = 4 },

        -- A few patterned build blocks (procedural, no image files)
        { suffix = "muster_streifen", name = "Streifen-Block",
          texture = "[fill:16x16:#c0392b^[fill:3x16:3,0:#ffffff^[fill:3x16:10,0:#ffffff" },
        { suffix = "muster_schach", name = "Schachbrett-Block",
          texture = "[fill:16x16:#f1c40f^[fill:8x8:0,0:#34495e^[fill:8x8:8,8:#34495e" },

        -- Eigenes gemaltes Bild als Block? Lege eine PNG (16x16 oder 32x32)
        -- "lernwelt_schatzinsel_meinbild.png" in den textures/-Ordner und
        -- entferne die zwei Minuszeichen vor der naechsten Zeile:
        -- { suffix = "meinbild", name = "Mein Bild", texture = "lernwelt_schatzinsel_meinbild.png" },
    },

    -- --- 3) Learning zones (each gets a placeable learning board) ---
    -- Zone titles double as the "habitat" shown in the logbook. The
    -- theme is built around Raumorientierung (NMG.3 / MA.3) and counting
    -- gold coins (MA.1): three zones to orient yourself in - the Insel
    -- (surface, map & compass), the Tropfsteinhoehle (oben/unten,
    -- counting coins in the dark) and the Lagune (shallow water).
    zones = {
        {
            id = "insel", title = "Insel", color = "#e1c16e",
            activity = "Die sonnige Insel erkunden: die SCHATZKARTE und den " ..
                       "KOMPASS lesen, Himmelsrichtungen (Norden/Osten/Sueden/" ..
                       "Westen) bestimmen und den Wegweisern (Bild-Hinweisen) " ..
                       "folgen. Am Strand die gefundenen Goldmuenzen ZAEHLEN.",
            lehrplan = { "NMG.3", "MA.3", "MA.1" },
            tasks = {
                { type = "quiz",
                  question = "Du findest drei Goldmuenzen: Gold Gold Gold. Wie viele sind das?",
                  options = { "3", "2", "4" }, answer = 1,
                  done = "Richtig! Drei Goldmuenzen. Toll gezaehlt!" },
                { type = "quiz",
                  question = "Der Kompass zeigt mit der roten Nadel immer nach ...?",
                  options = { "Norden", "Unten", "Hinten" }, answer = 1,
                  done = "Genau! Die rote Kompassnadel zeigt nach Norden." },
                { type = "rescue", creature = "papagei", count = 2,
                  done = "Stark! Zwei Papageien sind wieder frei auf der Insel." },
            },
        },
        {
            id = "hoehle", title = "Tropfsteinhoehle", color = "#5d6d7e",
            activity = "Tief UNTEN in der Tropfsteinhoehle forschen: Tropfsteine " ..
                       "haengen von der Decke (oben) nach unten. Im Schein der " ..
                       "Kristalle die Goldmuenzen ZAEHLEN und oben/unten " ..
                       "unterscheiden.",
            lehrplan = { "NMG.3", "MA.1", "NMG.2" },
            tasks = {
                { type = "quiz",
                  question = "Ein Tropfstein haengt von der Decke. In welche Richtung zeigt seine Spitze?",
                  options = { "Nach unten", "Nach oben", "Zur Seite" }, answer = 1,
                  done = "Richtig! Tropfsteine an der Decke zeigen nach UNTEN." },
                { type = "quiz",
                  question = "Im Kristall-Licht zaehlst du die Muenzen: Gold Gold Gold Gold Gold. Wie viele?",
                  options = { "5", "4", "6" }, answer = 1,
                  done = "Super gezaehlt! Es sind fuenf Goldmuenzen." },
                { type = "rescue", creature = "fledermaus", count = 2,
                  done = "Toll! Zwei Fledermaeuse in der Hoehle gerettet." },
                { type = "pattern",
                  sequence = { "#5dade2", "#f1c40f", "#5dade2" },
                  palette  = { { "#5dade2", "Kristall" }, { "#f1c40f", "Gold" }, { "#e84393", "Koralle" } },
                  done = "Klasse! Muster Kristall-Gold-Kristall gelegt." },
            },
        },
        {
            id = "lagune", title = "Lagune", color = "#1abc9c",
            activity = "In der ruhigen Lagune schwimmen Tiere. Wer schwimmt im " ..
                       "Wasser? Tiere entdecken und benennen - und die bunten " ..
                       "Fische ZAEHLEN. Mit dem Floss hinausfahren.",
            lehrplan = { "NMG.2", "MA.1", "MA.3" },
            tasks = {
                { type = "quiz", question = "Wer schwimmt in der Lagune?",
                  options = { "Der Fisch", "Der Papagei" }, answer = 1,
                  done = "Genau! Der Fisch schwimmt, der Papagei fliegt." },
                { type = "quiz",
                  question = "In der Lagune zaehlst du: Fisch Fisch. Wie viele Fische?",
                  options = { "2", "1", "3" }, answer = 1,
                  done = "Richtig! Zwei Fische. Gut gezaehlt!" },
                { type = "rescue", creature = "fisch", count = 2,
                  done = "Klasse! Zwei Fische zurueck in die Lagune gebracht." },
            },
        },
    },

    -- --- 4) Rescuable island friends (peaceful; right-click = rescue) ---
    creatures = {
        -- Insel (the sunny surface)
        {
            id = "papagei", name = "Papagei", zone = "insel",
            color = "#27ae60", size = 0.5, speed = 1.2, family = 1,
            food = "Fruechte", power = "Plappert alles nach",
            heart = "#82e0aa",
            rescue_text = "Gerettet! Der Papagei flattert bunt ueber die Insel.",
        },
        {
            id = "aeffchen", name = "Aeffchen", zone = "insel",
            color = "#8d6e3a", size = 0.5, speed = 1.1, family = 1,
            food = "Bananen", power = "Klettert blitzschnell auf Palmen",
            heart = "#c8a06e",
            rescue_text = "Gerettet! Das Aeffchen klettert froehlich auf die Palme.",
        },
        {
            id = "strandkrabbe", name = "Strand-Krabbe", zone = "insel",
            color = "#e74c3c", size = 0.4, speed = 0.6,
            food = "Algen", power = "Laeuft seitwaerts",
            heart = "#f5b7b1",
            rescue_text = "Gerettet! Die Krabbe krabbelt seitwaerts in den Sand.",
        },
        {
            id = "landschildkroete", name = "Land-Schildkroete", zone = "insel",
            color = "#27ae60", size = 0.6, speed = 0.3, family = 2,
            food = "Strandgras", power = "Traegt ihr Haus auf dem Ruecken",
            heart = "#a3e4c0",
            rescue_text = "Gerettet! Die Schildkroete stapft gemuetlich ueber den Strand.",
        },
        {
            id = "moewe", name = "Moewe", zone = "insel",
            color = "#ecf0f1", size = 0.5, speed = 1.0,
            food = "Fische", power = "Segelt elegant im Wind",
            heart = "#f7f9f9",
            rescue_text = "Gerettet! Die Moewe breitet die Fluegel aus und segelt davon.",
        },

        -- Tropfsteinhoehle (the dark cave - "unten")
        {
            id = "fledermaus", name = "Fledermaus", zone = "hoehle",
            color = "#6c3483", size = 0.4, speed = 1.3,
            food = "Motten", power = "Hoert im Dunkeln",
            heart = "#bb8fce",
            rescue_text = "Gerettet! Die Fledermaus flattert leise tiefer in die Hoehle.",
        },
        {
            id = "leuchtkaefer", name = "Leuchtkaefer", zone = "hoehle",
            color = "#f1c40f", size = 0.3, speed = 0.7, glow = 12,
            food = "Moos", power = "Leuchtet im Dunkeln",
            heart = "#f9e79f",
            rescue_text = "Gerettet! Der Leuchtkaefer schwebt leuchtend davon.",
        },
        {
            id = "hoehlengrille", name = "Hoehlen-Grille", zone = "hoehle",
            color = "#7f8c8d", size = 0.3, speed = 0.9,
            food = "Pilze", power = "Springt weit im Dunkeln",
            heart = "#d6dbdf",
            rescue_text = "Gerettet! Die Grille zirpt und huepft in eine Felsspalte.",
        },
        {
            id = "kristallschnecke", name = "Kristall-Schnecke", zone = "hoehle",
            color = "#5dade2", size = 0.4, speed = 0.2, glow = 6,
            food = "Tropfwasser", power = "Glitzert wie ein Kristall",
            heart = "#aed6f1",
            rescue_text = "Gerettet! Die Kristall-Schnecke kriecht glitzernd davon.",
        },

        -- Lagune (the bright shallow water - swims)
        {
            id = "fisch", name = "Bunter Fisch", zone = "lagune",
            color = "#e67e22", size = 0.4, speed = 1.0, swims = true,
            food = "Algen", power = "Schwimmt flink durch die Lagune",
            heart = "#f0b27a",
            rescue_text = "Gerettet! Der Fisch flitzt mit einem Platscher davon.",
        },
        {
            id = "seestern", name = "Seestern", zone = "lagune",
            color = "#e84393", size = 0.4, speed = 0.3, swims = true,
            food = "Muscheln", power = "Arme wachsen nach",
            heart = "#f5b7d4",
            rescue_text = "Gerettet! Der Seestern sinkt sanft auf den Lagunengrund.",
        },
        {
            id = "wasserschildkroete", name = "Wasserschildkroete", zone = "lagune",
            color = "#16a085", size = 0.5, speed = 0.4, swims = true, family = 2,
            food = "Seegras", power = "Paddelt mit grossen Flossen",
            heart = "#a3e4d7",
            rescue_text = "Gerettet! Die Wasserschildkroete paddelt in die Lagune.",
        },
        {
            id = "tintenfisch", name = "Tintenfisch", zone = "lagune",
            color = "#9b59b6", size = 0.5, speed = 0.9, swims = true,
            food = "Krabben", power = "Spritzt eine Tintenwolke",
            heart = "#d2b4de",
            rescue_text = "Der Tintenfisch spritzt eine kleine Tintenwolke und flitzt davon!",
        },

        {
            -- legendary, rare: never auto-spawns (egg/manual only)
            id = "goldpapagei", name = "Goldener Papagei", zone = "insel",
            color = "#f1c40f", size = 0.6, speed = 1.3, glow = 6, rare = true,
            food = "Sonnenlicht", power = "Sehr selten und glaenzend",
            heart = "#fff2a8",
            rescue_text = "Der legendaere Goldene Papagei umkreist dich und glitzert in der Sonne!",
        },
    },

    -- --- 5) Ranks (3rd field = colour -> creates a badge item) ---
    ranks = {
        { 0,  "Schiffsjunge" },
        { 5,  "Maat" },
        { 10, "Steuermann",   "#3498db" },
        { 25, "Schatzsucher",  "#27ae60" },
        { 50, "Kapitaen",      "#f1c40f" },
    },

    -- --- 6) Logbook item ---
    logbook = { title = "Bordbuch", item_color = "#f1c40f" },

    -- --- 7) Plain texts for curriculum codes (for /lernplan & boards) ---
    kompetenzen = {
        ["MA.1"]  = "Mengen erfassen und zaehlen (Goldmuenzen und Tiere zaehlen)",
        ["MA.3"]  = "Raum-Orientierung: einer Karte und Pfeilen folgen " ..
                    "(Norden/Osten/Sueden/Westen), oben/unten unterscheiden",
        ["NMG.3"] = "Raeume erkunden und sich orientieren: Karte lesen, Kompass, " ..
                    "Himmelsrichtungen, oben/unten",
        ["NMG.2"] = "Tiere der Insel, der Hoehle und der Lagune entdecken und benennen",
    },
})

-- ============================================================
--  CUSTOM EXTRAS  (everything the declarative table cannot express)
-- ============================================================

-- ------------------------------------------------------------
--  B) EXTRA: FLOSS  (a little raft with a sail for the lagoon)
--  Not part of the engine - a self-contained vehicle the theme adds
--  on its own. A friendly raft you sail across the lagoon and around
--  the island. Controls: place -> right-click to board -> W/S sail,
--  A/D steer, jump = up, sneak = down, right-click = get off. A
--  second player can ride along (Eltern + Kind).
-- ------------------------------------------------------------
local RAFT_SPEED = 5

core.register_entity(WORLD_ID .. ":floss", {
    initial_properties = {
        physical = true, collide_with_objects = true,
        collisionbox = { -0.7, -0.3, -0.7, 0.7, 0.6, 0.7 },
        visual = "cube", visual_size = { x = 1.4, y = 0.6, z = 1.4 },
        textures = {
            "[fill:16x16:#c08a4e^[fill:16x1:0,5:#9a6a36^[fill:16x1:0,10:#9a6a36",  -- top: deck
            "[fill:16x16:#8a5e34",                                                 -- bottom
            "[fill:16x16:#a9763f", "[fill:16x16:#a9763f",                          -- sides
            "[fill:16x16:#f3ecd8^[fill:16x1:0,7:#dcd2b6",                          -- front: sail
            "[fill:16x16:#a9763f",
        },
    },
    _driver = nil, _passenger = nil, _splash = 0,

    on_rightclick = function(self, clicker)
        if not (clicker and clicker:is_player()) then return end
        local name = clicker:get_player_name()
        if self._driver == name then
            clicker:set_detach()
            clicker:set_eye_offset({ x = 0, y = 0, z = 0 }, { x = 0, y = 0, z = 0 })
            self._driver = nil
            core.chat_send_player(name, "Du gehst vom Floss.")
        elseif self._passenger == name then
            clicker:set_detach()
            clicker:set_eye_offset({ x = 0, y = 0, z = 0 }, { x = 0, y = 0, z = 0 })
            self._passenger = nil
            core.chat_send_player(name, "Du gehst als Mitfahrer vom Floss.")
        elseif not self._driver then
            clicker:set_attach(self.object, "", { x = 0, y = 5, z = 0 }, { x = 0, y = 0, z = 0 })
            self._driver = name
            core.chat_send_player(name,
                "Floss gestartet! W/S segeln, A/D lenken, Springen = hoch, " ..
                "Schleichen = runter, Rechtsklick = von Bord. " ..
                "(Ein zweiter Spieler kann mitfahren!)")
        elseif not self._passenger then
            clicker:set_attach(self.object, "", { x = -5, y = 5, z = 0 }, { x = 0, y = 0, z = 0 })
            self._passenger = name
            core.chat_send_player(name, "Du faehrst als Mitfahrer mit! Rechtsklick = von Bord.")
        end
    end,

    on_step = function(self, dtime)
        self.object:set_acceleration({ x = 0, y = 0, z = 0 })
        local driver = self._driver and core.get_player_by_name(self._driver)
        if not driver then
            self.object:set_velocity({ x = 0, y = 0, z = 0 })
            self._driver = nil
            return
        end
        local ctrl = driver:get_player_control()
        local yaw  = self.object:get_yaw()
        if ctrl.left  then yaw = yaw + 0.05 end
        if ctrl.right then yaw = yaw - 0.05 end
        self.object:set_yaw(yaw)
        local dir = core.yaw_to_dir(yaw)
        local fwd = (ctrl.up and RAFT_SPEED) or (ctrl.down and -RAFT_SPEED * 0.5) or 0
        local vy  = (ctrl.jump and RAFT_SPEED * 0.5) or (ctrl.sneak and -RAFT_SPEED * 0.5) or 0
        self.object:set_velocity({ x = dir.x * fwd, y = vy, z = dir.z * fwd })

        -- a little splash trail while sailing
        if fwd ~= 0 or vy ~= 0 then
            self._splash = (self._splash or 0) + dtime
            if self._splash > 0.25 then
                self._splash = 0
                local p = self.object:get_pos()
                core.add_particlespawner({
                    amount = 5, time = 0.2,
                    minpos = vector.subtract(p, 0.6), maxpos = vector.add(p, 0.6),
                    minvel = { x = -0.3, y = 0.3, z = -0.3 },
                    maxvel = { x = 0.3,  y = 0.9, z = 0.3 },
                    minexptime = 0.5, maxexptime = 1.0, minsize = 1, maxsize = 2,
                    texture = "[fill:8x8:#cfeffd",
                })
            end
        end
    end,
})

core.register_craftitem(WORLD_ID .. ":floss", {
    description = "Floss (Fahrzeug)\nPlatzieren, dann Rechtsklick zum Einsteigen",
    inventory_image = "[fill:16x16:#a9763f^[fill:16x2:0,6:#8a5e34^[fill:5x9:9,2:#f3ecd8" ..
                      "^[fill:1x9:7,2:#7a5230",
    liquids_pointable = true,
    on_place = function(itemstack, placer, pointed_thing)
        if pointed_thing.type ~= "node" or not (placer and placer:is_player()) then
            return itemstack
        end
        local pos = pointed_thing.above
        pos.y = pos.y + 0.5
        core.add_entity(pos, WORLD_ID .. ":floss")
        if not core.is_creative_enabled(placer:get_player_name()) then
            itemstack:take_item()
        end
        return itemstack
    end,
})

-- ------------------------------------------------------------
--  C) EXTRA: WEGWEISER  (picture-hint signposts)
--  The theme's special feature: little wooden signposts that show a
--  PICTURE (island, palm, wave, chest, shell, anchor, or a direction
--  arrow). Children "read" the picture as a hint - like reading a map.
--  You can place your own and build your OWN treasure hunt:
--    right-click         = cycle to the next picture
--    sneak + right-click = open a chooser to pick any picture
--  Signposts placed by the Schnitzeljagd (section D) instead show a
--  text hint with a direction when right-clicked.
--  Everything is drawn procedurally - no image files.
-- ------------------------------------------------------------

-- A wooden frame around a parchment inner field; pictures are drawn
-- into the 12x12 inner area (offset 2,2).
local FRAME_BASE = "[fill:16x16:#8a5e34^[fill:12x12:2,2:#efe2c4"

-- key, label, picture overlay (drawn on top of FRAME_BASE)
local PICTURES = {
    { "leer",   "Leer",          "" },
    { "insel",  "Insel",         "^[fill:12x3:2,10:#5dade2^[fill:7x4:5,6:#e1c16e" ..
                                  "^[fill:2x3:7,3:#2e8b46^[fill:2x2:6,8:#f0e0aa" },
    { "palme",  "Palme",         "^[fill:2x7:7,6:#8a5a2b^[fill:7x2:5,4:#2e8b46" ..
                                  "^[fill:7x2:5,5:#27ae60^[fill:2x2:7,3:#2ecc71" },
    { "welle",  "Welle",         "^[fill:12x2:2,5:#3498db^[fill:12x2:2,8:#5dade2" ..
                                  "^[fill:12x2:2,11:#3498db" },
    { "truhe",  "Schatztruhe",   "^[fill:8x5:4,8:#b9770e^[fill:8x2:4,7:#f1c40f" ..
                                  "^[fill:2x2:7,9:#7a5230^[fill:2x2:7,4:#fff2a8" },
    { "muschel","Muschel",       "^[fill:8x6:4,6:#f5b7b1^[fill:2x6:7,6:#e84393" ..
                                  "^[fill:1x6:5,6:#e84393^[fill:1x6:10,6:#e84393" },
    { "anker",  "Anker",         "^[fill:2x8:7,4:#34495e^[fill:4x2:6,3:#34495e" ..
                                  "^[fill:6x2:5,7:#34495e^[fill:2x2:4,11:#34495e^[fill:2x2:10,11:#34495e" },
    { "muenze", "Goldmuenze",    "^[fill:8x8:4,4:#f1c40f^[fill:4x4:6,6:#f5d76e^[fill:2x2:7,3:#fff2a8" },
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

-- key -> index, key -> nodename
local PIC_INDEX, PIC_NODE = {}, {}
for i, p in ipairs(PICTURES) do PIC_INDEX[p[1]] = i end

local function frame_nodename(key) return WORLD_ID .. ":wegweiser_" .. key end
local function pic_label(key) return PICTURES[PIC_INDEX[key] or 1][2] end

-- transient state: which signpost each player is choosing a picture for
local rahmen_edit = {}

local function show_rahmen_chooser(player, pos)
    local pname = player:get_player_name()
    rahmen_edit[pname] = pos
    local f = { "formspec_version[4]", "size[10,7]",
        "box[0,0;10,1;#8a5e34]",
        "label[0.4,0.5;Bild fuer den Wegweiser waehlen:]" }
    local x, y = 0.4, 1.4
    for _, p in ipairs(PICTURES) do
        f[#f + 1] = ("image_button[%f,%f;1.2,1.2;%s;pic_%s;]")
            :format(x, y, FRAME_BASE .. p[3], p[1])
        f[#f + 1] = ("label[%f,%f;%s]"):format(x, y + 1.2, core.formspec_escape(p[2]))
        x = x + 1.6
        if x > 8.6 then x = 0.4; y = y + 2.0 end
    end
    core.show_formspec(pname, WORLD_ID .. ":wegweiser_chooser", table.concat(f))
end

local function show_rahmen_hint(player, pos)
    local meta = core.get_meta(pos)
    local key  = meta:get_string("bild")
    if key == "" then key = "leer" end
    local hint = meta:get_string("hinweis")
    local nr   = meta:get_int("nummer")
    local pname = player:get_player_name()

    -- count this station as "found" once per player+position
    local seen_key = WORLD_ID .. ":gesehen_" .. core.pos_to_string(pos)
    if player:get_meta():get_int(seen_key) == 0 then
        player:get_meta():set_int(seen_key, 1)
        local m = player:get_meta()
        local n = m:get_int(WORLD_ID .. ":hinweise") + 1
        m:set_int(WORLD_ID .. ":hinweise", n)
        core.sound_play("lernwelt_rescue", { to_player = pname, gain = 0.6 })
    end

    local title = (nr > 0) and ("Hinweis Nr. " .. nr) or "Bild-Hinweis"
    local f = { "formspec_version[4]", "size[8,7]",
        "box[0,0;8,1;#1abc9c]",
        ("label[0.4,0.5;%s]"):format(core.formspec_escape(title)),
        ("image[2.5,1.4;3,3;%s]"):format(FRAME_BASE .. PICTURES[PIC_INDEX[key] or 1][3]),
        ("textarea[0.4,4.6;7.2,1.6;;;%s]"):format(core.formspec_escape(hint ~= "" and hint or
            ("Das Bild zeigt: " .. pic_label(key) .. "."))),
        "button_exit[3,6.2;2,0.7;ok;Weiter]" }
    core.show_formspec(pname, WORLD_ID .. ":wegweiser_hinweis", table.concat(f))
end

for _, p in ipairs(PICTURES) do
    local key      = p[1]
    local nodename = frame_nodename(key)
    PIC_NODE[key]  = nodename
    core.register_node(nodename, {
        description = "Wegweiser (" .. p[2] .. ")\nRechtsklick = Bild wechseln, " ..
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
        -- only the empty signpost shows up in creative search; the others
        -- are reached by cycling, but all can be /giveme'd by key
        drop = frame_nodename("leer"),
        is_ground_content = false,
        on_rightclick = function(pos, node, clicker)
            if not (clicker and clicker:is_player()) then return end
            -- Schnitzeljagd signposts carry a hint -> show it instead of editing
            if core.get_meta(pos):get_int("jagd") == 1 then
                show_rahmen_hint(clicker, pos)
                return
            end
            if clicker:get_player_control().sneak then
                show_rahmen_chooser(clicker, pos)
            else
                -- cycle to the next picture, keeping orientation
                local cur = PIC_INDEX[key] or 1
                local nxt = PICTURES[(cur % #PICTURES) + 1][1]
                core.swap_node(pos, { name = frame_nodename(nxt), param2 = node.param2 })
                core.chat_send_player(clicker:get_player_name(),
                    "Bild im Wegweiser: " .. pic_label(nxt))
            end
        end,
    })
end

core.register_on_player_receive_fields(function(player, formname, fields)
    if formname ~= WORLD_ID .. ":wegweiser_chooser" then return end
    local pos = rahmen_edit[player:get_player_name()]
    if not pos then return true end
    for _, p in ipairs(PICTURES) do
        if fields["pic_" .. p[1]] then
            local node = core.get_node(pos)
            if node.name:sub(1, #WORLD_ID + 11) == WORLD_ID .. ":wegweiser_" then
                core.swap_node(pos, { name = frame_nodename(p[1]), param2 = node.param2 })
                core.chat_send_player(player:get_player_name(),
                    "Bild im Wegweiser: " .. p[2])
            end
            rahmen_edit[player:get_player_name()] = nil
            return true
        end
    end
    return true
end)

-- ------------------------------------------------------------
--  D) EXTRA: SCHNITZELJAGD  (picture-hint treasure hunt)
--  "/schatzinsel_schnitzeljagd" lays out a chain of Wegweiser on
--  small posts around you. Each signpost shows a PICTURE + a text hint
--  pointing to the NEXT one with a real direction (Norden/Osten/...,
--  oben/unten). The chain ends at a treasure chest. A pure
--  Raumorientierung exercise (NMG.3 / MA.3): read a picture, follow
--  the direction, find the next clue. Priv: server.
-- ------------------------------------------------------------

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

-- place a hint signpost on a post at base+offset; returns its world pos
local function place_hint(base, off, pic, hint, nr)
    local fx, fz = base.x + off.dx, base.z + off.dz
    local fy     = base.y + (off.dy or 0)
    -- build a little post from the ground up to the signpost
    for y = base.y - 1, fy - 1 do
        core.set_node({ x = fx, y = y, z = fz }, { name = WORLD_ID .. ":palme_stamm" })
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

core.register_chatcommand("schatzinsel_schnitzeljagd", {
    description = "Legt eine Schnitzeljagd mit Bild-Hinweisen vor dir an " ..
                  "(Wegweiser mit Pfeilen -> Schatz)",
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
            { dx =  5, dz = 11, dy = 4 },   -- 3 north + HIGH (lookout/oben)
            { dx = -5, dz = 11, dy = 1 },   -- 4 west again
        }
        local treasure = { dx = 0, dz = 8, dy = 1 }

        local function world(off) return { x = b.x + off.dx, y = b.y + off.dy, z = b.z + off.dz } end

        for i, st in ipairs(stations) do
            local nextoff = stations[i + 1] or treasure
            local pic, word = direction_to(world(st), world(nextoff))
            local target = (i < #stations) and "zum naechsten Wegweiser" or "zum SCHATZ"
            local hint = ("Gehe %s, %s. Such dort den naechsten Wegweiser."):format(word, target)
            if i == #stations then
                hint = ("Fast geschafft! Gehe %s %s."):format(word, target)
            end
            place_hint(b, st, pic, hint, i)
        end

        -- the treasure chest at the end
        local tp = world(treasure)
        for y = b.y - 1, tp.y - 1 do
            core.set_node({ x = tp.x, y = y, z = tp.z }, { name = WORLD_ID .. ":sandstein" })
        end
        core.set_node(tp, { name = WORLD_ID .. ":schatzkiste" })

        return true, "Schnitzeljagd gelegt! Start ist der Wegweiser links vor dir " ..
                     "(Westen). Rechtsklick auf einen Wegweiser zeigt das Bild und " ..
                     "den naechsten Pfeil. Folge ihnen bis zum Schatz!"
    end,
})

-- ------------------------------------------------------------
--  TREASURE CHEST  (the reward at the end of a Schnitzeljagd)
--  Right-click once = reward + a personal "Schaetze" counter with
--  milestones, plus some gold into your inventory. A goal node.
-- ------------------------------------------------------------
local SCHATZ_LOOT = { "goldmuenzen", "kristall", "floss" }

core.register_node(WORLD_ID .. ":schatzkiste", {
    description = "Schatzkiste\nRechtsklick = Schatz oeffnen",
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    tiles = {
        "[fill:16x16:#7a5230^[fill:16x4:0,0:#f1c40f^[fill:2x2:7,5:#b9770e",  -- top (lid band)
        "[fill:16x16:#6e4b2a",
        "[fill:16x16:#8a5e34^[fill:16x3:0,6:#f1c40f^[fill:2x4:7,8:#b9770e",  -- sides (lock)
    },
    groups = { choppy = 2, oddly_breakable_by_hand = 2 },
    is_ground_content = false,
    on_rightclick = function(pos, node, clicker)
        if not (clicker and clicker:is_player()) then return end
        local name = clicker:get_player_name()
        local meta = clicker:get_meta()
        local n = meta:get_int(WORLD_ID .. ":schaetze") + 1
        meta:set_int(WORLD_ID .. ":schaetze", n)
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
--  E) EXTRA: SCHATZ-KOMPASS  (spatial-orientation helper)
--  A pocket helper for Raumorientierung / Kompass: left-click tells
--  you which way you FACE (Norden/Osten/Sueden/Westen) and WHERE you
--  are (am Strand / tief unten in der Hoehle / oben im Mastkorb -
--  oben/unten). It also reads out how many gold coins you have
--  collected so far. Pure NMG.3 / MA.3 (+ a little MA.1) support.
-- ------------------------------------------------------------
local function facing_word(yaw)
    local dir = core.yaw_to_dir(yaw)
    if math.abs(dir.x) >= math.abs(dir.z) then
        return dir.x > 0 and "Osten" or "Westen"
    else
        return dir.z > 0 and "Norden" or "Sueden"
    end
end

-- is there a solid roof close above the player's head? (= in a cave)
local function has_roof_above(pos)
    local p = vector.round(pos)
    for dy = 2, 8 do
        local n   = core.get_node({ x = p.x, y = p.y + dy, z = p.z }).name
        local def = core.registered_nodes[n]
        if n ~= "ignore" and def and def.walkable ~= false and n ~= "air" then
            return true
        end
    end
    return false
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

core.register_craftitem(WORLD_ID .. ":kompass", {
    description = "Schatz-Kompass\nLinksklick = Himmelsrichtung, Ort (oben/unten) & Goldmuenzen",
    inventory_image = "[fill:16x16:#8a5e34^[fill:12x12:2,2:#ecf0f1^[fill:2x6:7,3:#c0392b" ..
                      "^[fill:2x5:7,8:#34495e^[fill:4x4:6,6:#bdc3c7",
    on_use = function(itemstack, user)
        if not (user and user:is_player()) then return itemstack end
        local name = user:get_player_name()
        local face = facing_word(user:get_look_horizontal())
        local pos  = user:get_pos()
        local where
        if has_roof_above(pos) then
            where = "tief UNTEN in der Tropfsteinhoehle"
        else
            local h = height_above_ground(pos)
            if h == nil then where = "(Boden unbekannt)"
            elseif h <= 1 then where = "UNTEN am Strand / an Deck"
            elseif h <= 4 then where = h .. " Bloecke hoch (am Hang / auf dem Schiff)"
            else where = h .. " Bloecke hoch - OBEN im Mastkorb (Ausguck)" end
        end
        core.chat_send_player(name, "Kompass: Du schaust nach " .. face ..
            ". Du bist " .. where .. ".")
        local coins = user:get_meta():get_int(WORLD_ID .. ":muenzen")
        core.chat_send_player(name, "Gezaehlte Goldmuenzen: " .. coins .. ".")
        return itemstack
    end,
})

-- ------------------------------------------------------------
--  F) EXTRA: SCHATZKARTE  (read the map -> nearest hint)
--  A treasure map the children "read": left-click points to the
--  NEAREST Schnitzeljagd hint signpost with a real direction and a
--  rough distance. Pure Karte-lesen / Raumorientierung (NMG.3).
-- ------------------------------------------------------------
local FRAME_NODE_NAMES = {}
for _, p in ipairs(PICTURES) do FRAME_NODE_NAMES[#FRAME_NODE_NAMES + 1] = frame_nodename(p[1]) end

local function nearest_hint_dir(pos)
    local r = 40
    local found = core.find_nodes_in_area(
        { x = pos.x - r, y = pos.y - 20, z = pos.z - r },
        { x = pos.x + r, y = pos.y + 20, z = pos.z + r },
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

core.register_craftitem(WORLD_ID .. ":schatzkarte", {
    description = "Schatzkarte\nLinksklick = Richtung zum naechsten Wegweiser lesen",
    inventory_image = "[fill:16x16:#caa074^[fill:12x12:2,2:#efe2c4^[fill:5x4:8,3:#5dade2" ..
                      "^[fill:2x2:4,9:#c0392b^[fill:5x1:4,9:#c0392b^[fill:2x2:3,4:#2e8b46",
    on_use = function(itemstack, user)
        if not (user and user:is_player()) then return itemstack end
        local name = user:get_player_name()
        local dirword, dist = nearest_hint_dir(user:get_pos())
        if dirword then
            core.chat_send_player(name, "Schatzkarte: Der naechste Wegweiser liegt " ..
                dirword .. " (ca. " .. dist .. " Bloecke). Folge dem Pfeil!")
        else
            core.chat_send_player(name, "Schatzkarte: Kein Schnitzeljagd-Hinweis in der " ..
                "Naehe. Tipp: /schatzinsel_schnitzeljagd legt eine an.")
        end
        return itemstack
    end,
})

-- ------------------------------------------------------------
--  G) EXTRA: GOLDMUENZEN ZAEHLEN  (collect & count coins, MA.1)
--  Gold coin nodes you collect (dig). Each one adds to a personal
--  coin counter with milestones - hands-on COUNTING (MA.1). Scatter
--  practice coins with "/schatzinsel_muenzen" (priv: server) or via
--  the test station / treasure ship.
-- ------------------------------------------------------------
local COIN_MILESTONES = {
    [5]  = "Muenzen-Zaehler",
    [15] = "Schatz-Buchhalter",
    [30] = "Goldsammler",
}

local function collect_coin(player)
    if not (player and player:is_player()) then return end
    local meta = player:get_meta()
    local n = meta:get_int(WORLD_ID .. ":muenzen") + 1
    meta:set_int(WORLD_ID .. ":muenzen", n)
    local name = player:get_player_name()
    core.sound_play("lernwelt_rescue", { to_player = name, gain = 0.7 })
    core.chat_send_player(name, "Goldmuenze eingesammelt! Du hast jetzt " .. n ..
        " Goldmuenzen gezaehlt.")
    local title = COIN_MILESTONES[n]
    if title then
        core.sound_play("lernwelt_rankup", { to_player = name, gain = 1.0 })
        core.chat_send_player(name, "Toll gezaehlt! Du bist jetzt: " .. title .. "!")
    end
end

core.register_node(WORLD_ID .. ":goldmuenze", {
    description = "Goldmuenze\nEinsammeln (abbauen) = zaehlen",
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    sunlight_propagates = true,
    walkable = false,
    floodable = false,
    light_source = 4,
    tiles = { "[fill:16x16:#f1c40f^[fill:6x6:5,5:#f5d76e^[fill:2x2:7,3:#fff2a8" },
    inventory_image = "[fill:16x16:#f1c40f^[fill:6x6:5,5:#f5d76e^[fill:2x2:7,3:#fff2a8",
    node_box = { type = "fixed", fixed = { -0.25, -0.5, -0.25, 0.25, -0.2, 0.25 } },
    selection_box = { type = "fixed", fixed = { -0.3, -0.5, -0.3, 0.3, 0.0, 0.3 } },
    groups = { oddly_breakable_by_hand = 3, dig_immediate = 3 },
    drop = "",
    after_dig_node = function(pos, oldnode, oldmeta, digger)
        collect_coin(digger)
    end,
})

-- nodes the coin-scatter command may replace (air or grass/snow-ish)
local SCATTER_SPACE = { ["air"] = true }

core.register_chatcommand("schatzinsel_muenzen", {
    description = "Verteilt Goldmuenzen zum Einsammeln und Zaehlen um dich herum (zum Testen)",
    privs = { server = true },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then return false, "Dieser Befehl funktioniert nur im Spiel." end
        local base, placed = vector.round(player:get_pos()), 0
        for _ = 1, 12 do
            local x = base.x + math.random(-6, 6)
            local z = base.z + math.random(-6, 6)
            for dy = 3, -4, -1 do
                local q     = { x = x, y = base.y + dy, z = z }
                local here  = core.get_node(q).name
                local below = core.get_node({ x = x, y = q.y - 1, z = z }).name
                local bdef  = core.registered_nodes[below]
                if SCATTER_SPACE[here] and below ~= "air" and below ~= "ignore"
                   and bdef and bdef.walkable ~= false then
                    core.set_node(q, { name = WORLD_ID .. ":goldmuenze" })
                    placed = placed + 1
                    break
                end
            end
        end
        if placed == 0 then
            return true, "Kein passender Platz gefunden - stell dich auf festen Boden und versuch es nochmal."
        end
        return true, placed .. " Goldmuenzen verteilt - sammle sie ein und ZAEHLE mit!"
    end,
})

-- ------------------------------------------------------------
--  H) EXTRA: ZAHLEN-BLOECKE 0-9  (lay out numbers, MA.1)
--  A tiny 5x7 pixel font rendered into each block's texture with
--  layered "[fill" - no image files. Lay out the count of your gold
--  (e.g. build "1 2") or a treasure-chest number. Fits MA.1 / counting.
-- ------------------------------------------------------------
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

local function digit_texture(rows)
    local t = { "[fill:16x16:#efe2c4" }
    for r = 1, #rows do
        local row = rows[r]
        for c = 1, #row do
            if row:sub(c, c) == "#" then
                t[#t + 1] = ("^[fill:2x2:%d,%d:#b9770e"):format(3 + (c - 1) * 2, 1 + (r - 1) * 2)
            end
        end
    end
    return table.concat(t)
end

for digit, rows in pairs(DIGITS) do
    core.register_node(WORLD_ID .. ":zahl_" .. digit, {
        description = "Zahl " .. digit,
        tiles = { digit_texture(rows) },
        groups = { cracky = 3, oddly_breakable_by_hand = 2 },
        is_ground_content = false,
    })
end

-- ------------------------------------------------------------
--  I) EXTRA: STRICKLEITER  (climbable mast rigging)
--  Going up and down is part of Raumorientierung (oben/unten). A
--  climbable rope ladder lets children climb the mast to the lookout
--  (oben) and back to the deck (unten). Place it on a wall or post.
-- ------------------------------------------------------------
core.register_node(WORLD_ID .. ":strickleiter", {
    description = "Strickleiter (kletterbar)\nHoch in den Mastkorb, runter aufs Deck",
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    sunlight_propagates = true,
    walkable = false,
    climbable = true,
    floodable = false,
    tiles = { "[fill:16x16:#00000000^[fill:2x16:3,0:#9a6a36^[fill:2x16:11,0:#9a6a36" ..
              "^[fill:16x2:0,2:#c9a86a^[fill:16x2:0,8:#c9a86a^[fill:16x2:0,14:#c9a86a" },
    use_texture_alpha = "clip",
    inventory_image = "[fill:16x16:#c9a86a^[fill:2x16:3,0:#9a6a36^[fill:2x16:11,0:#9a6a36" ..
                      "^[fill:16x2:0,2:#7a5230^[fill:16x2:0,8:#7a5230^[fill:16x2:0,14:#7a5230",
    node_box = { type = "fixed", fixed = { -0.5, -0.5, 0.4, 0.5, 0.5, 0.5 } },
    groups = { snappy = 3, oddly_breakable_by_hand = 3 },
})

-- ------------------------------------------------------------
--  J) EXTRA: STARTER KIT  (handed out once on first join)
--  Makes the world testable right away: the Bordbuch, camera, the
--  Schatz-Kompass + Schatzkarte, the Floss, a stack of each building
--  block, some empty Wegweiser (build your own hints), Strickleitern,
--  a few gold coins to count and one spawn egg per island friend (the
--  engine registers eggs when a mob API is present; missing items are
--  simply skipped). Turn off via "lernwelt_schatzinsel_starter_kit".
-- ------------------------------------------------------------
local STARTER_BLOCKS = {
    "sand", "sandstein", "muschelsand", "palme_stamm", "palme_blatt",
    "planke", "schiffsrumpf", "steg", "segel", "tau", "fass", "kajuetenglas",
    "flagge", "kompassrose", "karte_block",
    "hoehlenstein", "tropfstein", "kristall", "goldader", "goldmuenzen",
    "lagunensand", "koralle_pink", "koralle_blau", "strickleiter",
}
-- Spawn-egg item names match the creature ids (world_id:creature_id)
local STARTER_EGGS = {
    "papagei", "aeffchen", "strandkrabbe", "landschildkroete", "moewe",
    "fledermaus", "leuchtkaefer", "hoehlengrille", "kristallschnecke",
    "fisch", "seestern", "wasserschildkroete", "tintenfisch", "goldpapagei",
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
    give_if_exists(inv, WORLD_ID .. ":schatzkarte")
    give_if_exists(inv, WORLD_ID .. ":floss")
    give_if_exists(inv, WORLD_ID .. ":wegweiser_leer 6")
    give_if_exists(inv, WORLD_ID .. ":goldmuenze 9")
    for _, suffix in ipairs(STARTER_BLOCKS) do
        give_if_exists(inv, WORLD_ID .. ":" .. suffix .. " 10")
    end
    for _, cid in ipairs(STARTER_EGGS) do
        give_if_exists(inv, WORLD_ID .. ":" .. cid)
    end
    core.chat_send_player(player:get_player_name(),
        "Schatzinsel: Startausruestung erhalten - Bordbuch, Kamera, Schatz-Kompass, " ..
        "Schatzkarte, Floss, Wegweiser, Goldmuenzen, Bau-Bloecke und Spawn-Eier sind " ..
        "in deinem Inventar. Tipp: /schatzinsel_schiff baut dein Schatzschiff!")
end

core.register_on_joinplayer(function(player)
    if not core.settings:get_bool("lernwelt_schatzinsel_starter_kit", true) then return end
    local meta = player:get_meta()
    if meta:get_int(WORLD_ID .. ":starter_given") == 1 then return end
    meta:set_int(WORLD_ID .. ":starter_given", 1)
    core.after(1.5, function()
        if player and player:is_player() then give_starter_kit(player) end
    end)
end)

-- ------------------------------------------------------------
--  K) EXTRA: GROUND SPAWNER  (a living island)
--  The engine's built-in spawner only places water animals (the
--  lagoon fish), so this small, backend-agnostic spawner brings the
--  island and cave friends to life: every so often it tries to add
--  one non-rare, non-swimming creature on solid ground with air
--  above, near a player, capped so the island never gets crowded.
--  Off with "lernwelt_spawn_creatures".
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
--  L) EXTRA: SCHATZSCHIFF + STEG  (the signature base)
--  "/schatzinsel_schiff" builds the world's home base in front of
--  you: a wooden ship with a hull, a plank deck and a railing, a mast
--  with a sail and a friendly flag, a Strickleiter up to the lookout
--  (oben!), the three learning boards on deck, a compass-rose floor,
--  two Wegweiser at different heights (oben/unten), a treasure chest,
--  a Steg (dock) leading ashore and a Floss tied up at the dock.
--  Priv: server.
-- ------------------------------------------------------------
core.register_chatcommand("schatzinsel_schiff", {
    description = "Baut ein Schatzschiff mit Steg (Basis) vor dir - Deck, Mast, " ..
                  "Segel, Strickleiter, Lern-Tafeln, Kompass-Rose, Wegweiser, Schatz und Floss",
    privs = { server = true },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then return false, "Dieser Befehl funktioniert nur im Spiel." end
        local b      = vector.round(player:get_pos())
        local hull   = WORLD_ID .. ":schiffsrumpf"
        local deck   = WORLD_ID .. ":planke"
        local rail   = WORLD_ID .. ":fass"
        local mast   = WORLD_ID .. ":palme_stamm"
        local sail   = WORLD_ID .. ":segel"
        local fy     = b.y                  -- deck level (feet)
        local cx, cz = b.x, b.z + 6         -- ship centre, a bit in front
        local HW, HL = 3, 5                  -- half width / half length of the deck

        -- hull one block below the deck, plus a plank deck on top
        for dx = -HW, HW do
            for dz = -HL, HL do
                local x, z = cx + dx, cz + dz
                core.set_node({ x = x, y = fy - 1, z = z }, { name = hull })
                core.set_node({ x = x, y = fy,     z = z }, { name = deck })
                -- a low railing of barrels around the rim, gap at the back for the dock
                if math.abs(dx) == HW or math.abs(dz) == HL then
                    local gap = (dz == -HL and dx == 0)
                    if not gap then
                        core.set_node({ x = x, y = fy + 1, z = z }, { name = rail })
                    end
                end
            end
        end

        -- a compass-rose tile in the middle of the deck (orientation motif)
        core.set_node({ x = cx, y = fy, z = cz }, { name = WORLD_ID .. ":kompassrose" })

        -- the mast: a tall trunk, a sail across it, a flag on top
        for dy = 1, 7 do
            core.set_node({ x = cx, y = fy + dy, z = cz + 1 }, { name = mast })
        end
        for dy = 3, 6 do
            for sx = -1, 1 do
                core.set_node({ x = cx + sx, y = fy + dy, z = cz + 1 }, { name = sail })
            end
        end
        core.set_node({ x = cx, y = fy + 1, z = cz + 1 }, { name = mast })  -- ensure base
        core.set_node({ x = cx, y = fy + 8, z = cz + 1 }, { name = WORLD_ID .. ":flagge" })

        -- a Strickleiter up the mast to the lookout (oben), with a small
        -- plank platform (the Mastkorb) at the top
        for dy = 1, 6 do
            core.set_node({ x = cx, y = fy + dy, z = cz },
                { name = WORLD_ID .. ":strickleiter", param2 = 4 })
        end
        for ox = -1, 1 do
            for oz = -1, 1 do
                core.set_node({ x = cx + ox, y = fy + 7, z = cz + oz }, { name = deck })
            end
        end

        -- the three learning boards on deck, facing the dock (south)
        local boards = { "tafel_insel", "tafel_hoehle", "tafel_lagune" }
        local xs = { -2, 0, 2 }
        for i, bd in ipairs(boards) do
            local nn = WORLD_ID .. ":" .. bd
            if core.registered_nodes[nn] then
                core.set_node({ x = cx + xs[i], y = fy + 1, z = cz + HL - 1 },
                    { name = nn, param2 = 2 })
            end
        end

        -- two Wegweiser to teach the storeys: one low on deck ("unten",
        -- a wave), one high in the lookout ("oben", an island)
        local low = { x = cx + HW - 1, y = fy + 1, z = cz - HL + 1 }
        core.set_node(low, { name = frame_nodename("welle") })
        core.get_meta(low):set_string("infotext", "Bild-Hinweis: hier UNTEN auf dem Deck")
        local high = { x = cx + 1, y = fy + 8, z = cz }
        core.set_node(high, { name = frame_nodename("insel") })
        core.get_meta(high):set_string("infotext", "Bild-Hinweis: hier OBEN im Mastkorb")

        -- a treasure chest on deck
        core.set_node({ x = cx - HW + 1, y = fy + 1, z = cz - HL + 1 },
            { name = WORLD_ID .. ":schatzkiste" })

        -- a Steg (dock) of planks from the back of the ship toward you
        for dz = 1, 5 do
            core.set_node({ x = cx, y = fy - 1, z = cz - HL - dz },
                { name = WORLD_ID .. ":steg" })
        end

        -- a Floss tied up at the foot of the dock
        core.add_entity({ x = cx + 1.5, y = fy - 0.5, z = cz - HL - 3 },
            WORLD_ID .. ":floss")

        return true, "Schatzschiff gebaut! Geh ueber den Steg an Bord. Auf dem Deck " ..
                     "warten die drei Lern-Tafeln, die Kompass-Rose und eine Schatzkiste. " ..
                     "Klettere die Strickleiter HOCH in den Mastkorb (oben) - dort haengt " ..
                     "ein zweiter Wegweiser. Das Floss liegt am Steg bereit."
    end,
})

-- ------------------------------------------------------------
--  M) EXTRA: TEST STATION  (chat command for quick setup)
--  "/schatzinsel_teststation" builds a small ready-made spot in front
--  of you: a sandy floor, the three learning boards, a Floss, a row
--  of Wegweiser to try (cycle the pictures!), a short Strickleiter to
--  climb and a few gold coins to count. Handy for testing. Priv: server.
-- ------------------------------------------------------------
local STATION_BOARDS = {
    WORLD_ID .. ":tafel_insel",
    WORLD_ID .. ":tafel_hoehle",
    WORLD_ID .. ":tafel_lagune",
}

core.register_chatcommand("schatzinsel_teststation", {
    description = "Baut eine kleine Schatzinsel-Test-Station vor dir " ..
                  "(Sand, 3 Lern-Tafeln, Floss, Wegweiser, Strickleiter, Goldmuenzen)",
    privs = { server = true },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then return false, "Dieser Befehl funktioniert nur im Spiel." end
        local base    = vector.round(player:get_pos())
        local floor_y = base.y - 1
        local floor   = WORLD_ID .. ":sand"

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

        -- a row of Wegweiser to try (right-click to cycle the picture)
        core.set_node({ x = base.x - 3, y = floor_y + 1, z = base.z + 5 },
            { name = frame_nodename("insel") })
        core.set_node({ x = base.x - 1, y = floor_y + 1, z = base.z + 5 },
            { name = frame_nodename("welle") })
        core.set_node({ x = base.x + 1, y = floor_y + 1, z = base.z + 5 },
            { name = frame_nodename("truhe") })
        core.set_node({ x = base.x + 3, y = floor_y + 1, z = base.z + 5 },
            { name = frame_nodename("pfeil_hoch") })

        -- a short Strickleiter to climb (oben/unten)
        for dy = 1, 4 do
            core.set_node({ x = base.x + 3, y = floor_y + dy, z = base.z + 2 },
                { name = WORLD_ID .. ":strickleiter", param2 = 2 })
        end

        -- a few gold coins to count
        for _, dx in ipairs({ -2, 0, 2 }) do
            core.set_node({ x = base.x + dx, y = floor_y + 1, z = base.z + 2 },
                { name = WORLD_ID .. ":goldmuenze" })
        end

        core.add_entity({ x = base.x, y = floor_y + 1.5, z = base.z + 4 },
            WORLD_ID .. ":floss")

        return true, "Test-Station gebaut! Sie steht vor dir Richtung Norden (+Z): " ..
                     "Strand-Sand, drei Lern-Tafeln, ein Floss, vier Wegweiser zum " ..
                     "Ausprobieren, eine Strickleiter und drei Goldmuenzen zum Zaehlen."
    end,
})

-- ------------------------------------------------------------
--  N) EXTRA: AMBIENT-SOUND  (gentle waves / seagulls / parrot)
--  Plays a gentle island sound to each player now and then. The
--  .ogg files are optional (missing = silent, only a warning).
-- ------------------------------------------------------------
local amb_timer, amb_next = 0, 45
core.register_globalstep(function(dtime)
    amb_timer = amb_timer + dtime
    if amb_timer < amb_next then return end
    amb_timer = 0
    amb_next = 35 + math.random(0, 40)
    for _, player in ipairs(core.get_connected_players()) do
        local snd = (math.random() < 0.5) and "_moewe" or "_ambient"
        core.sound_play(WORLD_ID .. snd, { to_player = player:get_player_name(), gain = 0.4 })
    end
end)

-- ------------------------------------------------------------
--  O) EXTRA: GISCHT  (cosy drifting sea spray)
--  A purely visual touch: soft sea-spray flecks drift around each
--  player - the island feels alive. Throttled and silent (no gameplay).
-- ------------------------------------------------------------
local spray_timer = 0
core.register_globalstep(function(dtime)
    spray_timer = spray_timer + dtime
    if spray_timer < 3.0 then return end
    spray_timer = 0
    for _, player in ipairs(core.get_connected_players()) do
        local p = player:get_pos()
        core.add_particlespawner({
            amount = 5, time = 3.0,
            minpos = { x = p.x - 6, y = p.y + 1, z = p.z - 6 },
            maxpos = { x = p.x + 6, y = p.y + 5, z = p.z + 6 },
            minvel = { x = -0.3, y = -0.2, z = -0.3 },
            maxvel = { x = 0.3,  y = 0.2, z = 0.3 },
            minacc = { x = -0.1, y = -0.1, z = -0.1 },
            maxacc = { x = 0.1,  y = 0,    z = 0.1 },
            minexptime = 3.0, maxexptime = 6.0, minsize = 1, maxsize = 2,
            texture = "[fill:8x8:#cfeffd",
            playername = player:get_player_name(),
        })
    end
end)

core.log("action", "[lernwelt_schatzinsel] Theme 'Schatzinsel' registered (on lernwelt engine).")
