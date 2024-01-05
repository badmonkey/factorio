require("__monkey-lib__.stdlib.class")
require("__monkey-lib__.stdlib.ordering")


ItemGroup = class.itemgroup()

function ItemGroup:_init(name)
  self._name = name
  self._order = Ordering(Ordering.simple)
  self._data = {}
end


function ItemGroup:create_prototypes(input)
  local defgroup = {
    type = "item-group",
    name = self._name,
    order = input.order,
    icon = input.icon,
    icon_size = 256,
    icon_mipmaps = 4
  }
  table.insert(self._data, defgroup)

  self:process_subgroup_list(input)

  return self._data
end

function ItemGroup:process_subgroup_list(input)
  local groupname = self._name
  local order = self._order

  for _, value in ipairs(input) do
    local _type = value.type
    if _type == "item-subgroup" then
      value.name = groupname .. "-" .. value.name
      value.group = groupname
      value.order = order:next()

      table.insert(self._data, value)

    elseif _type == "existing-subgroup" then
      -- update the existing value instead (and don't add it to the array)
      data.raw["item-subgroup"][value.name].group = groupname
      data.raw["item-subgroup"][value.name].order = order:next()

    elseif _type == "list-of-subgroups" then
      self:process_subgroup_list(value)

    end
  end
end

function ItemGroup.subgroup(name_suffix)
  return { type = "item-subgroup", name = name_suffix }
end

function ItemGroup.use_existing(name)
  if data.raw["item-subgroup"][name] == nil then
    error("Missing required item-subgroup "..name)
  end
  return { type = "existing-subgroup", name = name }
end

function ItemGroup.use_existing_maybe(name, cond)
  if not cond then
    return { type = "nil-subgroup" }
  end
  if data.raw["item-subgroup"][name] == nil then
    error("Missing required item-subgroup "..name)
  end
  return { type = "existing-subgroup", name = name }
end

function ItemGroup.use_existing_when(name, modname)
  if mods[modname] == nil then
    return { type = "nil-subgroup" }
  end
  if data.raw["item-subgroup"][name] == nil then
    error("Missing required item-subgroup "..name)
  end
  return { type = "existing-subgroup", name = name }
end

function ItemGroup.use_existing_or_create(name)
  if data.raw["item-subgroup"][name] == nil then
    return { type = "item-subgroup", name = name }
  else
    return { type = "existing-subgroup", name = name }
  end

end

function ItemGroup.when(input)
  if type(input) == "table" and input["condition"] then
    input.type = "list-of-subgroups"
    return input
  end
  return { type = "nil-subgroup" }
end

function ItemGroup.order_of(name)
  local group = data.raw["item-group"][name]
  if group then
    return group.order
  end
  error("Invalid item-group " .. name)
end
