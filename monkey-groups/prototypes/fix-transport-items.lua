require("__monkey-lib__.stdlib.config")
require("lib.subgroup")

local config = Config.of("monkey-groups")
if not config.startup.has_feature("use-transport-group") then
  return
end


local subgroup = SubGroup.of("transport")

Subgroup.process {
  destination = "railway",

  subgroup.move_entity "locomotive",
  subgroup.move_entity "cargo-wagon",
  subgroup.move_entity "fluid-wagon"
  subgroup.move_entity "artillery-wagon"
}

Subgroup.process {
  destination = "civilion",

  subgroup:move_entity "car",
  subgroup.move_entity_when("vehicle-miner", "aai-vehicles-miner"),
  subgroup.move_entity_when("vehicle-miner", "aai-vehicles-miner"),

  Subgroup.when {
    has_mod = "aai-vehicles-miner",

    subgroup:move_entity "vehicle-miner",
    subgroup:move_entity "vehicle-miner-mk2",
  }
}

subgroup.process {
  destination = "military",

  subgroup.move_entity "tank",
  subgroup.move_entity "spidertron"
}
