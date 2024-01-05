require("__monkey-lib__.stdlib.config")
require("lib.itemgroup")

local config = Config.of("monkey-groups")
if not config.startup:has_feature("use-circuit-group") then
  return
end


local circuit = ItemGroup("circuit")
local circuit_config = config.startup:value("circuit-group-order")
local logistics = ItemGroup.order_of("logistics")
local combat = ItemGroup.order_of("combat")

local circuit_order = Switch.on(circuit_config) {
  ["after-log"] = function () return Ordering.after(logistics) end,
  ["before-log"] = function () return Ordering.before(logistics) end,
  ["after-combat"] = function () return Ordering.after(combat) end,
  ["before-combat"] = function () return Ordering.before(combat) end,
}

local values = circuit:create_prototypes {
  icon = "__base__/graphics/technology/circuit-network.png",
  order = circuit_order,

  circuit.use_existing "circuit-network",
  circuit.subgroup "combinator",
  circuit.subgroup "transmission",

  circuit.use_existing_when("programmable-structures", "aai-programmable-vehicles")
}

data:extend(values)
