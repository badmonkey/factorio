require("__monkey-lib__.stdlib.config")
require("lib.subgroup")

local config = Config.of("monkey-groups")
if not config.startup:has_feature("use-transport-group") then
  return
end


local subgroup = Subgroup("transport")

if config.startup:has_feature("split-rolling-stock") then

  subgroup:process {
    destination = "locomotive",

    subgroup.move_entity "locomotive"
  }
  subgroup:process {
    destination = "cargo-wagon",

    subgroup.move_entity "cargo-wagon",
    subgroup.move_entity "artillery-wagon"
  }
  subgroup:process {
    destination = "fluid-wagon",

    subgroup.move_entity "fluid-wagon"
  }

else

  subgroup:process {
    destination = "stdrail",

    subgroup.move_entity "locomotive",
    subgroup.move_entity "cargo-wagon",
    subgroup.move_entity "fluid-wagon",
    subgroup.move_entity "artillery-wagon"
  }

end

subgroup:process {
  destination = "civilian",

  subgroup.move_entity "car",
}

subgroup:process {
  destination = "military",

  subgroup.move_entity "tank",
  subgroup.move_entity "spidertron",
}



--[[
  subgroup.move_entity_when("vehicle-miner", "aai-vehicles-miner"),
  subgroup.move_entity_when("vehicle-miner", "aai-vehicles-miner"),

  Subgroup.when {
  condition = mod["aai-vehicles-miner"],

  subgroup.move_entity "vehicle-miner",
  subgroup.move_entity "vehicle-miner-mk2",
  }
]]
