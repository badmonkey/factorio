require("__monkey-lib__.stdlib.config")
require("lib.itemgroup")

local config = Config.of("monkey-groups")
if not config.startup.has_feature("use-transport-group") then
  return
end


local transport = ItemGroup("transport")


local values = transport:create_prototypes {
  icon = "__base__/graphics/technology/automobilism.png",
  order = config.startup.value("transport-group-order"),

  transport.use_existing "transport",

  transport.use_existing_when("cars", "aai-programmable-vehicles"),
  transport.use_existing_when("ai-vehicles", "aai-programmable-vehicles"),

  transport.subgroup "civilian",
  transport.subgroup "water",
  transport.subgroup "military",

  transport.use_existing "train-transport",

  transport.use_existing_when("rail", "space-exploration"),

  transport.use_existing "railway",

  transport.subgroup "equipment",
  transport.subgroup "equipment-military",
  transport.subgroup "equipment-defense",

  transport.use_existing_when("vehicle-ids", "aai-programmable-vehicles"),
  transport.use_existing_when("ai-vehicles-reverse", "aai-programmable-vehicles")
}

data:extend(values)
