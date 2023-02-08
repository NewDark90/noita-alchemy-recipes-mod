
local AlchemyGui = require "alchemy_gui"
local ModSettings = require "mod_settings"

GLOBAL.mod_settings = ModSettings.new(GLOBAL.mod_name)
GLOBAL.alchemy_gui = AlchemyGui.new(GLOBAL.mod_settings)

function _alchemy_main()
    GLOBAL.alchemy_gui:init()
end
