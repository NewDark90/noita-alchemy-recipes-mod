local util = require "util"

local liquid_strings = {
    "acid", "alcohol", "blood",
    "blood_fungi", "blood_worm", "cement",
    "lava", "magic_liquid_berserk", "magic_liquid_charm",
    "magic_liquid_faster_levitation", "magic_liquid_faster_levitation_and_movement", "magic_liquid_invisibility",
    "magic_liquid_mana_regeneration", "magic_liquid_movement_faster", "magic_liquid_protection_all",
    "magic_liquid_teleportation", "magic_liquid_unstable_polymorph", "magic_liquid_unstable_teleportation",
    "magic_liquid_worm_attractor", "material_confusion", "mud",
    "oil", "poison", "radioactive_liquid",
    "swamp", "urine", "water",
    "water_ice", "water_swamp", "magic_liquid_random_polymorph"
}

local solid_strings = {
    "bone", "brass", "coal",
    "copper", "diamond", "fungi",
    "gold", "grass", "gunpowder",
    "gunpowder_explosive", "rotten_meat", "sand",
    "silver", "slime", "snow",
    "soil", "wax", "honey"
}

local liquids = nil
local solids = nil

local Material = {}
Material.__index = Material

function Material.new(name)
    local self = {}
    setmetatable(self, Material)

    self.name = name
    self.id = CellFactory_GetType(name)
    self.localized_name = self:localize_material():lower()

    -- print("Material: ", self.name, self.id, self.localized_name)

    return self
end

function Material:localize_material()
    local mat_name = self.material
    if self.id ~= -1 then
        mat_name = CellFactory_GetUIName(self.id)
    end 

    mat_name = GameTextGetTranslatedOrNot(mat_name)
    if not mat_name then 
        return self.material
    end
    return mat_name
end

-- non-member
function Material.get_liquids() 
    if liquids == nil then
        liquids = {}
        for index, liquid in pairs(liquid_strings) do 
            table.insert(liquids, Material.new(liquid))
        end
    end 
    
    return util.copy_arr(liquids)
end

-- non-member
function Material.get_solids() 
    if solids == nil then
        solids = {}
        for index, solid in pairs(solid_strings) do 
            table.insert(solids, Material.new(solid))
        end
    end 
    
    return util.copy_arr(solids)
end


return Material
