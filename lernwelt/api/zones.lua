-- ------------------------------------------------------------
--  ZONE SYSTEM
--  Each zone gets a "learning board" (node). Right-click shows
--  the title, activity, curriculum references and - optionally -
--  small interactive TASKS. If the zone has an optional
--  pos={x,y,z}, a "Teleport here" button is shown.
--
--  Zone entry in the world definition:
--    { id="hoehle", title="Glow cave", color="#34495e",
--      activity="Find glowing mushrooms in the dark",
--      lehrplan={"NMG.3","MI.1"},
--      pos={x=20, y=2, z=-15},          -- optional
--      tasks={                          -- optional
--        { type="quiz", question="How many arms has a starfish?",
--          options={"5","3","8"}, answer=1,
--          done="Right! A starfish has 5 arms." },
--        { type="rescue", creature="seestern", count=3,
--          done="Done - three starfish rescued!" },
--      } }
--
--  Task progress is stored per player (meta). A solved task gives
--  a little sound + message and counts towards /lernfortschritt.
-- ------------------------------------------------------------

local S   = core.get_translator("lernwelt")
local esc = core.formspec_escape

local function task_key(wid, zid, i)
    return ("lernwelt:%s:task:%s:%d"):format(wid, zid, i)
end

local function is_done(player, wid, zid, i)
    return player:get_meta():get_int(task_key(wid, zid, i)) == 1
end

-- creature display name for rescue tasks
local function creature_name(world, cid)
    for _, c in ipairs(world.creatures or {}) do
        if c.id == cid then return c.name or cid end
    end
    return cid
end

local function rescued_count(player, wid, cid)
    return player:get_meta():get_int("lernwelt:" .. wid .. ":c_" .. cid)
end

-- Mark a task solved (once): counter + sound + message.
local function award_task(player, wid, zid, i, message)
    local meta = player:get_meta()
    if meta:get_int(task_key(wid, zid, i)) == 1 then return end
    meta:set_int(task_key(wid, zid, i), 1)
    local tkey = "lernwelt:" .. wid .. ":tasks"
    meta:set_int(tkey, meta:get_int(tkey) + 1)
    local name = player:get_player_name()
    core.sound_play("lernwelt_rescue", { to_player = name, gain = 1.0 })
    if message and message ~= "" then
        core.chat_send_player(name, message)
    end
end

-- Build the board formspec. Auto-completes rescue tasks that have
-- reached their goal (side effect on open).
local function build_formspec(player, world, z)
    local wid   = world.id
    local col   = z.color or "#34495e"
    local tasks = z.tasks or {}

    local f = {
        "formspec_version[4]", "size[12,10]",
        ("box[0,0;12,1;%s]"):format(col),
        ("label[0.4,0.5;%s]"):format(S("Learning station: @1", esc(z.title or z.id))),
        ("label[0.4,1.5;%s]"):format(S("Activity:")),
        ("textarea[0.4,1.8;11.2,1.5;;;%s]"):format(esc(z.activity or "")),
        ("label[0.4,3.6;%s]"):format(S("Curriculum:")),
    }
    local y = 4.0
    for _, t in ipairs(z.lehrplan or {}) do
        f[#f + 1] = ("label[0.6,%f;- %s]"):format(y, esc(lernwelt.describe(t)))
        y = y + 0.5
    end

    -- Tasks column (right side)
    if #tasks > 0 then
        f[#f + 1] = ("label[6.2,3.6;%s]"):format(S("Tasks:"))
        local ty = 4.0
        for i, t in ipairs(tasks) do
            if t.type == "rescue" then
                local have = rescued_count(player, wid, t.creature)
                local goal = t.count or 1
                if have >= goal and not is_done(player, wid, z.id, i) then
                    award_task(player, wid, z.id, i, t.done)
                end
                local mark = is_done(player, wid, z.id, i) and "[OK] " or ""
                f[#f + 1] = ("label[6.4,%f;%s%s]"):format(ty, mark,
                    esc(S("Rescue @1: @2/@3", creature_name(world, t.creature),
                        math.min(have, goal), goal)))
                ty = ty + 0.9
            elseif t.type == "quiz" then
                if is_done(player, wid, z.id, i) then
                    f[#f + 1] = ("label[6.4,%f;[OK] %s]"):format(ty,
                        esc(t.done or S("Solved")))
                    ty = ty + 0.9
                else
                    f[#f + 1] = ("label[6.4,%f;%s]"):format(ty, esc(t.question or "?"))
                    ty = ty + 0.45
                    local x = 6.4
                    for j, opt in ipairs(t.options or {}) do
                        f[#f + 1] = ("button[%f,%f;1.6,0.7;t%d_a%d;%s]")
                            :format(x, ty, i, j, esc(opt))
                        x = x + 1.7
                    end
                    ty = ty + 0.95
                end
            end
            if ty > 9.0 then break end
        end
    end

    if z.pos then
        f[#f + 1] = ("button_exit[9.4,9.0;2.4,0.8;tp;%s]"):format(S("Teleport here"))
    end
    return table.concat(f)
end

local function show_board(player, world, z)
    core.show_formspec(player:get_player_name(),
        "lernwelt:tafel:" .. world.id .. ":" .. z.id, build_formspec(player, world, z))
end

function lernwelt.register_zones(world_id, world)
    for _, z in ipairs(world.zones or {}) do
        local nodename = world_id .. ":tafel_" .. z.id
        local col      = z.color or "#34495e"

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
                    show_board(clicker, world, z)
                end
            end,
        })
    end
end

-- Single handler for all boards: teleport buttons + task answers.
core.register_on_player_receive_fields(function(player, formname, fields)
    local wid, zid = formname:match("^lernwelt:tafel:([^:]+):(.+)$")
    if not wid then return end
    local w = lernwelt.worlds[wid]
    if not w then return end

    local zone
    for _, z in ipairs(w.zones or {}) do
        if z.id == zid then zone = z; break end
    end
    if not zone then return end

    if fields.tp and zone.pos then
        player:set_pos(zone.pos)
        return true
    end

    -- quiz answers: field "t<i>_a<j>"
    for i, t in ipairs(zone.tasks or {}) do
        if t.type == "quiz" and not is_done(player, wid, zid, i) then
            for j = 1, #(t.options or {}) do
                if fields["t" .. i .. "_a" .. j] then
                    if j == t.answer then
                        award_task(player, wid, zid, i, t.done or S("Well done!"))
                    else
                        core.chat_send_player(player:get_player_name(), S("Try again!"))
                    end
                    show_board(player, w, zone)
                    return true
                end
            end
        end
    end
end)
