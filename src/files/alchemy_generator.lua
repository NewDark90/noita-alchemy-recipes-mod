local constants = dofile_once(GLOBAL.files_path .. "/constants.lua")
local NollaPrng = dofile_once(GLOBAL.files_path .. "/nolla_prng.lua")

-- local constants = require "constants"
-- local NollaPrng = require "nolla_prng"

local AlchemyGenerator = {}
AlchemyGenerator.__index = AlchemyGenerator

function AlchemyGenerator:new() 
    self = self or {}
    setmetatable(self, AlchemyGenerator)

    self.seed = tonumber(StatsGetValue("world_seed"))
    self.initial_rand_state = math.floor(self.seed * 0.17127000 + 1323.59030000)
    self.prng = NollaPrng:new(self.initial_rand_state)

    return self
end

function AlchemyGenerator.shuffle(arr, seed)
    local suffle_prng = NollaPrng:new(math.floor(seed / 2) + 0x30f6)
    local rand_state = suffle_prng:next()
    for i = #arr, 1, -1 do
        rand_state = suffle_prng:next()
        local fidx = rand_state / 2 ^ 31
        local target = math.floor(fidx * i) + 1
        arr[i], arr[target] = arr[target], arr[i]
    end
end

function AlchemyGenerator:random_material(mats)
    for _ = 1, 1000 do
        local rval = self.prng:next() / 2 ^ 31
        local sel_idx = math.floor(#mats * rval) + 1
        local selection = mats[sel_idx]
        if selection then
            mats[sel_idx] = false
            return selection
        end
    end
end

function AlchemyGenerator:random_recipe()
    local liqs = constants.get_liquids()
    local orgs = constants.get_solids()
    local m1, m2, m3, m4 = "?", "?", "?", "?"
    m1 = self:random_material(liqs)
    m2 = self:random_material(liqs)
    m3 = self:random_material(liqs)
    m4 = self:random_material(orgs)
    local combo = { m1, m2, m3, m4 }

    local rand_state = self.prng:next()
    local prob = 10 + math.floor((rand_state / 2 ^ 31) * 91)
    rand_state = self.prng:next()

    self.shuffle(combo, self.seed)
    return { combo[1], combo[2], combo[3] }, prob
end

function AlchemyGenerator:get_alchemy()
    for i = 1, 6 do
        self.prng:next()
    end

    local lc_combo, ap_combo = { "?" }, { "?" }
    lc_combo, lc_prob = self:random_recipe()
    ap_combo, ap_prob = self:random_recipe()

    return lc_combo, ap_combo, lc_prob, ap_prob
end

return AlchemyGenerator
