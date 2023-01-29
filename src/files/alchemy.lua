local AlchemyGenerator = dofile_once(GLOBAL.files_path .. "/alchemy_generator.lua")
local AlchemyGui = dofile_once(GLOBAL.files_path .. "/alchemy_gui.lua") 

-- local AlchemyGenerator = require "alchemy_generator"
-- local AlchemyGui = require "alchemy_gui"

local function localize_material(mat)
    local n = GameTextGet("$mat_" .. mat)
    if n and n ~= "" then 
        return n 
    else 
        return "[" .. mat .. "]" 
    end
end

local function format_combo(combo, prob, localize)
    local ret = {}
    for idx, mat in ipairs(combo) do
        ret[idx] = (localize and localize_material(mat)) or mat
    end
    return table.concat(ret, ", ")
end

local alchemy_generator = AlchemyGenerator:new()
local lc_combo, ap_combo, lc_prob, ap_prob = alchemy_generator:get_alchemy()
local combos = {
    AP = {
        [false] = format_combo(ap_combo, ap_prob, false),
        [true] = format_combo(ap_combo, ap_prob, true)
    },
    LC = {
        [false] = format_combo(lc_combo, lc_prob, false),
        [true] = format_combo(lc_combo, lc_prob, true)
    }
}

local alchemy_gui = AlchemyGui:new(combos)

function _alchemy_main()
    if (not alchemy_gui.gui) or (not alchemy_gui.run) then return end
    GuiStartFrame(alchemy_gui.gui)
    local happy, errstr = pcall(function() alchemy_gui:run() end)
    if not happy then
        print("Gui error: " .. errstr)
    end
end
