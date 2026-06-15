-- ------------------------------------------------------------
--  MOB ADAPTER
--  One small wrapper over the two mob APIs found in the Luanti
--  ecosystem so the creature spawner works in every game:
--
--    * mobs_redo  (Minetest Game, many others)   -> global  mobs
--    * mcl_mobs   (VoxeLibre / Mineclonia)        -> global  mcl_mobs
--
--  Both APIs descend from the same code base, so a creature
--  definition table is almost identical. The only real
--  differences handled here are:
--    - the global table name (mobs vs mcl_mobs)
--    - the register_egg() signature (texture string vs colours)
--
--  Usage:
--    lernwelt.mobs.available()              -> bool
--    lernwelt.mobs.backend                  -> "mcl_mobs" | "mobs_redo" | nil
--    lernwelt.mobs.register_mob(name, def)
--    lernwelt.mobs.register_egg(name, description, color)
-- ------------------------------------------------------------

lernwelt.mobs = {}
local M = lernwelt.mobs

-- Detect the backend. Prefer mcl_mobs because some VoxeLibre /
-- Mineclonia builds also expose a legacy "mobs" alias, but the
-- mcl_mobs egg/spawn semantics are the ones we want there.
local function detect_backend()
    if rawget(_G, "mcl_mobs") and core.get_modpath("mcl_mobs") then
        return "mcl_mobs"
    end
    if rawget(_G, "mobs") and core.get_modpath("mobs") then
        return "mobs_redo"
    end
    return nil
end

M.backend = detect_backend()

function M.available()
    return M.backend ~= nil
end

-- Register a creature. The shared definition table (see
-- creatures.lua) is passed straight through; both APIs read the
-- same fields (type, passive, collisionbox, visual, textures,
-- walk_velocity, fly/fly_in, on_rightclick, on_spawn, ...).
function M.register_mob(name, def)
    if M.backend == "mcl_mobs" then
        mcl_mobs.register_mob(name, def)
    elseif M.backend == "mobs_redo" then
        mobs:register_mob(name, def)
    end
end

-- Register a creative/spawn egg.
--   color : a hex string like "#f39c12" (the creature's colour)
function M.register_egg(name, description, color)
    if M.backend == "mcl_mobs" then
        -- mcl_mobs.register_egg(mob, desc, background_color,
        --                       overlay_color, addegg, no_creative)
        -- Built-in greyscale egg textures are tinted by the colours;
        -- white spots keep it readable as an egg.
        mcl_mobs.register_egg(name, description, color, "#ffffff", false)
    elseif M.backend == "mobs_redo" then
        -- mobs:register_egg(name, desc, background, addegg, no_creative)
        -- background is an inventory-image string here.
        mobs:register_egg(name, description, "[fill:16x16:" .. color, false)
    end
end

if M.backend then
    core.log("action", "[lernwelt] Mob backend detected: " .. M.backend)
end
