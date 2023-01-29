local util = require "util"

local liquid_strings = {
    "acid", "alcohol", "blood",
    "blood_fungi", "blood_worm", "cement",
    "lava", "magic_liquid_berserk", "magic_liquid_charm",
    "magic_liquid_faster_levitation", "magic_liquid_faster_levitation_and_movement", "magic_liquid_invisibility",
    "magic_liquid_mana_regeneration", "magic_liquid_movement_faster", "magic_liquid_protection_all",
    "magic_liquid_teleportation", "magic_liquid_unstable_polymorph", "magic_liquid_unstable_teleportation",
    "magic_liquid_worm_attractor", "confusion", "mud",
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

function Material:new(name)
    self = self or {}
    self = setmetatable(self, Material)

    self.name = name
    self.localized_name = GameTextGet("$mat_" .. mat)

    return self
end

-- non-member
function Material.get_liquids() 
    if liquids == nil then
        liquids = {}
        for liquid in pairs(liquid_strings) do 
            table.insert(liquids, Material:new(liquid))
        end
    end 
    
    return util.copy_arr(liquids)
end

-- non-member
function Material.get_solids() 
    if solids == nil then
        solids = {}
        for solid in pairs(solid_strings) do 
            table.insert(solids, Material:new(solid))
        end
    end 
    
    return util.copy_arr(solids)
end


return Material
