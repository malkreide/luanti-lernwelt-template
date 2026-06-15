-- ------------------------------------------------------------
--  REGISTER_WORLD  -  the only function a theme calls.
--  Wires up config, blocks, zones, creatures, logbook and
--  progress from a single declarative table.
-- ------------------------------------------------------------

function lernwelt.register_world(def)
    assert(type(def) == "table", "[lernwelt] register_world expects a table")
    assert(def.id, "[lernwelt] world needs an 'id' field (e.g. 'gluehpilz')")

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
