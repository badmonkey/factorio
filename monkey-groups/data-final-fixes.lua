require("__monkey-lib__.stdlib.config")

require("prototypes.fix-ammo-items")

require("prototypes.fix-circuit-items")
-- require("compat.aai-signals")
-- require("compat.radio-networks")

require("prototypes.fix-transport-items")
-- require("compat.aai-vehicles")
-- require("compat.space-exploration")
-- require("compat.krastorio2")
-- require("compat.cargo-ships")


local config = Config.of("monkey-groups")

local expand_ui_slots = config.startup:value("expand-group-ui-slots")
if expand_ui_slots == "+2" then
  data.raw["utility-constants"]["default"].select_group_row_count = 8
elseif expand_ui_slots == "+4" then
  data.raw["utility-constants"]["default"].select_group_row_count = 10
end
