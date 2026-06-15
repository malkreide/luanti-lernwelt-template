-- ------------------------------------------------------------
--  PEACEFUL CONFIGURATION
--  Sets at runtime everything that can be set safely (damage
--  off, creative, peaceful mobs only, frozen daytime) and
--  collects recommended lines for minetest.conf (shown by the
--  /lernwelt command).
-- ------------------------------------------------------------

local S = core.get_translator("lernwelt")

lernwelt.config_defaults = {
    damage      = false,   -- enable_damage
    creative    = true,    -- creative_mode
    peaceful    = true,    -- peaceful mobs only (no monsters)
    freeze_time = "day",   -- false | "day" | "night" | number 0..1
    no_weather  = true,    -- thunder/weather off (game dependent)
}

lernwelt.recommended_conf = {}

local function rec(line)
    lernwelt.recommended_conf[#lernwelt.recommended_conf + 1] = line
end

function lernwelt.apply_config(cfg)
    local c = {}
    for k, v in pairs(lernwelt.config_defaults) do c[k] = v end
    for k, v in pairs(cfg or {}) do c[k] = v end
    lernwelt.active_config = c

    local s = core.settings

    if c.damage == false then
        s:set("enable_damage", "false")
        rec("enable_damage = false")
    end
    if c.creative == true then
        s:set("creative_mode", "true")
        rec("creative_mode = true")
    end
    if c.peaceful == true then
        -- mobs_redo / Minetest Game:
        s:set("only_peaceful_mobs", "true")
        rec("only_peaceful_mobs = true")
        -- VoxeLibre / Mineclonia (only effective in that game):
        s:set("mcl_mob_cap_monster", "0")
        s:set("mcl_mob_cap_phantom", "0")
        s:set("mcl_mob_cap_patrol",  "0")
        s:set("mcl_mob_cap_raid",    "0")
        rec("mcl_mob_cap_monster = 0    # VoxeLibre/Mineclonia only")
    end
    if c.no_weather == true then
        s:set("mcl_doWeatherCycle", "false")
        rec("mcl_doWeatherCycle = false # VoxeLibre/Mineclonia only")
    end

    -- Freeze the time of day (prevents dark, scary nights)
    local tod
    if c.freeze_time == "day"   then tod = 0.5
    elseif c.freeze_time == "night" then tod = 0.0
    elseif type(c.freeze_time) == "number" then tod = c.freeze_time end
    if tod ~= nil then
        s:set("time_speed", "0")
        rec("time_speed = 0")
        lernwelt._timeofday = tod
        core.after(0, function() core.set_timeofday(tod) end)
    end
end

-- Re-apply the frozen time on join (robust after load)
core.register_on_joinplayer(function()
    if lernwelt._timeofday ~= nil then
        core.set_timeofday(lernwelt._timeofday)
    end
end)

-- Show status + copy-paste minetest.conf lines
core.register_chatcommand("lernwelt", {
    description = S("Lernwelt status and recommended minetest.conf lines"),
    func = function()
        local n = 0
        for _ in pairs(lernwelt.worlds) do n = n + 1 end
        local out = {
            S("Lernwelt engine @1", lernwelt.version or "?"),
            S("Registered worlds: @1", n),
            "",
            S("Recommended minetest.conf lines (the engine already sets most at runtime):"),
        }
        for _, l in ipairs(lernwelt.recommended_conf) do
            out[#out + 1] = "  " .. l
        end
        return true, table.concat(out, "\n")
    end,
})
