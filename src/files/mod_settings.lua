
local ModSettings = {}
ModSettings.__index = ModSettings

function ModSettings.new(mod_name)
    local self = {}
    setmetatable(self, ModSettings)

    self.mod_name = mod_name
    self.layout_type = "vertical"
    self.layout_x = 1
    self.layout_y = 10
    self:refresh()

    return self
end

function ModSettings:refresh()
    self.layout_type = self:get_setting("LAYOUT_DIRECTION")
    self.layout_x = self:get_setting("LAYOUT_X_POS")
    self.layout_y = self:get_setting("LAYOUT_Y_POS")

    --print("Refreshed settings", self.layout_type, self.layout_x, self.layout_y)
end

function ModSettings:get_setting(setting_name)
    return ModSettingGet(self.mod_name .. "." .. setting_name)
end


return ModSettings