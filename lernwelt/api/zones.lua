-- ------------------------------------------------------------
--  ZONE SYSTEM
--  Each zone gets a "learning board" (node). Right-click shows
--  the title, activity and curriculum references. If the zone
--  has an optional pos={x,y,z}, a "Teleport here" button is
--  shown (handy against getting lost).
--
--  Zone entry in the world definition:
--    { id="hoehle", title="Glow cave", color="#34495e",
--      activity="Find glowing mushrooms in the dark",
--      lehrplan={"NMG.3","MI.1"},
--      pos={x=20, y=2, z=-15} }   -- optional
-- ------------------------------------------------------------

local S = core.get_translator("lernwelt")
local esc = core.formspec_escape

function lernwelt.register_zones(world_id, world)
    for _, z in ipairs(world.zones or {}) do
        local nodename = world_id .. ":tafel_" .. z.id
        local FORM     = "lernwelt:tafel:" .. world_id .. ":" .. z.id
        local col      = z.color or "#34495e"

        local function formspec()
            local f = {
                "formspec_version[4]", "size[10,7]",
                ("box[0,0;10,1;%s]"):format(col),
                ("label[0.4,0.5;%s]"):format(S("Learning station: @1", esc(z.title or z.id))),
                ("label[0.4,1.6;%s]"):format(S("Activity:")),
                ("textarea[0.4,1.9;9.2,1.6;;;%s]"):format(esc(z.activity or "")),
                ("label[0.4,3.8;%s]"):format(S("Curriculum:")),
            }
            local y = 4.2
            for _, t in ipairs(z.lehrplan or {}) do
                f[#f + 1] = ("label[0.6,%f;- %s]"):format(y, esc(lernwelt.describe(t)))
                y = y + 0.5
            end
            if z.pos then
                f[#f + 1] = ("button_exit[7.2,6.1;2.4,0.8;tp;%s]"):format(S("Teleport here"))
            end
            return table.concat(f)
        end

        core.register_node(nodename, {
            description         = S("Learning board: @1", z.title or z.id),
            drawtype            = "nodebox",
            paramtype           = "light",
            paramtype2          = "facedir",
            sunlight_propagates = true,
            tiles               = { "[fill:16x16:" .. col .. "^[fill:12x10:2,2:#ffffff" },
            node_box            = { type = "fixed", fixed = { -0.5, -0.2, 0.4, 0.5, 0.5, 0.5 } },
            groups              = { cracky = 3, oddly_breakable_by_hand = 2 },
            is_ground_content   = false,
            on_rightclick = function(pos, node, clicker)
                if clicker and clicker:is_player() then
                    core.show_formspec(clicker:get_player_name(), FORM, formspec())
                end
            end,
        })
    end
end

-- Single handler for all board teleports (formname pattern)
core.register_on_player_receive_fields(function(player, formname, fields)
    local wid, zid = formname:match("^lernwelt:tafel:([^:]+):(.+)$")
    if not wid or not fields.tp then return end
    local w = lernwelt.worlds[wid]
    if not w then return end
    for _, z in ipairs(w.zones or {}) do
        if z.id == zid and z.pos then
            player:set_pos(z.pos)
            return true
        end
    end
end)
