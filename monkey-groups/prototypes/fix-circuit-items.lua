require("__monkey-lib__.stdlib.config")
require("lib.subgroup")

local config = Config.of("monkey-groups")
if not config.startup:has_feature("use-circuit-group") then
  return
end


local modgroup = Subgroup("circuit")

modgroup("combinator").update {
  Subgroup.move_item "arithmetic-combinator",
  Subgroup.move_item "decider-combinator",
  Subgroup.move_item "constant-combinator",

  Subgroup.with("power-combinator").move_item "power-combinator-MK2",
  Subgroup.with("fcpu").move_item "fcpu",

  Subgroup.move_matching_items(".+[-]combinator$", "circuit-network"),
}


modgroup("transmission").update {
  Subgroup.with("shortwave_fix").move_item("shortwave-radio"),

  Subgroup.when(mods["RadioNetwork"] or mods["RadioNetwork_FIX"]).update {
    Subgroup.move_item "radio-transmitter-1",
    Subgroup.move_item "radio-transmitter-2",
    Subgroup.move_item "radio-transmitter-3",

    Subgroup.move_item "radio-receiver-1",
    Subgroup.move_item "radio-receiver-2",
    Subgroup.move_item "radio-receiver-3",
  },

  Subgroup.with("aai-signal-transmission").update {
    Subgroup.move_item "aai-signal-sender",
    Subgroup.move_item "aai-signal-receiver",
  },
}
