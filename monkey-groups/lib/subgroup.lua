require("__monkey-lib__.stdlib.class")

local Actions = class.subgroupactions()

function Actions.update(input)
  input.type = "list-of-moves"
  return input
end

function Actions.move_item(input)
  return { type = "move-item", name = input }
end

function Actions.move_entity(input)
  return { type = "move-entity", name = input }
end

function Actions.move_recipe(input)
  return { type = "move-recipe", name = input }
end


local Ignore = class.subgroupignore()

function Ignore:_property(key)
  return function() return { type = "nil" } end
end


Subgroup = class.itemsubgroup(Actions)

function Subgroup:_init(name)
  self._name = name
end

function Subgroup._update(target, input)
  for _, value in pairs(input) do
    local _type = value.type
    if _type == "move-item" then
      local item = data.raw.item
      if not item[value.name] then
        error("Trying to move non-existing item " .. value.name)
      end
      dumplog("move item", value.name, "from", item[value.name].subgroup, "to", target)
      item[value.name].subgroup = target

      if data.raw.recipe[value.name] then
        dumplog("move item.recipe", value.name, "from", data.raw.recipe[value.name].subgroup, "to", target)
        data.raw.recipe[value.name].subgroup = target
      end

    elseif _type == "move-entity" then
      local item = data.raw["item-with-entity-data"]
      if not item[value.name] then
        error("Trying to move non-existing entity " .. value.name)
      end
      dumplog("move entity", value.name, "from", item[value.name].subgroup, "to", target)
      item[value.name].subgroup = target

      if data.raw.recipe[value.name] then
        dumplog("move entity.recipe", value.name, "from", data.raw.recipe[value.name].subgroup, "to", target)
        data.raw.recipe[value.name].subgroup = target
      end

    elseif _type == "move-recipe" then
      local item = data.raw.recipe
      if not item[value.name] then
        error("Trying to move non-existing recipe " .. value.name)
      end
      dumplog("move recipe", value.name, "from", item[value.name].subgroup, "to", target)
      item[value.name].subgroup = target

    elseif _type == "list-of-moves" then
      Subgroup._update(target, value)

    end
  end
end

function Subgroup:_call(key)
  local bridge = {}
  local destination = self._name .. "-" .. key

  function bridge.update(input)
    Subgroup._update(destination, input)
  end

  return bridge
end

function Subgroup.update()
end

function Subgroup.direct(subgrp)
local bridge = {}

  function bridge.update(input)
    Subgroup._update(subgrp, input)
  end

  return bridge
end

function Subgroup.when(cond)
  if cond then
    return Actions()
  end

  return Ignore()
end

function Subgroup.with(modname)
  if mods[modname] then
    return Actions()
  end

  return Ignore()
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

function Subgroup.move_recipes_from_subgroup(subgrp)
  local moves = { type = "list-of-moves" }
  for k, v in pairs(data.raw.recipe) do
    if v.subgroup == subgrp then
      table.insert(moves, { type = "move-recipe", name = k })
    end
  end
  return moves
end
