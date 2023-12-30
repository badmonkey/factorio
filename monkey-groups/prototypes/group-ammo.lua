local ItemGroup = require("__monkey-lib__.stdlib.itemgroup")
local Config = require("__monkey-lib__.stdlib.config")

local config = Config.of("monkey-groups")
local ammo = ItemGroup.new()


local values = ammo.create {
  name = "ammo",
  icon = "__base__/graphics/technology/uranium-ammo.png",
  order = config.startup.value("ammo-group-order"),

  ammo:subgroup "ammo"
}

data:extend(values)
