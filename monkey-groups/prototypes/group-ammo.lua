local ItemGroup = require("lib.itemgroup")
local Config = require("__monkey-lib__.stdlib.config")

local config = Config.of("monkey-groups")
local ammo = ItemGroup.new()

local suborder = config.startup.value("ammo-subgroup-order")
local include_fuel = config.startup.has_feature("ammo-includes-fuel")

local values = ammo:create {
  name = "ammo",
  icon = "__base__/graphics/technology/uranium-ammo.png",
  order = config.startup.value("ammo-group-order"),

  ammo.use_existing_maybe("ammo", not include_fuel),

  ammo.when {
    condition = include_fuel,

    ammo.when {
      condition = (suborder == "ammo-fuel"),

      ammo.use_existing "ammo",
      ammo.use_existing "fuel"
    },
    ammo.when {
      condition = (suborder == "fuel-ammo"),

      ammo.use_existing "fuel"
      ammo.use_existing "ammo"

    },
  }
}

data:extend(values)
