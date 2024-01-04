require("__monkey-lib__.stdlib.config")
require("lib.itemgroup")

local config = Config.of("monkey-groups")
if not config.startup.has_feature("use-circuit-group") then
  return
end


local circuits = ItemGroup("circuits")

local values = circuits:create_prototypes {
  icon = "__base__/graphics/technology/circuit-network.png",
  order = config.startup.value("circuit-group-order"),

  circuits.subgroup "connection",
  circuits.subgroup "transmission",

  circuits.subgroup "combinator",

  circuits.when {
    condition = config.startup.value("split-combinators"),

    circuits.subgroup "combinator-arithmetic",
    circuits.subgroup "combinator-decider",
    circuits.subgroup "combinator-constant"
  },

  circuits.subgroup "input",
  circuits.subgroup "visual",
  circuits.subgroup "auditory",

  circuits.use_existing_when("programmable-structures", "aai-programmable-vehicles")
}

data:extend(values)
