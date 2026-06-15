-- ============================================================
--  EXAMPLE THEME:  GLUEHPILZ-WALD  (glow-mushroom forest)
--  This is the ONLY file you edit for your own learning world.
--  Copy the "lernwelt_beispiel" folder, rename it (e.g.
--  "lernwelt_drachenhort"), change 'name' in mod.conf, then
--  swap the names, colours, zones, animals and curriculum tags
--  below. Textures are optional.
--
--  All mechanics (peaceful config, zone boards, logbook, ranks,
--  badges, rescue sounds) come automatically from the engine
--  mod "lernwelt".
--
--  NOTE: the world content below is authored in GERMAN, because
--  this example is a German learning world. An English author
--  would simply write English names/texts here. The engine's
--  own UI is translated separately via locale/*.tr.
-- ============================================================

lernwelt.register_world({

    -- internal prefix: MUST equal the mod name (here "lernwelt_beispiel"),
    -- because all nodes/items are registered in the "<id>:" namespace.
    -- You can also omit this line entirely - it then defaults to the mod name.
    id    = "lernwelt_beispiel",
    title = "Gluehpilz-Wald",

    -- --- 1) Peaceful world (all optional; these are the defaults) ---
    config = {
        damage      = false,   -- no damage / no dying
        creative    = true,    -- unlimited blocks
        peaceful    = true,    -- no monsters
        freeze_time = "day",   -- always day ("night" or number 0..1 possible)
        no_weather  = true,    -- no thunderstorms
    },

    -- --- 2) Block palette (colourful glowing mushrooms; no PNG) ---
    blocks = {
        { suffix = "pilz_rot",   name = "Roter Leuchtpilz",   color = "#e74c3c", glow = 7 },
        { suffix = "pilz_blau",  name = "Blauer Leuchtpilz",  color = "#3498db", glow = 9 },
        { suffix = "pilz_gelb",  name = "Gelber Leuchtpilz",  color = "#f1c40f", glow = 8 },
        { suffix = "pilz_gruen", name = "Gruener Leuchtpilz", color = "#2ecc71", glow = 7 },
        { suffix = "pilz_pink",  name = "Pinker Leuchtpilz",  color = "#e84393", glow = 9 },
        { suffix = "weg",        name = "Waldweg",            color = "#9b7653", glow = 0 },
        { suffix = "haus_glas",  name = "Pilzhaus-Glas",      color = "#d6eaf8", glass = true },
    },

    -- --- 3) Learning zones (each gets a placeable learning board) ---
    -- Tip: an optional pos={x,y,z} unlocks the "Teleport here" button.
    zones = {
        {
            id = "dorf", title = "Pilzdorf", color = "#8e44ad",
            activity = "Pilzhaeuser zaehlen und benennen, Wege legen, " ..
                       "Missionen planen.",
            lehrplan = { "MA.1", "D.2", "MI.1" },
        },
        {
            id = "hoehle", title = "Glueh-Hoehle", color = "#2c3e50",
            activity = "Im Dunkeln leuchtende Pilze suchen, hell und dunkel " ..
                       "unterscheiden, mutig erkunden.",
            lehrplan = { "NMG.3", "BS.2" },
        },
        {
            id = "wiese", title = "Bach-Wiese", color = "#27ae60",
            activity = "Tiere sortieren, Groessen vergleichen, Muster legen " ..
                       "(rot-gelb-rot-gelb).",
            lehrplan = { "MA.2", "NMG.2" },
        },
    },

    -- --- 4) Rescuable animals (peaceful; right-click = rescue) ---
    creatures = {
        {
            id = "schnecke", name = "Schnecke", zone = "wiese",
            color = "#f39c12", size = 0.6, speed = 0.3,
            food = "Blaetter", power = "Traegt ihr Haus mit sich",
            rescue_text = "Gerettet! Die Schnecke kriecht zufrieden davon.",
        },
        {
            id = "marienkaefer", name = "Marienkaefer", zone = "wiese",
            color = "#c0392b", size = 0.5, speed = 0.6,
            food = "Blattlaeuse", power = "Hat Punkte zum Zaehlen",
            rescue_text = "Gerettet! Der Marienkaefer fliegt summend los.",
        },
        {
            id = "gluehkaefer", name = "Gluehkaefer", zone = "hoehle",
            color = "#f7dc6f", size = 0.5, speed = 0.7, glow = 13,
            food = "Pollen", power = "Leuchtet im Dunkeln",
            heart = "#f9e79f",
            rescue_text = "Gerettet! Der Gluehkaefer leuchtet dir dankbar nach.",
        },
        {
            id = "fledermaus", name = "Fledermaus", zone = "hoehle",
            color = "#5d6d7e", size = 0.6, speed = 1.0,
            food = "Insekten", power = "Hoert mit den Ohren (Echo)",
            rescue_text = "Gerettet! Die Fledermaus flattert in die Hoehle zurueck.",
        },
        {
            id = "igel", name = "Igel", zone = "dorf",
            color = "#7e5109", size = 0.6, speed = 0.5,
            food = "Wuermer", power = "Stacheln zum Schutz",
            rescue_text = "Gerettet! Der Igel trippelt ins Pilzdorf.",
        },
        {
            id = "molch", name = "Molch", zone = "wiese",
            color = "#16a085", size = 0.5, speed = 0.6, swims = true,
            food = "kleine Kaefer", power = "Schwimmt und laeuft",
            heart = "#a3e4d7",
            rescue_text = "Gerettet! Der Molch taucht in den Bach.",
        },
    },

    -- --- 5) Ranks (3rd field = colour -> creates a badge item) ---
    ranks = {
        { 0,  "Pilz-Frischling" },
        { 5,  "Pilz-Spaeher" },
        { 10, "Pilz-Forscher", "#2ecc71" },
        { 25, "Pilz-Hueter",   "#f1c40f" },
    },

    -- --- 6) Logbook item ---
    logbook = { title = "Pilz-Forscher-Logbuch", item_color = "#9b59b6" },

    -- --- 7) Optional plain texts for curriculum codes (for /lernplan & boards) ---
    kompetenzen = {
        ["MA.1"]  = "Mengen erfassen und zaehlen",
        ["MA.2"]  = "Muster und Reihenfolgen bilden",
        ["D.2"]   = "Begriffe benennen, sich mitteilen",
        ["NMG.2"] = "Tiere und Lebensraeume erkunden",
        ["NMG.3"] = "Sich orientieren, hell/dunkel erleben",
        ["MI.1"]  = "Einfache Ablaeufe planen",
        ["BS.2"]  = "Sich mutig im Raum bewegen",
    },
})

-- ------------------------------------------------------------
--  Backwards compatibility: when this example's id was aligned
--  to the mod name, its nodes/items moved from "gluehpilz:" to
--  "lernwelt_beispiel:". These aliases keep anything built or
--  held under the old prefix from becoming unknown. The suffixes
--  are unchanged, so it is a plain prefix swap.
-- ------------------------------------------------------------
local legacy_suffixes = {
    "pilz_rot", "pilz_blau", "pilz_gelb", "pilz_gruen", "pilz_pink",
    "weg", "haus_glas",                                  -- blocks
    "logbuch", "badge_10", "badge_25",                  -- held items
    "tafel_dorf", "tafel_hoehle", "tafel_wiese",        -- learning boards
    "schnecke", "marienkaefer", "gluehkaefer",          -- creatures / spawn eggs
    "fledermaus", "igel", "molch",
}
for _, suffix in ipairs(legacy_suffixes) do
    core.register_alias("gluehpilz:" .. suffix, "lernwelt_beispiel:" .. suffix)
end

core.log("action", "[lernwelt_beispiel] Gluehpilz-Wald registered.")
