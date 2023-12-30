local ItemGroup = require("__monkey-lib__.stdlib.itemgroup")
local Config = require("__monkey-lib__.stdlib.config")

local config = Config.of("monkey-groups")
local transport = ItemGroup.new()


local values = transport.create {
  name = "transport",
  icon = "__base__/graphics/technology/automobilism.png",
  order = config.startup.value("transport-group-order"),

  transport:subgroup "transport",
  transport:subgroup "train-transport",

  transport:subgroup "railway",
  transport:subgroup "civilian",
  transport:subgroup "water",
  transport:subgroup "military",
  transport:subgroup "equipment",
  transport:subgroup "equipment-military",
  transport:subgroup "equipment-defense"
}

data:extend(values)
