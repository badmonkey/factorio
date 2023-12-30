local Ordering = require("stdlib.ordering")

local ItemGroup = {}

function ItemGroup.new()
  local instance = {
    _order = Ordering.new(Ordering.simple)
  }

  function instance.create(input)
    local groupname = input.name
    local data = {}

    local group = {
      type = "item-group",
      name = groupname,
      order = input.order,
      icon = input.icon,
      icon_size = 256,
      icon_mipmaps = 4
    }
    table.insert(data, group)

    for _, value in ipairs(input) do
      if value.type == "item-subgroup" then
        value.name = groupname .. "-" .. value.name
        value.group = groupname

        table.insert(data, value)
      elseif value.type == "existing-subgroup" then
        -- update the existing value instead (and don't add it to the array)
        data.raw["item-subgroup"][value.name].group = groupname
        data.raw["item-subgroup"][value.name].order = value.order
      end
    end

    return data
  end

  function instance.subgroup(self, input)
    local name = input.name
    if data.raw["item-subgroup"][name] ~= nil then
      -- this subgroup already exists, pass back temporary subgroup
      return {
        type = "existing-subgroup",
        name = name,
        order = self._order:next()
      }
    else
      return {
        type = "item-subgroup",
        name = name,
        order = self._order:next()
      }
    end
  end

  return instance
end


return ItemGroup
