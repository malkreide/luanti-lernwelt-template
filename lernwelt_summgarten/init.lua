-- ============================================================
--  THEME:  SUMM-GARTEN  (a friendly bees-&-flowers garden)
--  A brand-free garden learning world built ON TOP of the
--  reusable "lernwelt" engine. The whole educational frame -
--  blocks, learning zones, helpable garden animals, logbook,
--  ranks and badges - comes from one declarative
--  register_world{...} call.
--
--  The theme's heart connects NMG (Lehrplan 21: nature) with
--  GEOMETRIE/MATHEMATIK: children learn BESTAEUBUNG (pollination:
--  bees carry pollen, blossoms turn into fruit), the SECHSECK-
--  MUSTER of the honeycomb (Waben = hexagons -> Form & Raum),
--  FARBEN (the colours of the flowers) and ZAEHLEN (counting bees,
--  flowers and drops of honey). The base is a BIENENSTOCK (beehive)
--  and the garden has three zones: the BLUMENWIESE (flower meadow),
--  the OBSTGARTEN (orchard) and the HONIGLAGER (honey store).
--  (Lehrplan 21: NMG.1 Natur erkunden, MA.2 Form & Raum / Muster,
--   plus MA.1 Zaehlen and BG.1 Farben.)
--
--  Like the other "build-everything" example themes, Summ-Garten is
--  fully SELF-CONTAINED: it needs no extra mods. A mob API
--  (mobs_redo / mcl_mobs) is optional and only makes the garden
--  animals come alive - everything else (pollination, honey, the
--  honeycomb blocks, counting) works without it.
--
--  Things the engine cannot express live as small pieces of custom
--  code after register_world:
--    C) colourful FLOWERS (six colours) - the Farben + pollination
--       source on the meadow
--    D) the OBSTBLUETE crop (blossom -> pollinate -> fruit grows ->
--       Apfel): "Bestaeubung" made tangible (NMG.1)
--    E) the BESTAEUBUNGS-PINSEL (pollen brush: pollinates flowers &
--       blossoms nearby, collects Nektar)
--    F) the HONIGSCHLEUDER (Nektar -> Honig; like a little extractor)
--    G) the HONIGWABE (a filled honeycomb cell you harvest to COUNT
--       drops of honey; refills on a timer - the MA.1 Zaehlen heart)
--    H) garden items (Nektar, Honig, Apfel, Wachs)
--    I) a first-join starter kit (quick testing)
--    J) a land spawner so the bees & garden bugs come alive
--    K) base commands (Bienenstock-Garten, test station) + ambient
--       buzzing sound
--
--  The mod name equals the world id ("lernwelt_summgarten"), so all
--  nodes/items live in the "lernwelt_summgarten:" namespace.
--
--  Content is authored in German (ASCII: ae/oe/ue), like the other
--  example themes. The engine's own UI is translated separately
--  via lernwelt/locale/*.tr.
-- ============================================================

local WORLD_ID = "lernwelt_summgarten"
local function L(suffix) return WORLD_ID .. ":" .. suffix end

-- ------------------------------------------------------------
--  A honeycomb (Waben) texture generator - the geometric
--  signature of the theme. It paints offset hexagon-ish cells
--  (corners cut) onto a darker wax border, all procedurally via
--  "[fill" (no PNG needed). Used for the honeycomb blocks and the
--  collectible honey cell, so the SECHSECK-MUSTER appears all over.
-- ------------------------------------------------------------
local function honeycomb(cell, border)
    local t = "[fill:16x16:" .. border
    -- five offset cells = a little patch of honeycomb
    local cells = { { 1, 1 }, { 9, 1 }, { 5, 5 }, { 1, 9 }, { 9, 9 } }
    for _, c in ipairs(cells) do
        local x, y = c[1], c[2]
        t = t .. ("^[fill:6x6:%d,%d:%s"):format(x, y, cell)
        -- cut the four corners so each cell reads as a hexagon
        t = t .. ("^[fill:1x1:%d,%d:%s"):format(x,     y,     border)
        t = t .. ("^[fill:1x1:%d,%d:%s"):format(x + 5, y,     border)
        t = t .. ("^[fill:1x1:%d,%d:%s"):format(x,     y + 5, border)
        t = t .. ("^[fill:1x1:%d,%d:%s"):format(x + 5, y + 5, border)
    end
    return t
end

-- ------------------------------------------------------------
--  A) THE WHOLE LEARNING WORLD AS ONE DECLARATIVE TABLE
-- ------------------------------------------------------------
lernwelt.register_world({

    -- internal prefix; kept identical to the mod name so all
    -- nodes/items live in the "lernwelt_summgarten:" namespace
    id    = WORLD_ID,
    title = "Summ-Garten",

    -- --- 1) Peaceful, child-friendly world ---
    config = {
        damage      = false,   -- no damage / no dying
        creative    = true,    -- unlimited blocks
        peaceful    = true,    -- no monsters
        freeze_time = "day",   -- always bright and sunny
        no_weather  = true,
    },

    -- --- 2) A handful of warm, garden building blocks ---
    --  The "texture" field is a Luanti texture-modifier string: a
    --  base "[fill" plus overlaid "^[fill:WxH:X,Y:#colour" rectangles.
    --  The honeycomb blocks use the honeycomb() generator above.
    blocks = {
        -- The beehive (base): a classic straw skep + a wooden box hive.
        { suffix = "bienenstock", name = "Bienenstock (Strohkorb)",
          top  = "[fill:16x16:#caa046^[fill:10x10:3,3:#b8902f^[fill:4x4:6,6:#9c7a2a",
          side = "[fill:16x16:#d4ab4e^[fill:16x2:0,2:#b8902f^[fill:16x2:0,7:#b8902f" ..
                 "^[fill:16x2:0,12:#b8902f^[fill:4x4:6,9:#4a3318" },
        { suffix = "bienenkasten", name = "Bienenkasten (Holz)",
          top  = "[fill:16x16:#c79a5b^[fill:12x12:2,2:#b3854a",
          side = "[fill:16x16:#c79a5b^[fill:16x2:0,1:#9c6b3a^[fill:16x2:0,7:#9c6b3a" ..
                 "^[fill:16x2:0,13:#9c6b3a^[fill:5x3:6,9:#3a2a18" },

        -- Honeycomb / Waben (the geometric signature: hexagon pattern).
        { suffix = "wabe", name = "Honigwabe (leer) - Sechseck-Muster",
          texture = honeycomb("#e7d39a", "#b9914a") },
        { suffix = "wabe_gelb", name = "Wabe (gelb) - Muster-Block",
          texture = honeycomb("#f6d046", "#caa033") },
        { suffix = "wabe_orange", name = "Wabe (orange) - Muster-Block",
          texture = honeycomb("#f0a838", "#b87420") },
        { suffix = "wachsblock", name = "Wachsblock (Bienenwachs)",
          texture = "[fill:16x16:#f0d98a^[fill:16x2:0,4:#e3c86a^[fill:16x2:0,10:#e3c86a" },

        -- Honey jar (decoration / the extractor's product, as a block).
        { suffix = "honigglas", name = "Honigglas",
          top  = "[fill:16x16:#f6e6b0^[fill:8x8:4,4:#e8a838",
          side = "[fill:16x16:#cfe9f5^[fill:14x10:1,4:#e8a838^[fill:14x2:1,3:#f0c050" ..
                 "^[fill:6x4:5,7:#f6cf5a" },

        -- Garden ground, paths & fences.
        { suffix = "blumenwiese", name = "Blumenwiese",
          texture = "[fill:16x16:#5fae3a^[fill:2x2:3,3:#f1c40f^[fill:2x2:11,5:#ffffff" ..
                    "^[fill:2x2:6,10:#e74c3c^[fill:2x2:12,12:#9b59b6^[fill:2x2:8,2:#3498db" },
        { suffix = "gartenerde", name = "Gartenerde",
          texture = "[fill:16x16:#6b4a2b^[fill:16x2:0,2:#5a3d22^[fill:16x2:0,7:#5a3d22" ..
                    "^[fill:16x2:0,12:#5a3d22" },
        { suffix = "gartenweg", name = "Gartenweg (Trittsteine)",
          texture = "[fill:16x16:#9a9488^[fill:7x7:1,1:#8a8478^[fill:7x7:8,1:#857f73" ..
                    "^[fill:7x7:1,8:#857f73^[fill:7x7:8,8:#8a8478" },
        { suffix = "gartenzaun", name = "Gartenzaun",
          texture = "[fill:16x16:#caa46a^[fill:16x2:0,3:#8a5a2b^[fill:16x2:0,10:#8a5a2b" ..
                    "^[fill:2x16:3,0:#8a5a2b^[fill:2x16:11,0:#8a5a2b" },
        { suffix = "bluetenhecke", name = "Bluetenhecke",
          texture = "[fill:16x16:#3e7d2a^[fill:3x3:2,2:#ffffff^[fill:3x3:10,3:#e74c3c" ..
                    "^[fill:3x3:5,8:#f1c40f^[fill:3x3:11,10:#9b59b6^[fill:3x3:2,11:#ffffff" },

        -- A fruit tree (orchard) - trunk + blossoming leaves.
        { suffix = "obstbaum_stamm", name = "Obstbaum-Stamm",
          top    = "[fill:16x16:#9c6b3a^[fill:8x8:4,4:#82592f",
          side   = "[fill:16x16:#9c6b3a^[fill:16x2:0,3:#7a5128^[fill:16x2:0,11:#7a5128",
          bottom = "[fill:16x16:#7a5128" },
        { suffix = "obstbaum_laub", name = "Obstbaum-Laub (Bluete)",
          texture = "[fill:16x16:#4f9a32^[fill:3x3:2,2:#ffffff^[fill:3x3:11,4:#ffd6e6" ..
                    "^[fill:3x3:6,9:#ffffff^[fill:3x3:12,11:#ffd6e6^[fill:3x3:3,11:#ffe0ec" },

        -- A warm garden lantern.
        { suffix = "gartenlaterne", name = "Gartenlaterne",
          texture = "[fill:16x16:#5a3d22^[fill:8x10:4,3:#ffe08a^[fill:4x6:6,5:#fff6cf",
          glow = 12 },

        -- A fruit crate (decoration).
        { suffix = "obstkiste", name = "Obstkiste (Aepfel)",
          top  = "[fill:16x16:#9c6b3a^[fill:4x4:2,2:#e0392b^[fill:4x4:9,2:#e0392b" ..
                 "^[fill:4x4:2,9:#e0392b^[fill:4x4:9,9:#e0392b",
          side = "[fill:16x16:#9c6b3a^[fill:16x2:0,2:#7a5128^[fill:16x2:0,13:#7a5128" },

        -- Eigenes gemaltes Bild als Block? Lege eine PNG (16x16 oder 32x32)
        -- "lernwelt_summgarten_meinbild.png" in den textures/-Ordner und entferne
        -- die zwei Minuszeichen vor der naechsten Zeile:
        -- { suffix = "meinbild", name = "Mein Bild", texture = "lernwelt_summgarten_meinbild.png" },
    },

    -- --- 3) Learning zones (each gets a placeable learning board) ---
    -- Zone titles double as the "habitat" shown in the logbook.
    zones = {
        {
            id = "blumenwiese", title = "Blumenwiese", color = "#7cc14f",
            activity = "Auf der bunten Blumenwiese beginnt alles: Bienen, Hummeln und " ..
                       "Schmetterlinge fliegen von Blume zu Blume und BESTAEUBEN sie. " ..
                       "Lerne die FARBEN der Blueten kennen, lege ein Blumenmuster und " ..
                       "hilf den fleissigen Bestaeubern. (Bestaeubung verbindet Natur " ..
                       "mit Mustern.)",
            lehrplan = { "NMG.1", "BG.1", "NMG.2" },
            tasks = {
                { type = "quiz",
                  question = "Was machen Bienen an den Blueten?",
                  options = { "Sie bestaeuben sie", "Sie fressen sie auf", "Sie schlafen" }, answer = 1,
                  done = "Richtig! Bienen bestaeuben die Blueten - so koennen Fruechte wachsen." },
                { type = "pattern",
                  -- a colourful flower row (Farben + Muster)
                  sequence = { "#e74c3c", "#f1c40f", "#3498db" },
                  palette  = { { "#e74c3c", "Rot" }, { "#f1c40f", "Gelb" },
                               { "#3498db", "Blau" }, { "#ffffff", "Weiss" } },
                  done = "Schoen! Ein buntes Blumenmuster - rot, gelb, blau." },
                { type = "rescue", creature = "biene", count = 3,
                  done = "Stark! Drei Bienen geholfen - sie bestaeuben die Wiese." },
            },
        },
        {
            id = "obstgarten", title = "Obstgarten", color = "#e07a5f",
            activity = "Im Obstgarten siehst du, wozu die Bestaeubung gut ist: Aus einer " ..
                       "bestaeubten BLUETE waechst eine FRUCHT (ein Apfel). Marienkaefer, " ..
                       "Raupen und Regenwuermer helfen dem Garten. Zaehle die Tiere und " ..
                       "Fruechte. (NMG verbindet sich mit dem Zaehlen.)",
            lehrplan = { "NMG.1", "NMG.2", "MA.1" },
            tasks = {
                { type = "quiz",
                  question = "Aus einer bestaeubten Bluete wird ...?",
                  options = { "eine Frucht", "ein Stein", "ein Auto" }, answer = 1,
                  done = "Genau! Aus einer bestaeubten Bluete waechst eine Frucht." },
                { type = "quiz",
                  question = "Zaehle nach: Wie viele Beine hat eine Biene?",
                  options = { "6", "4", "8" }, answer = 1,
                  done = "Richtig! Eine Biene hat 6 Beine (so viele wie ein Sechseck Ecken hat)." },
                { type = "rescue", creature = "marienkaefer", count = 3,
                  done = "Klasse! Drei Marienkaefern geholfen - sie schuetzen die Pflanzen." },
            },
        },
        {
            id = "honiglager", title = "Honiglager", color = "#e8a838",
            activity = "Im Honiglager stapeln sich die WABEN. Eine Wabe ist ein SECHSECK " ..
                       "(6 Ecken) - viele Waben ergeben ein Muster. Setze das Waben-Muster " ..
                       "fort, zaehle die Honigtropfen und schleudere aus Nektar Honig. " ..
                       "(Geometrie/Muster - das Herz des Summ-Gartens.)",
            lehrplan = { "MA.2", "MA.1", "NMG.1" },
            tasks = {
                { type = "pattern",
                  -- the honeycomb pattern (gelb-orange ...) = Sechseck-Muster
                  sequence = { "#f1c40f", "#e67e22", "#f1c40f", "#e67e22" },
                  palette  = { { "#f1c40f", "Gelb" }, { "#e67e22", "Orange" },
                               { "#8a5a2b", "Braun" } },
                  done = "Toll! Du hast das Waben-Muster (Sechseck) fortgesetzt." },
                { type = "quiz",
                  question = "Wie viele Ecken hat eine Wabe (ein Sechseck)?",
                  options = { "6", "4", "3" }, answer = 1,
                  done = "Genau! Ein Sechseck - eine Wabe - hat 6 Ecken und 6 Seiten." },
                { type = "rescue", creature = "hummel", count = 2,
                  done = "Wunderbar! Zwei Hummeln am Honiglager geholfen." },
            },
        },
    },

    -- --- 4) Helpable garden animals (peaceful; right-click = help) ---
    --  The engine's own gentle "rescue" animals so the logbook,
    --  camera and rescue loop always work - even without a mob mod.
    creatures = {
        {
            id = "biene", name = "Biene", zone = "blumenwiese",
            color = "#f2c40f", size = 0.4, speed = 1.5, glow = 4, family = 2,
            food = "Bluetennektar", power = "Bestaeubt die Blueten - so wachsen Fruechte",
            heart = "#ffe9a0",
            rescue_text = "Geholfen! Die Biene summt von Blume zu Blume.",
        },
        {
            id = "hummel", name = "Hummel", zone = "blumenwiese",
            color = "#caa020", size = 0.5, speed = 1.1, family = 2,
            food = "Nektar und Pollen", power = "Dicke, fleissige Bestaeuberin",
            heart = "#ffe9a0",
            rescue_text = "Geholfen! Die Hummel brummt zufrieden weiter.",
        },
        {
            id = "schmetterling", name = "Schmetterling", zone = "blumenwiese",
            color = "#e67e22", size = 0.5, speed = 1.3,
            food = "Bluetennektar", power = "Bunt und leicht - bestaeubt im Flug",
            heart = "#ffd6e6",
            rescue_text = "Geholfen! Der Schmetterling flattert farbenfroh davon.",
        },
        {
            id = "marienkaefer", name = "Marienkaefer", zone = "obstgarten",
            color = "#e74c3c", size = 0.4, speed = 1.0, family = 2,
            food = "Blattlaeuse", power = "Frisst Schaedlinge - hilft dem Garten",
            heart = "#ffd0c0",
            rescue_text = "Geholfen! Der Marienkaefer krabbelt gluecklich aufs Blatt.",
        },
        {
            id = "raupe", name = "Raupe", zone = "obstgarten",
            color = "#6cae3a", size = 0.4, speed = 0.6,
            food = "Blaetter", power = "Wird einmal ein Schmetterling",
            heart = "#d8ecb8",
            rescue_text = "Geholfen! Die Raupe ringelt sich zufrieden ums Blatt.",
        },
        {
            id = "libelle", name = "Libelle", zone = "blumenwiese",
            color = "#3aa6c8", size = 0.5, speed = 1.6, glow = 2,
            food = "kleine Insekten", power = "Schillert ueber dem Gartenteich",
            heart = "#bfe9f5",
            rescue_text = "Geholfen! Die Libelle schwirrt schillernd davon.",
        },
        {
            id = "regenwurm", name = "Regenwurm", zone = "obstgarten",
            color = "#c98a8a", size = 0.4, speed = 0.5,
            food = "Erde und Blaetter", power = "Lockert den Boden - gut fuer die Pflanzen",
            heart = "#e8c4c4",
            rescue_text = "Geholfen! Der Regenwurm gleitet in die lockere Erde.",
        },
        {
            id = "ameise", name = "Ameise", zone = "obstgarten",
            color = "#7a4f1e", size = 0.3, speed = 1.4, family = 2,
            food = "Samen und Kruemel", power = "Traegt Schweres und arbeitet im Team",
            heart = "#d8b58a",
            rescue_text = "Geholfen! Die Ameise huscht zu ihrem Volk zurueck.",
        },
        {
            id = "grashuepfer", name = "Grashuepfer", zone = "blumenwiese",
            color = "#7cae3a", size = 0.4, speed = 1.5,
            food = "Gras", power = "Springt riesig weit",
            heart = "#d8ecb8",
            rescue_text = "Geholfen! Der Grashuepfer macht einen Riesensprung.",
        },
        {
            id = "igel", name = "Igel", zone = "obstgarten",
            color = "#9c7a52", size = 0.6, speed = 0.8,
            food = "Schnecken und Wuermer", power = "Rollt sich zur Stachelkugel",
            heart = "#d8c4a8",
            rescue_text = "Geholfen! Der Igel schnueffelt und trippelt ins Laub.",
        },
        {
            id = "amsel", name = "Amsel", zone = "obstgarten",
            color = "#2c2c2c", size = 0.6, speed = 1.2,
            food = "Wuermer und Beeren", power = "Singt morgens im Obstgarten",
            heart = "#f0c040",
            rescue_text = "Geholfen! Die Amsel zwitschert ein froehliches Lied.",
        },
        {
            id = "bienenkoenigin", name = "Bienenkoenigin", zone = "honiglager",
            color = "#f0a838", size = 0.7, speed = 0.9, glow = 6,
            food = "Gelee Royal", power = "Das Herz des Bienenvolks - legt alle Eier",
            heart = "#ffe27a",
            rescue_text = "Geholfen! Die Bienenkoenigin summt majestaetisch.",
        },
        {
            -- legendary, rare: never auto-spawns (egg/manual only)
            id = "goldbiene", name = "Goldene Honigbiene", zone = "honiglager",
            color = "#ffcf33", size = 0.5, speed = 1.4, glow = 12, rare = true,
            food = "Goldnektar", power = "Sehr selten - leuchtet golden und bringt Glueck",
            heart = "#ffe27a",
            rescue_text = "Die seltene Goldene Honigbiene schenkt dir ein goldenes Funkeln!",
        },
    },

    -- --- 5) Ranks (3rd field = colour -> creates a badge item) ---
    ranks = {
        { 0,  "Gartenkind" },
        { 5,  "Bluetenfreund" },
        { 10, "Bienenhelfer",     "#f1c40f" },
        { 25, "Gartenmeister",    "#e8a838" },
        { 50, "Summ-Garten-Held", "#ffcf33" },
    },

    -- --- 6) Logbook item ---
    logbook = { title = "Summ-Garten-Logbuch", item_color = "#e8a838" },

    -- --- 7) Plain texts for curriculum codes (for /lernplan & boards) ---
    kompetenzen = {
        ["NMG.1"] = "Natur erkunden: Bestaeubung, Pflanzen, Tiere und Lebensraeume wahrnehmen",
        ["NMG.2"] = "Tiere und Pflanzen (Insekten, Blumen) erkennen und benennen",
        ["MA.1"]  = "Mengen erfassen und zaehlen (Bienen, Blueten, Honigtropfen)",
        ["MA.2"]  = "Form und Raum: Muster und Formen (Sechseck/Waben) erkennen und fortsetzen",
        ["BG.1"]  = "Farben wahrnehmen, benennen und ordnen",
    },
})

-- ============================================================
--  THEME EXTRAS  (self-contained Lua the engine cannot express)
-- ============================================================

-- A small helper used by several extras: award a personal counter
-- with milestones (sound + chat), e.g. "bestaeubt", "geschleudert".
local function bump_counter(player, key, label, milestones)
    local meta = player:get_meta()
    local k    = WORLD_ID .. ":" .. key
    local n    = meta:get_int(k) + 1
    meta:set_int(k, n)
    local name = player:get_player_name()
    core.chat_send_player(name, label .. ": " .. n)
    local title = milestones and milestones[n]
    if title then
        core.sound_play("lernwelt_rankup", { to_player = name, gain = 1.0 })
        core.chat_send_player(name, "Toll! Du bist jetzt: " .. title .. "!")
    end
    return n
end

-- ------------------------------------------------------------
--  H) EXTRA: GARDEN ITEMS  (Nektar, Honig, Apfel, Wachs)
--  Tiny craftitems that form the theme's "Bluete -> Nektar ->
--  Honig" chain and the orchard's fruit.
-- ------------------------------------------------------------
core.register_craftitem(L("nektar"), {
    description     = "Nektar\nIn die Honigschleuder geben = Honig",
    inventory_image = "[fill:16x16:#0000^[fill:8x10:4,4:#f6cf5a^[fill:8x3:4,3:#f0c050" ..
                      "^[fill:4x4:6,7:#ffe9a0",
    groups          = { food = 1 },
})

core.register_craftitem(L("honig"), {
    description     = "Honig\nSuess und golden - frisch aus der Honigschleuder",
    inventory_image = "[fill:16x16:#cfe9f5^[fill:12x10:2,4:#e8a838^[fill:12x2:2,3:#f0c050" ..
                      "^[fill:5x4:5,6:#f6cf5a",
    groups          = { food = 2 },
    on_use          = core.item_eat and core.item_eat(2) or nil,
})

core.register_craftitem(L("apfel"), {
    description     = "Apfel\nGewachsen aus einer bestaeubten Bluete",
    inventory_image = "[fill:16x16:#0000^[fill:10x10:3,4:#e0392b^[fill:4x4:5,5:#f06a5a" ..
                      "^[fill:2x4:7,1:#5a8a2a",
    groups          = { food = 2 },
    on_use          = core.item_eat and core.item_eat(2) or nil,
})

core.register_craftitem(L("wachs"), {
    description     = "Bienenwachs\nBaustoff der Waben (Sechsecke)",
    inventory_image = "[fill:16x16:#0000^[fill:10x10:3,3:#f0d98a^[fill:10x2:3,6:#e3c86a",
    groups          = { food = 1 },
})

-- ------------------------------------------------------------
--  C) EXTRA: FLOWERS  (six colours: Farben + pollination source)
--  Cheerful plantlike flowers. They carry the group "bluete" so
--  the Bestaeubungs-Pinsel (E) recognises them, and they teach
--  colours (BG). Place them to make a colourful meadow.
-- ------------------------------------------------------------
local FLOWERS = {
    { "rot",    "Rote Blume",    "#e74c3c" },
    { "gelb",   "Gelbe Blume",   "#f1c40f" },
    { "blau",   "Blaue Blume",   "#3498db" },
    { "lila",   "Lila Blume",    "#9b59b6" },
    { "weiss",  "Weisse Blume",  "#f5f5f5" },
    { "orange", "Orange Blume",  "#e67e22" },
}

local function flower_tile(c)
    return "[fill:16x16:#0000^[fill:2x9:7,6:#3e7d2a^[fill:8x7:4,1:" .. c ..
           "^[fill:3x3:6,3:#ffe9a0"
end

for _, fl in ipairs(FLOWERS) do
    local suffix, label, col = fl[1], fl[2], fl[3]
    core.register_node(L("blume_" .. suffix), {
        description         = label .. "\nFarbe lernen - und vom Pinsel bestaeuben lassen",
        drawtype            = "plantlike",
        paramtype           = "light",
        sunlight_propagates = true,
        walkable            = false,
        waving              = 1,
        visual_scale        = 1.1,
        tiles               = { flower_tile(col) },
        inventory_image     = flower_tile(col),
        selection_box       = { type = "fixed", fixed = { -0.3, -0.5, -0.3, 0.3, 0.4, 0.3 } },
        groups              = { dig_immediate = 3, snappy = 3, flammable = 2,
                                plant = 1, bluete = 1, attached_node = 1 },
    })
end

-- ------------------------------------------------------------
--  D) EXTRA: OBSTBLUETE CROP  (Bestaeubung made tangible)
--  A fruit blossom that does NOT grow on its own. Brush it with
--  the Bestaeubungs-Pinsel (E) and it becomes a tiny fruit, which
--  then ripens on a timer through obstfrucht_1..3. The ripe stage
--  drops an Apfel + a new blossom (so the orchard is renewable).
--  This shows the core idea: no pollination -> no fruit (NMG.1).
-- ------------------------------------------------------------
local FRUIT_STAGES   = 3
local FRUIT_GROWTIME = 16   -- seconds per ripening stage

local function fruit_tile(stage)
    if stage == 1 then
        return "[fill:16x16:#0000^[fill:2x6:7,9:#3e7d2a^[fill:4x4:6,6:#7cae3a"
    elseif stage == 2 then
        return "[fill:16x16:#0000^[fill:2x5:7,10:#3e7d2a^[fill:6x6:5,5:#9cbf4a"
    else
        return "[fill:16x16:#0000^[fill:2x4:7,11:#3e7d2a^[fill:8x8:4,3:#e0392b" ..
               "^[fill:3x3:5,4:#f06a5a^[fill:2x3:7,1:#5a8a2a"
    end
end

-- The blossom: waits for pollination.
core.register_node(L("obstbluete"), {
    description         = "Obstbluete\nMit dem Bestaeubungs-Pinsel bestaeuben = Frucht waechst",
    drawtype            = "plantlike",
    paramtype           = "light",
    sunlight_propagates = true,
    walkable            = false,
    floodable           = true,
    waving              = 1,
    tiles               = { "[fill:16x16:#0000^[fill:2x7:7,8:#3e7d2a^[fill:4x4:4,3:#ffd6e6" ..
                            "^[fill:4x4:9,4:#ffe0ec^[fill:5x5:6,1:#ffffff^[fill:2x2:7,4:#f6cf5a" },
    inventory_image     = "[fill:16x16:#0000^[fill:2x7:7,8:#3e7d2a^[fill:6x6:5,2:#ffffff" ..
                          "^[fill:3x3:6,4:#ffd6e6",
    selection_box       = { type = "fixed", fixed = { -0.3, -0.5, -0.3, 0.3, 0.3, 0.3 } },
    groups              = { dig_immediate = 3, snappy = 3, flammable = 2,
                            plant = 1, obstbluete = 1, attached_node = 1 },
})

for stage = 1, FRUIT_STAGES do
    local ripe   = (stage == FRUIT_STAGES)
    local groups = { dig_immediate = 3, snappy = 3, flammable = 2, plant = 1,
                     attached_node = 1, not_in_creative_inventory = 1 }
    if not ripe then groups.growing = 1 end

    core.register_node(L("obstfrucht_" .. stage), {
        description         = "Frucht (Stufe " .. stage .. ")",
        drawtype            = "plantlike",
        paramtype           = "light",
        sunlight_propagates = true,
        walkable            = false,
        floodable           = true,
        waving              = 1,
        tiles               = { fruit_tile(stage) },
        selection_box       = { type = "fixed", fixed = { -0.3, -0.5, -0.3, 0.3, 0.2, 0.3 } },
        groups              = groups,
        drop                = ripe
            and { items = { { items = { L("apfel"), L("obstbluete") } } } }
            or  L("obstbluete"),
        on_timer = function(pos)
            if stage >= FRUIT_STAGES then return false end
            core.swap_node(pos, { name = L("obstfrucht_" .. (stage + 1)) })
            core.get_node_timer(pos):start(FRUIT_GROWTIME)
            return false
        end,
    })
end

-- ------------------------------------------------------------
--  E) EXTRA: BESTAEUBUNGS-PINSEL  (the pollen brush)
--  The theme's NMG.1 tool. Right-click a flower or blossom: pollen
--  puffs up, every Obstbluete nearby turns into a growing fruit,
--  growing fruits jump a stage, and you collect a little Nektar
--  from the flowers. Each successful pollination counts towards a
--  personal "Bestaeuber" milestone.
-- ------------------------------------------------------------
local POLLEN_RADIUS = 2
local POLLEN_MILESTONES = {
    [5]  = "Bestaeuber-Anfaenger",
    [15] = "Bestaeuber-Profi",
    [30] = "Bestaeuber-Meister",
}

-- Is this node a growing fruit we may advance?
local function is_growable(name)
    local def = core.registered_nodes[name]
    if not def or not def.groups then return false end
    return (def.groups.growing or def.groups.plant) ~= nil
end

local function pollinate(center)
    local pollinated, flowers = 0, 0
    for x = -POLLEN_RADIUS, POLLEN_RADIUS do
    for y = -1, 1 do
    for z = -POLLEN_RADIUS, POLLEN_RADIUS do
        local p    = { x = center.x + x, y = center.y + y, z = center.z + z }
        local node = core.get_node(p)
        local name = node.name
        local def  = core.registered_nodes[name]
        if name == L("obstbluete") then
            core.swap_node(p, { name = L("obstfrucht_1") })
            core.get_node_timer(p):start(FRUIT_GROWTIME)
            pollinated = pollinated + 1
        elseif def and def.groups and def.groups.bluete then
            flowers = flowers + 1
        else
            local base, num = name:match("^(.-)_(%d+)$")
            if base and num and is_growable(name) then
                local nextn = base .. "_" .. (tonumber(num) + 1)
                if core.registered_nodes[nextn] then
                    core.swap_node(p, { name = nextn, param2 = node.param2 })
                    pollinated = pollinated + 1
                end
            end
        end
    end end end
    return pollinated, flowers
end

core.register_tool(L("pinsel"), {
    description     = "Bestaeubungs-Pinsel\nRechtsklick auf eine Blume/Bluete = bestaeuben " ..
                      "(Pollen verteilen, Frucht wachsen lassen, Nektar sammeln)",
    inventory_image = "[fill:16x16:#0000^[fill:2x10:7,5:#9c6b3a^[fill:6x5:5,1:#f1c40f" ..
                      "^[fill:4x3:6,0:#f6cf5a",
    on_place = function(itemstack, placer, pointed_thing)
        if pointed_thing.type ~= "node" or not (placer and placer:is_player()) then
            return itemstack
        end
        local name   = placer:get_player_name()
        local center = pointed_thing.under
        local pollinated, flowers = pollinate(center)

        -- a puff of yellow pollen
        core.add_particlespawner({
            amount = 18, time = 0.3,
            minpos = { x = center.x - POLLEN_RADIUS, y = center.y, z = center.z - POLLEN_RADIUS },
            maxpos = { x = center.x + POLLEN_RADIUS, y = center.y + 1.5, z = center.z + POLLEN_RADIUS },
            minvel = { x = -0.3, y = 0.3, z = -0.3 }, maxvel = { x = 0.3, y = 1.2, z = 0.3 },
            minexptime = 0.5, maxexptime = 1.0, minsize = 1, maxsize = 2,
            texture = "[fill:8x8:#f6cf5a",
        })
        core.sound_play("lernwelt_rescue", { to_player = name, gain = 0.4 })

        -- collect a little nectar from flowers nearby
        if flowers > 0 then
            local inv = placer:get_inventory()
            if inv then inv:add_item("main", L("nektar")) end
        end

        if pollinated > 0 or flowers > 0 then
            bump_counter(placer, "bestaeubt", "Blueten bestaeubt", POLLEN_MILESTONES)
            if flowers > 0 then
                core.chat_send_player(name, "Du hast Nektar gesammelt - bring ihn zur Honigschleuder!")
            end
        else
            core.chat_send_player(name,
                "Hier ist keine Blume. Pflanze Blumen oder Obstblueten und bestaeube sie dann!")
        end
        return itemstack
    end,
})

-- ------------------------------------------------------------
--  F) EXTRA: HONIGSCHLEUDER  (Nektar -> Honig)
--  A little honey extractor: hold Nektar and right-click it to
--  spin out Honig. Each spin counts (milestones).
-- ------------------------------------------------------------
local SCHLEUDER_MILESTONES = {
    [5]  = "Imker-Lehrling",
    [15] = "Imker",
    [30] = "Imkermeister",
}

core.register_node(L("honigschleuder"), {
    description = "Honigschleuder\nNektar in die Hand nehmen, Rechtsklick = Honig schleudern",
    tiles = {
        "[fill:16x16:#c8c2b4^[fill:12x12:2,2:#e3ddcf^[fill:4x4:6,6:#e8a838",   -- top
        "[fill:16x16:#8a8478",                                                 -- bottom
        "[fill:16x16:#c8c2b4^[fill:16x3:0,6:#9a9488^[fill:4x10:6,4:#e3ddcf" ..
        "^[fill:2x10:7,4:#b9b3a4",                                             -- sides
    },
    paramtype2        = "facedir",
    groups            = { cracky = 2, oddly_breakable_by_hand = 2 },
    is_ground_content = false,
    on_rightclick = function(pos, node, clicker)
        if not (clicker and clicker:is_player()) then return end
        local name    = clicker:get_player_name()
        local wielded = clicker:get_wielded_item()
        if wielded:get_name() ~= L("nektar") then
            core.chat_send_player(name,
                "Die Honigschleuder braucht Nektar. Nimm 'Nektar' in die Hand und mach " ..
                "Rechtsklick. Nektar bekommst du, wenn du mit dem Pinsel Blumen bestaeubst.")
            return
        end
        if not core.is_creative_enabled(name) then
            wielded:take_item(); clicker:set_wielded_item(wielded)
        end
        local inv = clicker:get_inventory()
        if inv then inv:add_item("main", L("honig")) end

        core.add_particlespawner({
            amount = 12, time = 0.3,
            minpos = vector.subtract(pos, 0.4), maxpos = vector.add(pos, 0.6),
            minvel = { x = -0.4, y = 0.5, z = -0.4 }, maxvel = { x = 0.4, y = 1.5, z = 0.4 },
            minexptime = 0.4, maxexptime = 0.9, minsize = 1, maxsize = 2,
            texture = "[fill:8x8:#e8a838",
        })
        core.sound_play("lernwelt_rescue", { to_player = name, gain = 0.5 })
        core.chat_send_player(name, "Die Honigschleuder dreht sich - frischer Honig!")
        bump_counter(clicker, "geschleudert", "Honig geschleudert", SCHLEUDER_MILESTONES)
    end,
})

-- ------------------------------------------------------------
--  G) EXTRA: HONIGWABE  (a filled honey cell you COUNT)
--  A glowing honeycomb cell. Right-click to harvest one drop of
--  honey: a personal counter ticks up with milestones (MA.1
--  Zaehlen). The cell goes empty and refills on a timer, so kids
--  can keep counting how many drops they have collected.
-- ------------------------------------------------------------
local HONIG_REFILL = 15   -- seconds until an empty cell fills again
local COUNT_MILESTONES = {
    [5]  = "Honig-Sammler",
    [15] = "Honig-Kenner",
    [30] = "Honig-Meister",
}

core.register_node(L("honigwabe"), {
    description = "Honigwabe (gefuellt)\nRechtsklick = einen Honigtropfen ernten und zaehlen",
    tiles             = { honeycomb("#ffd24a", "#c8932f") },
    paramtype         = "light",
    light_source      = 4,
    groups            = { cracky = 3, oddly_breakable_by_hand = 2 },
    is_ground_content = false,
    on_rightclick = function(pos, node, clicker)
        if not (clicker and clicker:is_player()) then return end
        local name = clicker:get_player_name()
        local inv  = clicker:get_inventory()
        if inv then inv:add_item("main", L("honig")) end

        core.add_particlespawner({
            amount = 8, time = 0.3,
            minpos = vector.subtract(pos, 0.3), maxpos = vector.add(pos, 0.4),
            minvel = { x = -0.2, y = -1, z = -0.2 }, maxvel = { x = 0.2, y = -1.8, z = 0.2 },
            minexptime = 0.4, maxexptime = 0.8, minsize = 1, maxsize = 2,
            texture = "[fill:8x8:#e8a838",
        })
        core.sound_play("lernwelt_rescue", { to_player = name, gain = 0.4 })
        bump_counter(clicker, "honig_gesammelt", "Honigtropfen gezaehlt", COUNT_MILESTONES)

        -- empty the cell; it refills after a while
        core.swap_node(pos, { name = L("honigwabe_leer") })
        core.get_node_timer(pos):start(HONIG_REFILL)
    end,
})

core.register_node(L("honigwabe_leer"), {
    description       = "Honigwabe (leer)",
    tiles             = { honeycomb("#d8c48a", "#b0904a") },
    groups            = { cracky = 3, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1 },
    is_ground_content = false,
    drop              = L("wabe"),
    on_timer = function(pos)
        core.swap_node(pos, { name = L("honigwabe") })
        return false
    end,
})

-- ------------------------------------------------------------
--  I) EXTRA: STARTER KIT  (handed out once on first join)
--  Makes the world testable right away: logbook, camera, the
--  pollen brush, flowers, blossoms, all building blocks, the
--  honey extractor & a filled honey cell, some nectar/honey, and
--  one spawn egg per garden creature. Turn off via
--  "lernwelt_summgarten_starter_kit".
-- ------------------------------------------------------------
local STARTER_BLOCKS = {
    "bienenstock", "bienenkasten", "wabe", "wabe_gelb", "wabe_orange",
    "wachsblock", "honigglas", "blumenwiese", "gartenerde", "gartenweg",
    "gartenzaun", "bluetenhecke", "obstbaum_stamm", "obstbaum_laub",
    "gartenlaterne", "obstkiste",
    "honigschleuder", "honigwabe",
}
local STARTER_FLOWERS = {
    "blume_rot", "blume_gelb", "blume_blau", "blume_lila", "blume_weiss", "blume_orange",
}
-- Spawn-egg item names match the creature ids (world_id:creature_id)
local STARTER_EGGS = {
    "biene", "hummel", "schmetterling", "marienkaefer", "raupe", "libelle",
    "regenwurm", "ameise", "grashuepfer", "igel", "amsel", "bienenkoenigin", "goldbiene",
}

-- Add an item only if it is actually registered (robust).
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
    give_if_exists(inv, L("pinsel"))
    give_if_exists(inv, L("nektar") .. " 10")
    give_if_exists(inv, L("honig") .. " 5")
    give_if_exists(inv, L("obstbluete") .. " 10")
    for _, suffix in ipairs(STARTER_FLOWERS) do
        give_if_exists(inv, L(suffix) .. " 10")
    end
    for _, suffix in ipairs(STARTER_BLOCKS) do
        give_if_exists(inv, L(suffix) .. " 10")
    end
    for _, cid in ipairs(STARTER_EGGS) do
        give_if_exists(inv, L(cid))
    end
    core.chat_send_player(player:get_player_name(),
        "Summ-Garten: Startausruestung erhalten - Logbuch, Kamera, Bestaeubungs-Pinsel, " ..
        "Nektar + Honig, Blumen & Obstblueten, Bau-Bloecke (inkl. Honigschleuder & Honigwabe) " ..
        "und Spawn-Eier. Tipp: '/summgarten_bienenstock' baut dir einen ganzen Garten. " ..
        "Viel Spass im Summ-Garten!")
end

core.register_on_joinplayer(function(player)
    if not core.settings:get_bool("lernwelt_summgarten_starter_kit", true) then return end
    local meta = player:get_meta()
    if meta:get_int("lernwelt_summgarten:starter_given") == 1 then return end
    meta:set_int("lernwelt_summgarten:starter_given", 1)
    core.after(1.5, function()
        if player and player:is_player() then give_starter_kit(player) end
    end)
end)

-- ------------------------------------------------------------
--  J) CREATURE LAND SPAWNER  (a living garden)
--  The engine's built-in spawner only places water creatures, so
--  this small, backend-agnostic spawner brings the bees & bugs to
--  life: every so often it adds one non-rare creature on solid
--  ground near a player, capped so the garden never gets crowded.
--  Turn off with the setting "lernwelt_spawn_creatures".
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
--  K) EXTRA: BASE COMMANDS  (Bienenstock-Garten, test station)
--  Ready-made builds in front of you. All need the "server"
--  privilege (automatic in single-player).
-- ------------------------------------------------------------
local BOARDS = {
    L("tafel_blumenwiese"),
    L("tafel_obstgarten"),
    L("tafel_honiglager"),
}

-- The signature base: a sunny garden with the BIENENSTOCK in the
-- middle, the three learning boards, a colourful flower meadow
-- (already sown with flowers), a little orchard tree with
-- pollinatable blossoms, and a honey corner with a wall of waben,
-- a filled honey cell and the Honigschleuder.
core.register_chatcommand("summgarten_bienenstock", {
    description = "Baut einen ganzen Garten vor dir (Bienenstock, 3 Lern-Tafeln, " ..
                  "Blumenwiese, Obstbaum mit Blueten, Waben-Wand, Honigschleuder)",
    privs = { server = true },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then return false, "Dieser Befehl funktioniert nur im Spiel." end
        local b   = vector.round(player:get_pos())
        local fy  = b.y - 1
        local z0  = b.z + 2
        local W   = 5
        local DEEP = 9

        -- a grassy garden floor
        for dx = -W, W do
            for dz = 0, DEEP do
                core.set_node({ x = b.x + dx, y = fy, z = z0 + dz }, { name = L("blumenwiese") })
            end
        end
        -- a low garden fence around it
        for dx = -W, W do
            core.set_node({ x = b.x + dx, y = fy + 1, z = z0 },        { name = L("gartenzaun") })
            core.set_node({ x = b.x + dx, y = fy + 1, z = z0 + DEEP }, { name = L("gartenzaun") })
        end
        for dz = 0, DEEP do
            core.set_node({ x = b.x - W, y = fy + 1, z = z0 + dz }, { name = L("gartenzaun") })
            core.set_node({ x = b.x + W, y = fy + 1, z = z0 + dz }, { name = L("gartenzaun") })
        end

        -- the BIENENSTOCK in the middle (skep on a small wax stand)
        core.set_node({ x = b.x, y = fy + 1, z = z0 + 4 }, { name = L("wachsblock") })
        core.set_node({ x = b.x, y = fy + 2, z = z0 + 4 }, { name = L("bienenstock") })

        -- three learning boards along the back wall (inside)
        local xs = { -3, 0, 3 }
        for i, board in ipairs(BOARDS) do
            if core.registered_nodes[board] then
                core.set_node({ x = b.x + xs[i], y = fy + 1, z = z0 + DEEP - 1 },
                    { name = board, param2 = 2 })
            end
        end

        -- a colourful flower meadow on the left
        local cols = { "rot", "gelb", "blau", "lila", "weiss", "orange" }
        local ci = 1
        for dx = -W + 1, -W + 3 do
            for dz = 2, 5 do
                core.set_node({ x = b.x + dx, y = fy + 1, z = z0 + dz },
                    { name = L("blume_" .. cols[ci]) })
                ci = ci % #cols + 1
            end
        end

        -- a little orchard tree on the right, with pollinatable blossoms
        local tx, tz = b.x + W - 2, z0 + 3
        for dy = 1, 2 do
            core.set_node({ x = tx, y = fy + dy, z = tz }, { name = L("obstbaum_stamm") })
        end
        for ddx = -1, 1 do for ddz = -1, 1 do
            core.set_node({ x = tx + ddx, y = fy + 3, z = tz + ddz }, { name = L("obstbaum_laub") })
        end end
        core.set_node({ x = tx, y = fy + 4, z = tz }, { name = L("obstbaum_laub") })
        -- blossoms in the ground under the tree, waiting to be pollinated
        for ddx = -1, 1 do
            core.set_node({ x = tx + ddx, y = fy + 1, z = tz + 2 }, { name = L("obstbluete") })
        end

        -- a honey corner: a wall of waben + a filled cell + the extractor
        local hx, hz = b.x - W + 1, z0 + DEEP - 2
        for dy = 1, 2 do
            core.set_node({ x = hx,     y = fy + dy, z = hz }, { name = L("wabe_gelb") })
            core.set_node({ x = hx + 1, y = fy + dy, z = hz }, { name = L("wabe_orange") })
        end
        core.set_node({ x = hx,     y = fy + 1, z = hz - 1 }, { name = L("honigwabe") })
        core.set_node({ x = hx + 1, y = fy + 1, z = hz - 1 }, { name = L("honigschleuder") })

        -- a lantern for flair
        core.set_node({ x = b.x, y = fy + 3, z = z0 + 4 }, { name = L("gartenlaterne") })

        return true, "Garten gebaut! In der Mitte der Bienenstock, links die bunte " ..
                     "Blumenwiese (bestaeube sie mit dem Pinsel!), rechts der Obstbaum mit " ..
                     "Blueten, in der Ecke Waben + Honigschleuder, hinten die drei " ..
                     "Lern-Tafeln. Bestaeube, sammle Nektar, schleudere Honig und zaehle " ..
                     "die Honigtropfen!"
    end,
})

-- A small test station: a meadow, the three boards, a few flowers,
-- a blossom, a filled honey cell and the extractor.
core.register_chatcommand("summgarten_teststation", {
    description = "Baut eine kleine Test-Station vor dir (Boden, 3 Lern-Tafeln, " ..
                  "Blumen, Obstbluete, Honigwabe, Honigschleuder)",
    privs = { server = true },
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then return false, "Dieser Befehl funktioniert nur im Spiel." end
        local base    = vector.round(player:get_pos())
        local floor_y = base.y - 1

        for dx = -3, 3 do
            for dz = 2, 6 do
                core.set_node({ x = base.x + dx, y = floor_y, z = base.z + dz },
                    { name = L("blumenwiese") })
            end
        end

        local xs = { -2, 0, 2 }
        for i, board in ipairs(BOARDS) do
            if core.registered_nodes[board] then
                core.set_node({ x = base.x + xs[i], y = floor_y + 1, z = base.z + 6 },
                    { name = board, param2 = 2 })
            end
        end

        -- a small flower patch (Farben), a blossom, honey cell + extractor
        local cols = { "rot", "gelb", "blau" }
        for i, c in ipairs(cols) do
            core.set_node({ x = base.x - 2 + (i - 1), y = floor_y + 1, z = base.z + 2 },
                { name = L("blume_" .. c) })
        end
        core.set_node({ x = base.x - 2, y = floor_y + 1, z = base.z + 4 }, { name = L("obstbluete") })
        core.set_node({ x = base.x + 1, y = floor_y + 1, z = base.z + 4 }, { name = L("honigwabe") })
        core.set_node({ x = base.x + 2, y = floor_y + 1, z = base.z + 4 }, { name = L("honigschleuder") })

        return true, "Test-Station gebaut! Drei Lern-Tafeln, ein paar Blumen, eine " ..
                     "Obstbluete, eine Honigwabe und die Honigschleuder stehen vor dir " ..
                     "(Richtung +Z)."
    end,
})

-- ------------------------------------------------------------
--  L) EXTRA: AMBIENT-SOUND  (gentle bee buzzing)
--  Plays a gentle garden sound to each player now and then. The
--  .ogg files are optional (missing = silent, only a warning).
-- ------------------------------------------------------------
local amb_timer, amb_next = 0, 45
core.register_globalstep(function(dtime)
    amb_timer = amb_timer + dtime
    if amb_timer < amb_next then return end
    amb_timer = 0
    amb_next = 35 + math.random(0, 40)
    for _, player in ipairs(core.get_connected_players()) do
        local snd = (math.random() < 0.5) and "_summen" or "_ambient"
        core.sound_play(WORLD_ID .. snd, { to_player = player:get_player_name(), gain = 0.4 })
    end
end)

core.log("action", "[lernwelt_summgarten] Theme 'Summ-Garten' registered (on lernwelt engine).")
