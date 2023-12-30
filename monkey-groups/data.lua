local Config = require("__monkey-lib__.stdlib.config")

local config = Config.of("monkey-groups")

if config.startup.has_feature("use-ammo-group") then
  require("prototypes.group-ammo")
end

if config.startup.has_feature("use-circuit-group") then
  require("prototypes.group-circuit")
end

if config.startup.has_feature("use-transport-group") then
  require("prototypes.group-transport")
end
