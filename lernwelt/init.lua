-- ============================================================
--  LERNWELT  -  Reusable educational-world template for Luanti
--  (Minetest 5.x). Encapsulates: peaceful config, zone system,
--  creature spawner, progress/ranks and Lehrplan-21 tagging.
--
--  A theme mod (e.g. lernwelt_beispiel) simply calls
--  lernwelt.register_world{...} - nothing else is required.
--
--  Note: 'core' is the modern API name; 'minetest' also works.
-- ============================================================

lernwelt = {}
lernwelt.version         = "1.1.0"
lernwelt.worlds          = {}   -- id -> world definition
lernwelt.active_world_id = nil  -- first registered world (for HUD)

local MP = core.get_modpath(core.get_current_modname())

-- Order matters: register.lua uses all other modules.
dofile(MP .. "/api/lehrplan.lua")
dofile(MP .. "/api/config.lua")
dofile(MP .. "/api/blocks.lua")
dofile(MP .. "/api/progress.lua")
dofile(MP .. "/api/creatures.lua")
dofile(MP .. "/api/zones.lua")
dofile(MP .. "/api/register.lua")

core.log("action", "[lernwelt] Engine " .. lernwelt.version .. " loaded.")
