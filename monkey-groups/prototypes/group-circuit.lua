local ItemGroup = require("__monkey-lib__.stdlib.itemgroup")
local Config = require("__monkey-lib__.stdlib.config")

local config = Config.of("monkey-groups")
local circuits = ItemGroup.new()


local values = circuits.create {
  name = "circuit",
  icon = "__base__/graphics/technology/circuit-network.png",
  order = config.startup.value("circuit-group-order"),

  circuits:subgroup "connection",
  circuits:subgroup "combinator",

  circuits:subgroup "combinator-arithmetic",
  circuits:subgroup "combinator-decider",
  circuits:subgroup "combinator-constant",

  circuits:subgroup "input",
  circuits:subgroup "visual",
  circuits:subgroup "auditory"
}

data:extend(values)
