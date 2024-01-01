local Config = require("__monkey-lib__.stdlib.config")

local config = Config.of("monkey-groups")

local expand_ui_slots = config.startup.value("expand-group-ui-slots")
if expand_ui_slots  == "+2" then
  data.raw["utility-constants"]["default"].select_group_row_count = 8
elseif config.startup.value("expand-group-ui-slots") == "+4" then
  data.raw["utility-constants"]["default"].select_group_row_count = 10
end


if config.startup.has_feature("use-ammo-group") then
  require("prototypes.fix-ammo-items")
end


if config.startup.has_feature("use-circuit-group") then
  require("prototypes.fix-circuit-items")

  require("compat.aai-signals")
  require("compat.radio-networks")
end


if config.startup.has_feature("use-transport-group") then
  require("prototypes.fix-transport-items")

  require("compat.aai-vehicles")

  if mods["space-exploration"] then
    require("compat.space-exploration")
  end

  if mods["Krastorio2"] then
    require("compat.krastorio2")
  end

  if mods["cargo-ships"] then
    require("compat.cargo-ships")
  end
end
