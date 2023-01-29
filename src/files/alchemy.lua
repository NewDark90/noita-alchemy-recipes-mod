-- local AlchemyGenerator = dofile_once(GLOBAL.files_path .. "/alchemy_generator.lua")
-- local AlchemyGui = dofile_once(GLOBAL.files_path .. "/alchemy_gui.lua") 

local AlchemyGenerator = require "alchemy_generator"
local AlchemyGui = require "alchemy_gui"


local alchemy_generator = AlchemyGenerator:new()
local alchemy_combos = alchemy_generator:get_alchemy()
local alchemy_gui = AlchemyGui:new(alchemy_combos)

function _alchemy_main()
    if (not alchemy_gui.gui) or (not alchemy_gui.run) then return end
    GuiStartFrame(alchemy_gui.gui)
    local happy, errstr = pcall(function() alchemy_gui:run() end)
    if not happy then
        print("Gui error: " .. errstr)
    end
end
