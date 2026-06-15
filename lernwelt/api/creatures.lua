-- ------------------------------------------------------------
--  CREATURE SPAWNER + RESCUE + LOGBOOK
--  Friendly, rescuable animals (land or water). Right-click =
--  rescue -> heart particles, sound, counter, rank. Each world
--  gets its own logbook item (profiles + counters).
--
--  Creature entry in the world definition:
--    { id="schnecke", name="Snail", zone="wiese",
--      color="#f39c12", size=0.6, speed=0.3,
--      food="Leaves", power="Carries its house",
--      swims=false, glow=0,
--      rescue_text="Rescued! The snail crawls off happily." }
--
--  Without mobs_redo the blocks/zones/logbook still work - only
--  the living animals are missing.
-- ------------------------------------------------------------

local S = core.get_translator("lernwelt")

local function rescue_effect(pos, color)
    core.add_particlespawner({
        amount = 20, time = 0.4,
        minpos = vector.subtract(pos, 0.5), maxpos = vector.add(pos, 0.5),
        minvel = { x = -1, y = 1, z = -1 }, maxvel = { x = 1, y = 2, z = 1 },
        minexptime = 0.6, maxexptime = 1.0, minsize = 2, maxsize = 4,
        texture = "[fill:16x16:" .. (color or "#ff5fa2"),
    })
end

-- Called by the mob definition on right-click
function lernwelt.rescue(self, clicker, world_id, creature_id, heart_color, message)
    local pos = self.object:get_pos()
    if pos then rescue_effect(pos, heart_color) end
    self.object:remove()
    if not (clicker and clicker:is_player()) then return end

    if creature_id then
        local meta = clicker:get_meta()
        local k = "lernwelt:" .. world_id .. ":c_" .. creature_id
        meta:set_int(k, meta:get_int(k) + 1)
    end
    lernwelt.reward(clicker, world_id, message, heart_color)
end

function lernwelt.register_creatures(world_id, world)
    if not core.get_modpath("mobs") then
        core.log("warning", "[lernwelt] mobs_redo not found - world '" ..
            world_id .. "' runs without rescuable animals " ..
            "(blocks, zones and logbook still work).")
        return
    end

    for _, cr in ipairs(world.creatures or {}) do
        local id   = cr.id
        local full = world_id .. ":" .. id
        local size = cr.size or 0.7
        local col  = cr.color or "#cccccc"
        local glow = cr.glow or 0
        local hb   = size / 2

        local props = {
            type = "animal", passive = true, armor = 100,
            makes_footstep_sound = false,
            hp_min = 2, hp_max = 6,
            collisionbox = { -hb, -hb, -hb, hb, hb, hb },
            visual = "cube", visual_size = { x = size, y = size },
            textures = {{
                "[fill:16x16:" .. col, "[fill:16x16:" .. col,
                "[fill:16x16:" .. col, "[fill:16x16:" .. col,
                "[fill:16x16:" .. col, "[fill:16x16:" .. col,
            }},
            walk_velocity = cr.speed or 0.8,
            run_velocity  = (cr.speed or 0.8) * 2,
            fear_height = 0, fall_damage = 0, water_damage = 0, light_damage = 0,
            view_range = 8, runaway = (cr.shy ~= false),
            on_rightclick = function(self, clicker)
                lernwelt.rescue(self, clicker, world_id, id, cr.heart or "#ff5fa2",
                    cr.rescue_text or S("Rescued! @1 is happy.", cr.name or id))
            end,
        }

        if cr.swims then
            -- Water animal: swims in the water of various games
            props.fly    = true
            props.floats = 0
            props.rotate = 270
            props.fly_in = {
                "default:water_source", "default:water_flowing",
                "mcl_core:water_source", "mcl_core:water_flowing",
                "mcla:water_source", "mcla:water_flowing",
            }
        end

        if glow > 0 then
            props.on_spawn = function(self)
                self.object:set_properties({ glow = glow })
                return true
            end
        end

        mobs:register_mob(full, props)
        mobs:register_egg(full, S("@1 (spawn egg)", cr.name or id), "[fill:16x16:" .. col)
    end
end

-- ------------------------------------------------------------
--  LOGBOOK  (one item per world: profiles + personal counters)
-- ------------------------------------------------------------
function lernwelt.register_logbook(world_id, world)
    local lb        = world.logbook or {}
    local itemname  = world_id .. ":logbuch"
    local FORM      = "lernwelt:logbuch:" .. world_id
    local creatures = world.creatures or {}
    local esc       = core.formspec_escape

    local function zone_title(zid)
        for _, z in ipairs(world.zones or {}) do
            if z.id == zid then return z.title or z.id end
        end
        return zid or "-"
    end

    local function formspec(player, sel)
        local meta  = player:get_meta()
        local total = lernwelt.get_rescues(player, world_id)
        local f = {
            "formspec_version[4]", "size[12,9]",
            ("label[0.5,0.6;%s]"):format(esc(lb.title or "Logbook")),
            ("label[7.4,0.6;%s]"):format(S("Rank: @1", lernwelt.get_rank(world_id, total))),
            ("label[7.4,1.0;%s]"):format(S("Total rescued: @1", total)),
        }
        local y = 1.6
        for i, cr in ipairs(creatures) do
            local n = meta:get_int("lernwelt:" .. world_id .. ":c_" .. cr.id)
            f[#f + 1] = ("button[0.5,%f;3,0.8;sel_%d;%s (%d)]"):format(y, i, esc(cr.name or cr.id), n)
            y = y + 1.0
            if y > 8.2 then break end
        end
        local c = creatures[sel]
        if c then
            local n = meta:get_int("lernwelt:" .. world_id .. ":c_" .. c.id)
            f[#f + 1] = ("box[4.2,2.0;7.3,2.6;%s]"):format(c.color or "#888888")
            f[#f + 1] = ("label[4.4,5.0;%s]"):format(S("Name: @1", esc(c.name or c.id)))
            f[#f + 1] = ("label[4.4,5.5;%s]"):format(S("Habitat: @1", esc(zone_title(c.zone))))
            f[#f + 1] = ("label[4.4,6.0;%s]"):format(S("Eats: @1", esc(c.food or "-")))
            f[#f + 1] = ("label[4.4,6.5;%s]"):format(S("Power: @1", esc(c.power or "-")))
            f[#f + 1] = ("label[4.4,7.2;%s]"):format(S("Rescued: @1 times", n))
        end
        return table.concat(f)
    end

    local function show(player, sel)
        core.show_formspec(player:get_player_name(), FORM, formspec(player, sel))
    end

    core.register_craftitem(itemname, {
        description     = (lb.title or "Logbook") .. "\n" .. S("Right-click to open"),
        inventory_image = "[fill:16x16:" .. (lb.item_color or "#f1c40f") .. "^[fill:12x12:2,2:#ffffff",
        on_use = function(itemstack, user)
            if user and user:is_player() then show(user, 1) end
            return itemstack
        end,
    })

    core.register_on_player_receive_fields(function(player, formname, fields)
        if formname ~= FORM then return end
        for i = 1, #creatures do
            if fields["sel_" .. i] then show(player, i); return true end
        end
    end)
end
