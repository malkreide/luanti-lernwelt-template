-- ------------------------------------------------------------
--  REGISTER_WORLD  -  the only function a theme calls.
--  Wires up config, blocks, zones, creatures, logbook and
--  progress from a single declarative table.
-- ------------------------------------------------------------

function lernwelt.register_world(def)
    assert(type(def) == "table", "[lernwelt] register_world expects a table")

    -- Every node/item this engine creates is registered under "<id>:...".
    -- Luanti only lets a mod register items in its own namespace, so the
    -- world id must equal the calling mod name. Default the id to the mod
    -- name (so themes can omit it) and verify any explicit id matches.
    local modname = core.get_current_modname()
    def.id = def.id or modname
    assert(def.id == modname, "[lernwelt] world id '" .. tostring(def.id) ..
        "' must match the mod name '" .. tostring(modname) .. "'. Every node " ..
        "and item is registered in the '" .. tostring(def.id) .. ":' namespace, " ..
        "which Luanti only allows for the current mod. Set id = '" ..
        tostring(modname) .. "' (or omit the id field).")

    lernwelt.worlds[def.id] = def
    if not lernwelt.active_world_id then
        lernwelt.active_world_id = def.id
    end

    -- Adopt optional plain-text descriptions for curriculum codes
    for code, text in pairs(def.kompetenzen or {}) do
        lernwelt.register_kompetenz(code, text)
    end

    lernwelt.apply_config(def.config)
    lernwelt.register_blocks(def.id, def.blocks)
    lernwelt.setup_badges(def.id)
    lernwelt.register_zones(def.id, def)
    lernwelt.register_creatures(def.id, def)
    lernwelt.register_logbook(def.id, def)

    core.log("action", ("[lernwelt] World loaded: %s (%d zones, %d animals, %d blocks)")
        :format(def.title or def.id,
                #(def.zones or {}), #(def.creatures or {}), #(def.blocks or {})))
end
