
dofile_once( "data/scripts/lib/utilities.lua" )

local AlchemyGenerator = require "alchemy_generator"

local AlchemyGui = {}
AlchemyGui.__index = AlchemyGui

local current_id = 111
local function next_id() 
    current_id = current_id + 1
    return current_id 
end
local gui_ids = {
    open_close = next_id(),
    lively_concoction = next_id(),
    alchemic_precursor = next_id(),
    recipe_spacer = next_id(),
}

function AlchemyGui.new()
    local self = {}
    setmetatable(self, AlchemyGui)

    self.alchemy_generator = AlchemyGenerator.new()
    self.is_open = true
    self.is_localized = true
    self.alchemy_recipes = self.alchemy_generator:get_alchemy()
    self.gui = GuiCreate()

    return self
end

function AlchemyGui:init()
    if (not self.gui) or (not self.run) then return end
    GuiStartFrame(self.gui)
    local happy, errstr = pcall(function() self:run() end)
    if not happy then
        print("Gui error: " .. errstr)
    end
end


function AlchemyGui:run()
    local is_vertical = GLOBAL.mod_settings.layout_type == "vertical" 
    local gui_func = (
        is_vertical and 
        GuiLayoutBeginVertical or 
        GuiLayoutBeginHorizontal 
    )
    gui_func(self.gui, GLOBAL.mod_settings.layout_x, GLOBAL.mod_settings.layout_y)

    --GuiOptionsAdd(self.gui, GUI_OPTION.)
    if GuiButton(self.gui, gui_ids.open_close, 1, 1, (self.is_open and "[x]" or "[>]")) then
        self.is_open = not self.is_open
    end
    if self.is_open then
        local lc_text = "LC: " .. (
            self.is_localized and 
            self.alchemy_recipes.lc_recipe.display.localized or 
            self.alchemy_recipes.lc_recipe.display.key
        )
        local ap_text = "AP: " .. (
            self.is_localized and 
            self.alchemy_recipes.ap_recipe.display.localized or 
            self.alchemy_recipes.ap_recipe.display.key
        )

        --GuiLayoutBeginVertical(self.gui, 0, 0)
        local lc_clicked = GuiButton(self.gui, gui_ids.lively_concoction, 1, 1, lc_text)
        if not is_vertical then 
            GuiText(self.gui, 0, 0, " | ")
        end
        local ap_clicked = GuiButton(self.gui, gui_ids.alchemic_precursor, 1, 1, ap_text)
        --GuiLayoutEnd(self.gui)
        if lc_clicked or ap_clicked then
            self.is_localized = not self.is_localized
        end
    end
    GuiLayoutEnd(self.gui)
end

return AlchemyGui
