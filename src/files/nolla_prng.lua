NollaPrng = {
    seed = 0,
    seed_base = 23456789 + 1 + 11 * 11
};

function NollaPrng:new(seed, seed_base)
    if seed_base ~= nil then
        self.seed_base = seed_base
    end
    
    self.seed = seed + self.seed_base
end

function NollaPrng:next()
    local hi = math.floor(self.seed / 127773.0)
    local lo = self.seed  % 127773
    
    self.seed = 16807 * lo - 2836 * hi
    if self.seed  <= 0 then
        self.seed = self.seed + 2147483647
    end
    return self.seed
end

return {
    NollaPrng = NollaPrng
}