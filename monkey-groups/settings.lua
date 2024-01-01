local Settings = require("__monkey-lib__.stdlib.settings")

local setting = Settings.of("monkey-groups")

data:extend {
  -- Circuits

  setting.startup:bool_on "use-circuit-group",
  setting.startup:choice {
    name = "circuit-group-order",
    "after-log",
    "before-log",
    "after-combat",
    "before-combat"
  },
  setting.startup:bool_off "split-combinators",

  -- Transport and Equipment

  setting.startup:bool_on "use-transport-group",
  setting.startup:choice {
    name = "transport-group-order",
    "after-log",
    "before-log",
    "after-combat",
    "before-combat"
  },

  -- Ammo and Fuel

  setting.startup:bool_on "use-ammo-group",
  setting.startup:choice {
    name = "ammo-group-order",
    "after-combat",
    "before-combat"
  },
  setting.startup:bool_on "ammo-includes-fuel",
  setting.startup:choice {
    name = "ammo-subgroup-order",
    "ammo-fuel",
    "fuel-ammo"
  },

  -- Expand UI for all the new groups

  setting.startup:choice {
    name = "expand-group-ui-slots",
    "none",
    "plus2",
    "plus4"
  }
}
