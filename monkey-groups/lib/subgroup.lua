local SubGroup = {}

function SubGroup.process(input)
end

function SubGroup.move_item_into(input)
end

function SubGroup.move_item(input)
  return {
    type = "move-item",
    name = input
  }
end

function SubGroup.move_entity(input)
end


return SubGroup
