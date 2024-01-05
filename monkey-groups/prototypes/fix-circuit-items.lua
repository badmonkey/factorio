require("__monkey-lib__.stdlib.config")
require("lib.subgroup")

local config = Config.of("monkey-groups")
if not config.startup:has_feature("use-circuit-group") then
  return
end


local subgroup = Subgroup("circuit")

subgroup:process {
  destination = "combinator",

  subgroup.move_item "arithmetic-combinator",
  subgroup.move_item "decider-combinator",
  subgroup.move_item "constant-combinator",

  subgroup.move_matching_items(".+[-]combinator$", "circuit-network")
}


if mods["shortwave_fix"] then

end
