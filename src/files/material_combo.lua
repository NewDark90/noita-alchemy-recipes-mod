
local MaterialCombo = {}
MaterialCombo.__index = MaterialCombo

---comment
---@param mat1 Material
---@param mat2 Material
---@param mat3 Material
---@param probability number
---@return table
function MaterialCombo:new(mat1, mat2, mat3, probability)
    self = self or {}
    setmetatable(self, MaterialCombo)

    self.mat1 = mat1
    self.mat2 = mat2
    self.mat3 = mat3
    self.probabilty = probability

    self.display = self:get_display()

    return self
end

function MaterialCombo:get_display()
    local ret = {
        key = table.concat({
            "[" .. self.mat1.name .. "]",
            "[" .. self.mat2.name .. "]",
            "[" .. self.mat3.name .. "]"
        }, ", "),
        localized = table.concat({
            self.mat1.localized_name,
            self.mat2.localized_name,
            self.mat3.localized_name
        }, ", "),
    }
    return ret
end


return MaterialCombo