require("__monkey-lib__.stdlib.config")
require("lib.itemgroup")

local config = Config.of("monkey-groups")
if not config.startup:has_feature("use-ammo-group") then
  return
end


local ammo = ItemGroup("ammo")
local ammo_config = config.startup:value("ammo-group-order")
local suborder = config.startup:value("ammo-fuel-subgroup")

local combat = ItemGroup.order_of("combat")

local ammo_order = Switch.on(ammo_config) {
  ["after-combat"] = function () return Ordering.after(combat) end,
  ["before-combat"] = function () return Ordering.before(combat) end,
}

local values = ammo:create_prototypes {
  icon = "__base__/graphics/technology/uranium-ammo.png",
  order = ammo_order,

  ammo.use_existing_maybe("ammo", suborder == "just-ammo"),

  ammo.when {
    condition = (suborder == "ammo-fuel"),

    ammo.use_existing "ammo",
    ammo.use_existing "fuel"
  },

  ammo.when {
    condition = (suborder == "fuel-ammo"),

    ammo.use_existing "fuel",
    ammo.use_existing "ammo"
  }
}

data:extend(values)
