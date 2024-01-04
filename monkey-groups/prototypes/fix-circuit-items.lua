require("__monkey-lib__.stdlib.config")
require("lib.subgroup")

local config = Config.of("monkey-groups")
if not config.startup.has_feature("use-circuit-group") then
  return
end


local subgoup = Subgroup.of("circuit")

subgroup.process {
  destination = "network",

  subgroup.move_item "copper-cable"
}

subgroup.process {
  destination = "connection",

  subgroup.move_item "power-switch"
}

subgroup.process {
  destination = "visual",

  subgroup.move_item "power-switch"
}


if config.startup.value("split-combinators") then
  Subgroup.move_item_into("arithmetic-combinator", "combinator-arithmetric")
  Subgroup.move_item_into("decider-combinator", "combinator-decider")
  Subgroup.move_item_into("constant-combinator", "combinator-constant")

else

  subgroup.process {
    destination = "combinator",

    subgroup.move_item "arithmetic-combinator",
    subgroup.move_item "decider-combinator",
    subgroup.move_item "constant-combinator"
  }

end


subgroup.process {
  destination = "visual",

  subgroup.move_item "small-lamp"
}

subgroup.process {
  destination = "auditory",

  subgroup.move_item "programmable-speaker"
}
