-- ------------------------------------------------------------
--  BLOCK GENERATOR
--  Builds colourful blocks from a simple palette - without any
--  PNG (via "[fill:16x16:#colour"). To use your own textures,
--  set b.texture = "file.png" in the world definition.
--
--  Entry in the world definition:
--    { suffix="pilz_rot", name="Red mushroom block",
--      color="#e74c3c", glow=6, glass=false }
-- ------------------------------------------------------------

function lernwelt.register_blocks(world_id, list)
    for _, b in ipairs(list or {}) do
        local nodename = world_id .. ":" .. b.suffix
        local glow = b.glow or 0
        local def = {
            description       = b.name or b.suffix,
            groups            = b.groups or { cracky = 3, oddly_breakable_by_hand = 2 },
            light_source      = glow,
            is_ground_content = false,
        }
        if b.glass then
            def.drawtype            = "glasslike"
            def.tiles               = { b.texture or ("[fill:16x16:" .. (b.color or "#aaddff") .. "^[opacity:120") }
            def.use_texture_alpha   = "blend"
            def.paramtype           = "light"
            def.sunlight_propagates = true
        else
            def.tiles = { b.texture or ("[fill:16x16:" .. (b.color or "#888888")) }
            if glow > 0 then def.paramtype = "light" end
        end
        core.register_node(nodename, def)
    end
end
