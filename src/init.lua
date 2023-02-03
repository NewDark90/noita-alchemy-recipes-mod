
local mod_name = "alchemy_recipes_test"

GLOBAL = {
    mod_name = mod_name,
    files_path = "mods/" .. mod_name .. "/files",
}

function OnWorldPostUpdate() 
  if _alchemy_main then _alchemy_main() end
end

function OnPlayerSpawned( player_entity )
    dofile_once(GLOBAL.files_path .. "/alchemy.lua")
end

function OnPausedChanged(is_paused, is_inventory_pause)
    GLOBAL.mod_settings:refresh()
end