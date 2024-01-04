require("stdlib.class")
require("stdlib.ordering")


ItemGroup = class.itemgroup()

function ItemGroup:_init(name)
  self.order = Ordering(Ordering.simple)
  self.name = name
  self.data = {}
end


function ItemGroup:create_prototypes(input)
  local defgroup = {
    type = "item-group",
    name = self.name,
    order = input.order,
    icon = input.icon,
    icon_size = 256,
    icon_mipmaps = 4
  }
  table.insert(self.data, defgroup)

  self:process_subgroup_list(input)

  return self.data
end

function ItemGroup:process_subgroup_list(input)
  local groupname = self.name
  local order = self.order

  for _, value in ipairs(input) do
    if value.type == "item-subgroup" then
      value.name = groupname .. "-" .. value.name
      value.group = groupname
      value.order = order:next()

      table.insert(self.data, value)

    elseif value.type == "existing-subgroup" then
      -- update the existing value instead (and don't add it to the array)
      data.raw["item-subgroup"][value.name].group = groupname
      data.raw["item-subgroup"][value.name].order = order:next()

    elseif value.type == "list-of-subgroups" then
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

function ItemGroup.when(input)
  if type(input) == "table" and input["condition"] then
    input.type = "list-of-subgroups"
    return input
  end
  return { type = "nil-subgroup" }
end
