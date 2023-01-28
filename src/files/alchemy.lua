local AlchemyGenerator = dofile_once(GLOBAL.files_path .. "/alchemy_generator.lua")
-- local AlchemyGenerator = require "alchemy_generator"

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

local created_gui = false

if not _alchemy_gui then
    print("Alchemy creating GUI")
    _alchemy_gui = GuiCreate()
    created_gui = true
else
    print("Alchemy reloading onto existing GUI")
end
local gui = _alchemy_gui
local alchemy_button_id = 323

local is_open = true
local localized = true

local function alchemy_gui_func()
    GuiLayoutBeginHorizontal(gui, 1, 10)
    if GuiButton(gui, 0, 0, (is_open and "[<]") or "[>]", alchemy_button_id) then
        is_open = not is_open
    end
    if is_open then
        local combo_text = (" LC: %s | AP: %s"):format(
            combos.LC[localized], combos.AP[localized]
        )
        if GuiButton(gui, 0, 0, combo_text, alchemy_button_id + 1) then
            localized = not localized
        end
    end
    GuiLayoutEnd(gui)
end

_alchemy_gui_func = alchemy_gui_func

function _alchemy_main()
    if not created_gui then return end
    if not (gui and _alchemy_gui_func) then return end
    GuiStartFrame(gui)
    local happy, errstr = pcall(_alchemy_gui_func)
    if not happy then
        print("Gui error: " .. errstr)
        _alchemy_gui_func = nil
    end
end
