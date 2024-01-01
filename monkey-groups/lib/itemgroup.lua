local Ordering = require("stdlib.ordering")

local ItemGroup = {}

function ItemGroup.new()
  local instance = {
    _order = Ordering.new(Ordering.simple),
    groupname = "",
    data = {}
  }

  function process_subgroup_list(self, input)
    local groupname = self.group

    for _, value in ipairs(input) do
      local order = self._order:next()

      if value.type == "item-subgroup" then
        value.name = groupname .. "-" .. value.name
        value.group = groupname
        value.order = order

        table.insert(self.data, value)

      elseif value.type == "existing-subgroup" then
        -- update the existing value instead (and don't add it to the array)
        data.raw["item-subgroup"][value.name].group = groupname
        data.raw["item-subgroup"][value.name].order = order

      elseif value.type == "list-of-subgroups" then
        self:process_subgroup_list(value)

      end
    end
  end

  function instance.create(self, input)
    self.groupname = input.name

    local defgroup = {
      type = "item-group",
      name = self.groupname,
      order = input.order,
      icon = input.icon,
      icon_size = 256,
      icon_mipmaps = 4
    }
    table.insert(self.data, defgroup)

    self:process_subgroup_list(input)

    return self.data
  end

  function instance.subgroup(name_suffix)
    return { type = "item-subgroup", name = name_suffix }
  end

  function instance.use_existing(name)
    if data.raw["item-subgroup"][name] == nil then
      error("Missing required item-subgroup "..name)
    end
    return { type = "existing-subgroup", name = name }
  end

  function instance.use_existing_maybe(name, cond)
    if not cond then
      return { type = "nil-subgroup" }
    end
    if data.raw["item-subgroup"][name] == nil then
      error("Missing required item-subgroup "..name)
    end
    return { type = "existing-subgroup", name = name }
  end

  function instance.use_existing_when(name, modname)
    if mods[modname] == nil then
      return { type = "nil-subgroup" }
    end
    if data.raw["item-subgroup"][name] == nil then
      error("Missing required item-subgroup "..name)
    end
    return { type = "existing-subgroup", name = name }
  end

  function instance.when(input)
    if type(input) == "table" and input["condition"] then
      input.type = "list-of-subgroups"
      return input
    end
    return { type = "nil-subgroup" }
  end

  return instance
end


return ItemGroup
