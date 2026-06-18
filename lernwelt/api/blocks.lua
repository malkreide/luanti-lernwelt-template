-- ------------------------------------------------------------
--  BLOCK GENERATOR
--  Builds colourful blocks from a simple palette - without any
--  PNG (via "[fill:16x16:#colour"). To use your own textures,
--  set b.texture = "file.png" in the world definition.
--
--  Entry in the world definition:
--    { suffix="pilz_rot", name="Red mushroom block",
--      color="#e74c3c", glow=6, glass=false }
--
--  The look of a block (in order of precedence):
--    texture = "file.png"  -- a single image/pattern for all faces
--                             (any Luanti texture string, incl. "[fill" patterns)
--    color   = "#rrggbb"   -- a single flat colour for all faces (default)
--  Per-face options (override the single look):
--    tiles  = { ... }      -- a raw Luanti tiles list (1-6 entries)
--    top / bottom / side   -- convenience: different faces, e.g. a chest
--                             with a lid on top and plain wood on the sides
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
            local base = b.texture or ("[fill:16x16:" .. (b.color or "#888888"))
            if b.tiles then
                def.tiles = b.tiles
            elseif b.top or b.bottom or b.side then
                -- 3-entry tiles = { top, bottom, sides }
                def.tiles = { b.top or base, b.bottom or base, b.side or base }
            else
                def.tiles = { base }
            end
            if glow > 0 then def.paramtype = "light" end
        end
        core.register_node(nodename, def)
    end
end
