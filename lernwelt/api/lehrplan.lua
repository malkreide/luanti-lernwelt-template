-- ------------------------------------------------------------
--  LEHRPLAN-21 TAGGING (curriculum tagging)
--  Every zone (and optionally every creature) can carry
--  curriculum tags, e.g. {"MA.1", "NMG.2", "MI.1"}. The prefix
--  before the first dot/space is the subject area; optional
--  plain-text descriptions can be added per code.
--
--  Ships with the Swiss curriculum "Lehrplan 21" as the default
--  subject table. Replace lernwelt.fachbereiche to use Common
--  Core, the National Curriculum, or any other framework.
-- ------------------------------------------------------------

local S = core.get_translator("lernwelt")

-- Subject areas of Lehrplan 21 (prefix -> display name)
lernwelt.fachbereiche = {
    MA  = S("Mathematics"),
    D   = S("German (language)"),
    NMG = S("Nature, people, society"),
    MI  = S("Media and informatics"),
    BG  = S("Visual arts"),
    TTG = S("Textile and technical design"),
    MU  = S("Music"),
    BS  = S("Movement and sport"),
    FS  = S("Foreign languages"),
    EZ  = S("Cross-curricular competencies"),
}

-- Optional plain-text descriptions per code (filled by themes)
lernwelt.kompetenzen = {}

function lernwelt.register_kompetenz(code, text)
    lernwelt.kompetenzen[code] = text
end

-- Derive the subject area from a tag (leading letters as prefix)
function lernwelt.fach_of(code)
    local prefix = tostring(code):match("^([A-Za-z]+)")
    if prefix then prefix = prefix:upper() end
    return lernwelt.fachbereiche[prefix], prefix
end

-- Readable description of a tag, e.g.
-- "MA.1  (Mathematics) - count and grasp quantities"
function lernwelt.describe(code)
    local fach  = lernwelt.fach_of(code)
    local extra = lernwelt.kompetenzen[code]
    local s = tostring(code)
    if fach  then s = s .. "  (" .. fach .. ")" end
    if extra then s = s .. " - " .. extra end
    return s
end

-- Overview of all learning zones + curriculum references
-- (for parents and teachers)
core.register_chatcommand("lernplan", {
    description = S("Show all learning zones and their Lehrplan-21 references"),
    func = function()
        local out = {}
        for id, w in pairs(lernwelt.worlds) do
            out[#out + 1] = "=== " .. (w.title or id) .. " ==="
            for _, z in ipairs(w.zones or {}) do
                out[#out + 1] = "[" .. (z.title or z.id) .. "]  " .. (z.activity or "")
                if z.lehrplan and #z.lehrplan > 0 then
                    out[#out + 1] = "   " .. S("Curriculum: @1", table.concat(z.lehrplan, ", "))
                end
            end
        end
        if #out == 0 then out[1] = S("No learning world registered yet.") end
        return true, table.concat(out, "\n")
    end,
})
