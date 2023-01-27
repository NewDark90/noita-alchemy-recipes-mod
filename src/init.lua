local mod_name = "alchemy_recipes_test"

GLOBAL = {
    mod_name = mod_name,
    files_path = "mods/" .. mod_name .. "/files"
}

function OnWorldPostUpdate() 
  if _alchemy_main then _alchemy_main() end
end

function OnPlayerSpawned( player_entity )
    GamePrint("spawned")
  dofile_once(GLOBAL.files_path .. "/alchemy.lua")
end