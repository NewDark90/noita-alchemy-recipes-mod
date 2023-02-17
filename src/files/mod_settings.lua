
local ModSettings = {}
ModSettings.__index = ModSettings

function ModSettings.new(mod_name)
    local self = {}
    setmetatable(self, ModSettings)

    self.mod_name = mod_name
    self.toggle_button_position = "start"
    self.layout_type = "horizontal"
    self.layout_x = 1
    self.layout_y = 4
    self.lc_rgba = {
        r = 1,
        g = 1,
        b = 1,
        a = 1
    }
    self.ap_rgba = {
        r = 1,
        g = 1,
        b = 1,
        a = 1
    }
    self.is_localized = true
    self:refresh()

    return self
end

function ModSettings:refresh()
    self.toggle_button_position = self:get_setting("TOGGLE_BUTTON_POSITION")
    self.layout_type = self:get_setting("LAYOUT_DIRECTION")
    self.layout_x = self:get_setting("LAYOUT_X_POS")
    self.layout_y = self:get_setting("LAYOUT_Y_POS")

    self.lc_rgba = {
        r = self:get_setting("UI_RECIPE_LC_R") / 255,
        g = self:get_setting("UI_RECIPE_LC_G") / 255,
        b = self:get_setting("UI_RECIPE_LC_B") / 255,
        a = self:get_setting("UI_RECIPE_LC_A") / 100
    }
    self.ap_rgba = {
        r = self:get_setting("UI_RECIPE_AP_R") / 255,
        g = self:get_setting("UI_RECIPE_AP_G") / 255,
        b = self:get_setting("UI_RECIPE_AP_B") / 255,
        a = self:get_setting("UI_RECIPE_AP_A") / 100
    }
    
    self.is_localized = self:get_setting("UI_RECIPE_LOCALIZED")

    --print("Refreshed settings", self.layout_type, self.layout_x, self.layout_y)
end

function ModSettings:get_setting(setting_name)
    return ModSettingGet(self.mod_name .. "." .. setting_name)
end


return ModSettings