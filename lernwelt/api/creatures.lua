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
--  The living animals need a mob API: mobs_redo (Minetest Game)
--  or mcl_mobs (VoxeLibre / Mineclonia). The mob adapter
--  (mobs_adapter.lua) picks whichever is present. Without any
--  mob API the blocks/zones/logbook still work - only the living
--  animals are missing.
-- ------------------------------------------------------------

local S = core.get_translator("lernwelt")

-- world_id -> list of full creature names that swim (filled at register time)
lernwelt.water_spawns = lernwelt.water_spawns or {}

-- "Discovered" tracking for the camera / explorer mode.
function lernwelt.is_seen(player, world_id, cid)
    return player:get_meta():get_int("lernwelt:" .. world_id .. ":seen_" .. cid) == 1
end
function lernwelt.set_seen(player, world_id, cid)
    player:get_meta():set_int("lernwelt:" .. world_id .. ":seen_" .. cid, 1)
end
function lernwelt.seen_count(player, world)
    local n = 0
    for _, c in ipairs(world.creatures or {}) do
        if lernwelt.is_seen(player, world.id, c.id) then n = n + 1 end
    end
    return n
end

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
    local pos     = self.object:get_pos()
    local is_baby = self._is_baby
    if pos then rescue_effect(pos, heart_color) end
    self.object:remove()
    if not (clicker and clicker:is_player()) then return end

    if creature_id then
        local meta = clicker:get_meta()
        local k = "lernwelt:" .. world_id .. ":c_" .. creature_id
        meta:set_int(k, meta:get_int(k) + 1)
    end
    lernwelt.reward(clicker, world_id, message, heart_color)

    -- Family reunion: a parent (not a baby) brings little ones along.
    local world = lernwelt.worlds[world_id]
    local cr
    for _, c in ipairs((world or {}).creatures or {}) do
        if c.id == creature_id then cr = c; break end
    end
    if cr and cr.family and cr.family > 0 and not is_baby and pos then
        for _ = 1, cr.family do
            local off = {
                x = pos.x + math.random(-2, 2), y = pos.y,
                z = pos.z + math.random(-2, 2),
            }
            local obj = core.add_entity(off, world_id .. ":" .. creature_id)
            local le  = obj and obj:get_luaentity()
            if le then le._is_baby = true end
        end
        core.chat_send_player(clicker:get_player_name(),
            S("@1 is reunited with its family!", cr.name or creature_id))
    end
end

function lernwelt.register_creatures(world_id, world)
    if not lernwelt.mobs.available() then
        core.log("warning", "[lernwelt] no mob API found (mobs_redo or " ..
            "mcl_mobs) - world '" .. world_id .. "' runs without " ..
            "rescuable animals (blocks, zones and logbook still work).")
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

        lernwelt.mobs.register_mob(full, props)
        lernwelt.mobs.register_egg(full, S("@1 (spawn egg)", cr.name or id), col)

        -- Remember water animals so the engine can spawn them in water.
        -- Creatures flagged "rare" are excluded (egg/manual only).
        if cr.swims and not cr.rare then
            lernwelt.water_spawns[world_id] = lernwelt.water_spawns[world_id] or {}
            table.insert(lernwelt.water_spawns[world_id], full)
        end
    end
end

-- ------------------------------------------------------------
--  WATER SPAWNER (optional, on by default)
--  A light, backend-agnostic spawner: every so often it tries to
--  add one water animal of the active world near a player, inside
--  water, capped so the sea never gets crowded. Turn off with the
--  setting "lernwelt_spawn_creatures".
-- ------------------------------------------------------------
local WATER = {
    ["default:water_source"] = true, ["default:water_flowing"] = true,
    ["mcl_core:water_source"] = true, ["mcl_core:water_flowing"] = true,
    ["mcla:water_source"] = true, ["mcla:water_flowing"] = true,
}

local spawn_timer = 0
core.register_globalstep(function(dtime)
    if not lernwelt.mobs.available() then return end
    if not core.settings:get_bool("lernwelt_spawn_creatures", true) then return end

    spawn_timer = spawn_timer + dtime
    if spawn_timer < 11 then return end
    spawn_timer = 0

    local wid  = lernwelt.active_world_id
    local list = wid and lernwelt.water_spawns[wid]
    if not list or #list == 0 then return end

    for _, player in ipairs(core.get_connected_players()) do
        if math.random() < 0.7 then
            local pp   = player:get_pos()
            local ang  = math.random() * math.pi * 2
            local dist = 10 + math.random(0, 16)
            local cx   = math.floor(pp.x + math.cos(ang) * dist)
            local cz   = math.floor(pp.z + math.sin(ang) * dist)

            -- find a water node (with water above it) near the player's depth
            local spawn_pos
            for dy = 2, -8, -1 do
                local p = { x = cx, y = math.floor(pp.y) + dy, z = cz }
                if WATER[core.get_node(p).name]
                   and WATER[core.get_node({ x = p.x, y = p.y + 1, z = p.z }).name] then
                    spawn_pos = p
                    break
                end
            end

            if spawn_pos then
                -- cap: at most 5 of this world's creatures nearby
                local count = 0
                local prefix = wid .. ":"
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
        f[#f + 1] = ("label[7.4,1.4;%s]"):format(S("Discovered: @1/@2",
            lernwelt.seen_count(player, world), #creatures))
        local y = 1.6
        for i, cr in ipairs(creatures) do
            local n = meta:get_int("lernwelt:" .. world_id .. ":c_" .. cr.id)
            local mark = lernwelt.is_seen(player, world_id, cr.id) and " [*]" or ""
            f[#f + 1] = ("button[0.5,%f;3,0.8;sel_%d;%s (%d)%s]")
                :format(y, i, esc(cr.name or cr.id), n, mark)
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
            f[#f + 1] = ("label[4.4,7.0;%s]"):format(S("Rescued: @1 times", n))
            f[#f + 1] = ("label[4.4,7.5;%s]"):format(lernwelt.is_seen(player, world_id, c.id)
                and S("Discovered with the camera") or S("Not discovered yet"))
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

-- ------------------------------------------------------------
--  CAMERA / EXPLORER MODE  (one item per world)
--  Left-click photographs the nearest not-yet-discovered animal
--  of this world within range and marks it "discovered" in the
--  logbook - a gentle collecting loop separate from rescuing.
-- ------------------------------------------------------------
function lernwelt.register_camera(world_id, world)
    local itemname = world_id .. ":kamera"
    local prefix   = world_id .. ":"

    local function display(cid)
        for _, c in ipairs(world.creatures or {}) do
            if c.id == cid then return c.name or cid, (c.heart or c.color) end
        end
    end

    core.register_craftitem(itemname, {
        description     = S("Camera") .. "\n" .. S("Left-click: photograph a nearby animal"),
        inventory_image = "[fill:16x16:#2c3e50^[fill:9x6:4,5:#aaddff",
        on_use = function(itemstack, user)
            if not (user and user:is_player()) then return itemstack end
            local pos = user:get_pos()
            local best, best_d, best_cid
            for _, obj in ipairs(core.get_objects_inside_radius(pos, 12)) do
                local le = obj:get_luaentity()
                if le and le.name and le.name:sub(1, #prefix) == prefix then
                    local cid = le.name:sub(#prefix + 1)
                    if display(cid) and not lernwelt.is_seen(user, world_id, cid) then
                        local d = vector.distance(pos, obj:get_pos())
                        if not best_d or d < best_d then
                            best, best_d, best_cid = obj, d, cid
                        end
                    end
                end
            end
            local name = user:get_player_name()
            if best_cid then
                lernwelt.set_seen(user, world_id, best_cid)
                local disp, hp = display(best_cid)
                local p = best:get_pos()
                if p then rescue_effect(p, hp or "#ffffff") end
                core.sound_play("lernwelt_rescue", { to_player = name, gain = 0.7 })
                core.chat_send_player(name, S("Photographed: @1!", disp or best_cid) ..
                    "  " .. S("Discovered: @1/@2",
                        lernwelt.seen_count(user, world), #(world.creatures or {})))
            else
                core.chat_send_player(name, S("No new animal nearby - get closer to one."))
            end
            return itemstack
        end,
    })
end
