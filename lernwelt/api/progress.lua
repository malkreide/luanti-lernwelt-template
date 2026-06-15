-- ------------------------------------------------------------
--  PROGRESS: counters, ranks, HUD, badges
--  Per-world counter (player meta). Ranks come from the world
--  definition (def.ranks) or from the default. A rank entry
--  with a third field (colour) auto-creates a badge item:
--    {10, "Forscher", "#2ecc71"}
-- ------------------------------------------------------------

local S = core.get_translator("lernwelt")

local huds = {}  -- player name -> hud id

-- Engine fallback only; themes normally define their own ranks.
lernwelt.default_ranks = {
    {0,  "Newcomer"},
    {5,  "Apprentice"},
    {10, "Explorer"},
    {25, "Pro"},
    {50, "Master"},
}

local function world_ranks(world_id)
    local w = lernwelt.worlds[world_id]
    return (w and w.ranks) or lernwelt.default_ranks
end

local function rescues_key(world_id) return "lernwelt:" .. world_id .. ":rescues" end
local function rank_key(world_id)    return "lernwelt:" .. world_id .. ":rank"    end

function lernwelt.get_rescues(player, world_id)
    return player:get_meta():get_int(rescues_key(world_id))
end

function lernwelt.get_rank(world_id, total)
    local ranks = world_ranks(world_id)
    local r = ranks[1][2]
    for _, e in ipairs(ranks) do
        if total >= e[1] then r = e[2] end
    end
    return r
end

function lernwelt.update_hud(player)
    local wid = lernwelt.active_world_id
    if not wid then return end
    local name = player:get_player_name()

    if not core.settings:get_bool("lernwelt_show_hud", true) then
        if huds[name] then player:hud_remove(huds[name]); huds[name] = nil end
        return
    end

    local w     = lernwelt.worlds[wid]
    local total = lernwelt.get_rescues(player, wid)
    local text  = S("@1 | @2 | @3 rescued", (w and w.title) or wid,
                    lernwelt.get_rank(wid, total), total)

    if huds[name] then
        player:hud_change(huds[name], "text", text)
    else
        huds[name] = player:hud_add({
            hud_elem_type = "text",
            position  = { x = 0, y = 0 }, offset = { x = 8, y = 8 },
            alignment = { x = 1, y = 1 }, scale  = { x = 100, y = 30 },
            text = text, number = 0xFFE066,
        })
    end
end

local function show_badge_popup(player, rank)
    local id = player:hud_add({
        hud_elem_type = "text",
        position = { x = 0.5, y = 0.35 }, alignment = { x = 0, y = 0 },
        scale = { x = 300, y = 80 },
        text = S("* BADGE: @1 *", rank), number = 0xFFD700,
    })
    core.after(4, function()
        if player and player:is_player() then player:hud_remove(id) end
    end)
end

-- Create badge items from rank entries that carry a colour field
function lernwelt.setup_badges(world_id)
    local w = lernwelt.worlds[world_id]
    w._badges = {}
    for _, e in ipairs(world_ranks(world_id)) do
        local rankname, color = e[2], e[3]
        if color then
            local itemname = world_id .. ":badge_" .. e[1]
            w._badges[rankname] = itemname
            core.register_craftitem(itemname, {
                description = S("@1 badge", rankname) .. "\n" ..
                              S("(Badge of honour - right-click shows your tally)"),
                inventory_image = "[fill:16x16:" .. color .. "^[fill:8x8:4,4:#ffffff",
                stack_max = 1,
                on_use = function(itemstack, user)
                    if user and user:is_player() then
                        local total = lernwelt.get_rescues(user, world_id)
                        core.chat_send_player(user:get_player_name(),
                            S("Rank: @1 | @2 rescued.", lernwelt.get_rank(world_id, total), total))
                    end
                    return itemstack
                end,
            })
        end
    end
end

-- Central reward: sound + counter + rank-up + badge + HUD.
-- Called by creatures.lua (rescue) but reusable for other
-- achievements (e.g. a solved puzzle).
function lernwelt.reward(player, world_id, message, heart_color)
    if not (player and player:is_player()) then return end
    local name  = player:get_player_name()
    local meta  = player:get_meta()
    local total = meta:get_int(rescues_key(world_id)) + 1
    meta:set_int(rescues_key(world_id), total)

    core.sound_play("lernwelt_rescue", { to_player = name, gain = 1.0 })
    core.chat_send_player(name, (message or S("Done!")) .. "   " .. S("No. @1!", total))

    local new_rank = lernwelt.get_rank(world_id, total)
    if new_rank ~= meta:get_string(rank_key(world_id)) then
        meta:set_string(rank_key(world_id), new_rank)
        core.chat_send_player(name, S("NEW RANK: @1! Well done!", new_rank))
        core.sound_play("lernwelt_rankup", { to_player = name, gain = 1.0 })
        show_badge_popup(player, new_rank)
        local w = lernwelt.worlds[world_id]
        local itemname = w._badges and w._badges[new_rank]
        if itemname then
            local inv = player:get_inventory()
            if inv and not inv:contains_item("main", itemname) then
                inv:add_item("main", itemname)
                core.chat_send_player(name, S("Badge received! (in your inventory)"))
            end
        end
    end
    lernwelt.update_hud(player)
end

core.register_on_joinplayer(function(player)
    core.after(0.5, function()
        if player and player:is_player() then lernwelt.update_hud(player) end
    end)
end)
core.register_on_leaveplayer(function(player)
    huds[player:get_player_name()] = nil
end)

-- Number of learning tasks (see zones.lua) the player has solved.
function lernwelt.get_tasks(player, world_id)
    return player:get_meta():get_int("lernwelt:" .. world_id .. ":tasks")
end

-- Distinct curriculum subject areas covered by a world's zones.
local function world_fachbereiche(world)
    local seen, list = {}, {}
    for _, z in ipairs(world.zones or {}) do
        for _, code in ipairs(z.lehrplan or {}) do
            local fach = lernwelt.fach_of(code)
            if fach and not seen[fach] then
                seen[fach] = true
                list[#list + 1] = fach
            end
        end
    end
    return list
end

-- Personal progress report (for the child, parent or teacher).
core.register_chatcommand("lernfortschritt", {
    description = S("Show your personal learning progress"),
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then return false, S("This command only works in game.") end
        local meta = player:get_meta()
        local out  = {}
        for wid, w in pairs(lernwelt.worlds) do
            local total = lernwelt.get_rescues(player, wid)
            out[#out + 1] = "=== " .. (w.title or wid) .. " ==="
            out[#out + 1] = S("Rank: @1 | @2 rescued.", lernwelt.get_rank(wid, total), total)
            out[#out + 1] = S("Tasks solved: @1", lernwelt.get_tasks(player, wid))
            local any = false
            for _, c in ipairs(w.creatures or {}) do
                local n = meta:get_int("lernwelt:" .. wid .. ":c_" .. c.id)
                if n > 0 then
                    if not any then out[#out + 1] = S("Animals rescued:"); any = true end
                    out[#out + 1] = "  " .. (c.name or c.id) .. ": " .. n
                end
            end
            local fb = world_fachbereiche(w)
            if #fb > 0 then
                out[#out + 1] = S("Learning areas: @1", table.concat(fb, ", "))
            end
        end
        if #out == 0 then out[1] = S("Nothing yet - go and explore!") end
        return true, table.concat(out, "\n")
    end,
})
