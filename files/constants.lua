local LIQUIDS = {
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

local SOLIDS = {
    "bone", "brass", "coal",
    "copper", "diamond", "fungi",
    "gold", "grass", "gunpowder",
    "gunpowder_explosive", "rotten_meat", "sand",
    "silver", "slime", "snow",
    "soil", "wax", "honey"
}

local function copy_arr(arr)
    local ret = {}
    for k, v in pairs(arr) do ret[k] = v end
    return ret
end

local function get_liquids() 
    return copy_arr(LIQUIDS)
end

local function get_solids() 
    return copy_arr(SOLIDS)
end

return {
    get_liquids = get_liquids,
    get_solids = get_solids,
}