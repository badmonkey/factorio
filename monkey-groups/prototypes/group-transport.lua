require("__monkey-lib__.stdlib.config")
require("lib.itemgroup")

local config = Config.of("monkey-groups")
if not config.startup:has_feature("use-transport-group") then
  return
end


local transport = ItemGroup("transport")
local transport_config = config.startup:value("transport-group-order")
local logistics = ItemGroup.order_of("logistics")
local combat = ItemGroup.order_of("combat")

local transport_order = Switch.on(transport_config) {
  ["after-log"] = function () return Ordering.after(logistics) end,
  ["before-log"] = function () return Ordering.before(logistics) end,
  ["after-combat"] = function () return Ordering.after(combat) end,
  ["before-combat"] = function () return Ordering.before(combat) end,
}


local values = transport:create_prototypes {
  icon = "__base__/graphics/technology/automobilism.png",
  order = transport_order,

  transport.use_existing "transport",           -- vanilla default

  transport.use_existing_when("cars", "aai-programmable-vehicles"),

  -- vehicles

  transport.subgroup "civilian",
  transport.subgroup "military",

  -- if we're splitting rolling stock subgroups
  transport.when {
    condition = config.startup:has_feature("split-rolling-stock"),

    transport.subgroup "locomotive",
    transport.subgroup "cargo-wagon",
    transport.subgroup "fluid-wagon",
  },

  transport.use_existing "train-transport",
  transport.use_existing_when("rail", "space-exploration"),

  transport.subgroup "water",
  transport.use_existing_when("water_transport", "cargo-ships"),

  transport.subgroup "aircraft",

  -- utility subgroups

  transport.use_existing_when("ai-vehicles", "aai-programmable-vehicles"),
  transport.use_existing_when("vehicle-ids", "aai-programmable-vehicles"),
  transport.use_existing_when("ai-vehicles-reverse", "aai-programmable-vehicles")
}

data:extend(values)
