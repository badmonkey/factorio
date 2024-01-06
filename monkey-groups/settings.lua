require("__monkey-lib__.stdlib.settings")


local setting = Settings.of("monkey-groups")

data:extend {
  -- Circuits

  setting.startup:bool_on "use-circuit-group",

  -- Transport and Equipment

  setting.startup:bool_on "use-transport-group",
  setting.startup:bool_on "split-rolling-stock",

  -- Ammo and Fuel

  setting.startup:bool_on "use-ammo-group",
  setting.startup:choice {
    name = "ammo-fuel-subgroup",

    "just-ammo",
    "ammo-fuel",
    "fuel-ammo"
  },

  -- Ordering groups

  setting.startup:choice {
    name = "circuit-group-order",

    "after-log",
    "before-log",
    "after-combat",
    "before-combat"
  },
  setting.startup:choice {
    name = "transport-group-order",

    "after-log",
    "before-log",
    "after-combat",
    "before-combat"
  },
  setting.startup:choice {
    name = "ammo-group-order",

    "after-combat",
    "before-combat"
  },
}
