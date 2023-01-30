local AlchemyGui = {}
AlchemyGui.__index = AlchemyGui

function AlchemyGui.new(alchemy_combo)
    local self = {}
    setmetatable(self, AlchemyGui)

    self.is_open = true
    self.is_localized = true
    self.lc_combo = alchemy_combo.lc_combo
    self.ap_combo = alchemy_combo.ap_combo
    self.gui = GuiCreate()

    return self
end

function AlchemyGui:run()
    local alchemy_button_id = 323
    GuiLayoutBeginHorizontal(self.gui, 1, 10)
    if GuiButton(self.gui, 0, 0, (self.is_open and "[<]") or "[>]", alchemy_button_id) then
        self.is_open = not self.is_open
    end
    if self.is_open then
        local combo_text = (" LC: %s | AP: %s"):format(
            (
                self.is_localized and 
                self.lc_combo.display.localized or 
                self.lc_combo.display.name
            ), (
                self.is_localized and 
                self.ap_combo.display.localized or 
                self.ap_combo.display.name
            )
        )
        if GuiButton(self.gui, 0, 0, combo_text, alchemy_button_id + 1) then
            self.is_localized = not self.is_localized
        end
    end
    GuiLayoutEnd(self.gui)
end

return AlchemyGui
