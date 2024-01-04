require("__monkey-lib__.stdlib.config")
require("lib.itemgroup")

local config = Config.of("monkey-groups")
if not config.startup.has_feature("use-ammo-group") then
  return
end


local ammo = ItemGroup("ammo")

local suborder = config.startup.value("ammo-subgroup-order")
local include_fuel = config.startup.has_feature("ammo-includes-fuel")


local values = ammo:create_prototypes {
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
    }
  }
}

data:extend(values)
