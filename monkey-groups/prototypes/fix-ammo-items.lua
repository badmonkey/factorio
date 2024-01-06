require("__monkey-lib__.stdlib.config")
require("lib.subgroup")

local config = Config.of("monkey-groups")
if not config.startup:has_feature("use-ammo-group") then
  return
end


if config.startup:value("ammo-fuel-subgroup") ~= "just-ammo" then

  Subgroup.direct("fuel").update {
    Subgroup.move_item "fuel",
    Subgroup.move_item "bio-fuel",
    Subgroup.move_item "advanced-fuel",
  }

end
