require("__monkey-lib__.stdlib.class")

Subgroup = class.itemsubgroup()

function Subgroup:_init(name)
  self._name = name
end

function Subgroup:process(input)
  local subname = self._name .. "-" .. input.destination

  for _, value in ipairs(input) do
    local _type = value.type
    if _type == "move-item" then
      data.raw.item[value.name].subgroup = subname

    elseif _type == "move-entity" then
      data.raw["item-with-entity-data"][value.name].subgroup = subname

    elseif _type == "list-of-moves" then
      value.destination = input.destination
      self:process(value)

    end
  end
end

function Subgroup.move_item(input)
  return { type = "move-item", name = input }
end

function Subgroup.move_entity(input)
  return { type = "move-entity", name = input }
end

function Subgroup.move_entity_when(input, modname)
  if mods[modname] then
    return { type = "move-entity", name = input }
  end
  return { type = "nil" }
end

function Subgroup.move_matching_items(pattern, subgrp)
  local moves = { type = "list-of-moves" }
  for k, v in pairs(data.raw.item) do
    if v.subgroup == subgrp and string.match(k, pattern) then
      table.insert(moves, { type = "move-item", name = k })
    end
  end
  return moves
end

function Subgroup.move_items_from_subgroup(subgrp)
  local moves = { type = "list-of-moves" }
  for k, v in pairs(data.raw.item) do
    if v.subgroup == subgrp then
      table.insert(moves, { type = "move-item", name = k })
    end
  end
  return moves
end

function Subgroup.move_entities_from_subgroup(subgrp)
  local moves = { type = "list-of-moves" }
  for k, v in pairs(data.raw["item-with-entity-data"]) do
    if v.subgroup == subgrp then
      table.insert(moves, { type = "move-entity", name = k })
    end
  end
  return moves
end


function Subgroup.direct_move_item(name, subgrp)
  data.raw.item[name].subgroup = subgrp
end

function Subgroup.when(input)
  if type(input) == "table" and input["condition"] then
    input.type = "list-of-moves"
    return input
  end
  return { type = "nil" }
end
