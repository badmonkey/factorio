require("__monkey-lib__.stdlib.config")

require("prototypes.fix-ammo-items")

require("prototypes.fix-circuit-items")
require("compat.aai-signals")
require("compat.radio-networks")

require("prototypes.fix-transport-items")
require("compat.aai-vehicles")
require("compat.space-exploration")
require("compat.krastorio2")
require("compat.cargo-ships")



local config = Config.of("monkey-groups")

local expand_ui_slots = config.startup.value("expand-group-ui-slots")
if expand_ui_slots  == "+2" then
  data.raw["utility-constants"]["default"].select_group_row_count = 8
elseif config.startup.value("expand-group-ui-slots") == "+4" then
  data.raw["utility-constants"]["default"].select_group_row_count = 10
end



if config.startup.has_feature("use-ammo-group") then

end


if config.startup.has_feature("use-circuit-group") then

end


if config.startup.has_feature("use-transport-group") then

  if mods["space-exploration"] then

  end

  if mods["Krastorio2"] then

  end

  if mods["cargo-ships"] then

  end
end
