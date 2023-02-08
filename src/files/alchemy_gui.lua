
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

function AlchemyGui.new(mod_settings)
    local self = {}
    setmetatable(self, AlchemyGui)

    self.mod_settings = mod_settings
    self.alchemy_generator = AlchemyGenerator.new()
    self.is_open = true
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
    local is_vertical = self.mod_settings.layout_type == "vertical" 
    local gui_func = (
        is_vertical and 
        GuiLayoutBeginVertical or 
        GuiLayoutBeginHorizontal 
    )
    gui_func(self.gui, self.mod_settings.layout_x, self.mod_settings.layout_y)

    if self.mod_settings.toggle_button_position == "start" then
        self:toggle_button()
    end
    
    if self.is_open then
        self:recipe_display(gui_ids.lively_concoction, self.mod_settings.lc_rgba, self.alchemy_recipes.lc_recipe.display)
        if not is_vertical then 
            GuiText(self.gui, 0, 0, "|")
        end
        self:recipe_display(gui_ids.alchemic_precursor, self.mod_settings.ap_rgba, self.alchemy_recipes.ap_recipe.display)
    end

    if self.mod_settings.toggle_button_position == "end" then
        self:toggle_button()
    end

    GuiLayoutEnd(self.gui)
end

function AlchemyGui:toggle_button() 
    local clicked = GuiButton(self.gui, gui_ids.open_close, 1, 1, (self.is_open and "[x]" or "[>]")) 
    if clicked then
        self.is_open = not self.is_open
    end
    return clicked
end

function AlchemyGui:recipe_display(id, rgba, display) 
    GuiColorSetForNextWidget(self.gui, rgba.r, rgba.g, rgba.b, rgba.a)
    GuiText(self.gui, 1, 1, display.recipe_name .. ": " .. (self.mod_settings.is_localized and display.localized or display.key))
end

return AlchemyGui
