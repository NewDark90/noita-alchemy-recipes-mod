local AlchemyGui = {}
AlchemyGui.__index = AlchemyGui

function AlchemyGui:new(alchemy_combos)
    self = self or {}
    self = setmetatable(self, AlchemyGui)

    self.is_open = true
    self.localized = true
    self.alchemy_combos = alchemy_combos
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
            self.alchemy_combos.LC[self.localized], self.alchemy_combos.AP[self.localized]
        )
        if GuiButton(self.gui, 0, 0, combo_text, alchemy_button_id + 1) then
            self.localized = not self.localized
        end
    end
    GuiLayoutEnd(self.gui)
end

return AlchemyGui
