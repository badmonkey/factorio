local Settings = require("__monkey-lib__.stdlib.settings")

local setting = Settings.of("monkey-groups")

data:extend {
  setting.startup:bool_on "use-ammo-group",
  setting.startup:choice {
    name = "ammo-group-order",
    "aw","dw"
  },

  setting.startup:bool_on "use-circuit-group",
  setting.startup:bool_off "split-combinators",
  setting.startup:choice {
    name = "circuit-group-order",
    "av", "dv"
  },

  setting.startup:bool_on "use-transport-group",
  setting.startup:choice {
    name = "transport-group-order",
    "av","dv"
  },

  setting.startup:choice {
    name = "expand-group-ui-slots",
    "0","+2", "+4"
  }
}
