require("__monkey-lib__.stdlib.config")
require("lib.subgroup")

local config = Config.of("monkey-groups")
if not config.startup:has_feature("use-transport-group") then
  return
end


local modgroup = Subgroup("transport")

modgroup("civilian").update {
  Subgroup.move_entity "car",

  Subgroup.with("aai-vehicles-miner").update {
    Subgroup.move_entity "vehicle-miner",
    Subgroup.move_entity "vehicle-miner-mk2",
    Subgroup.move_entity "vehicle-miner-mk3",
    Subgroup.move_entity "vehicle-miner-mk4",
    Subgroup.move_entity "vehicle-miner-mk5",
  },

  Subgroup.with("aai-vehicles-hauler").move_entity "vehicle-hauler",
  Subgroup.with("aai-vehicles-warden").move_entity "vehicle-warden",
}

modgroup("military").update {
  Subgroup.move_entity "tank",
  Subgroup.move_entity "spidertron",

  Subgroup.with("space-exploration").move_entity "ss-space-spidertron",
  Subgroup.with("Krastorio2").move_entity "kr-advanced-tank",
  Subgroup.with("aai-vehicles-chaingunner").move_entity "vehicle-chaingunner",
  Subgroup.with("aai-vehicles-flame-tumbler").move_entity "vehicle-flame-tumbler",
  Subgroup.with("aai-vehicles-flame-tank").move_entity "vehicle-flame-tank",
  Subgroup.with("aai-vehicles-laser-tank").move_entity "vehicle-laser-tank",
}


if config.startup:has_feature("split-rolling-stock") then

  modgroup("locomotive").update {
    Subgroup.move_entity "locomotive",

    Subgroup.with("Krastorio2").move_entity "kr-nuclear-locomotive",
    Subgroup.with("se-space-trains").move_entity "space-locomotive",

    Subgroup.move_entities_from_subgroup("electric-transport-loc"),
  }
  modgroup("cargo-wagon").update {
    Subgroup.move_entity "cargo-wagon",
    Subgroup.move_entity "artillery-wagon",

    Subgroup.with("se-space-trains").move_entity "space-cargo-wagon",

    Subgroup.move_entities_from_subgroup("electric-transport-cargo"),
  }
  modgroup("fluid-wagon").update {
    Subgroup.move_entity "fluid-wagon",

    Subgroup.with("se-space-trains").move_entity "space-fluid-wagon",

    Subgroup.move_entities_from_subgroup("electric-transport-fluid"),
  }

else

  Subgroup.direct("train-transport").update {
    Subgroup.move_entity "locomotive",
    Subgroup.move_entity "cargo-wagon",
    Subgroup.move_entity "fluid-wagon",
    Subgroup.move_entity "artillery-wagon",

    Subgroup.with("Krastorio2").move_entity "kr-nuclear-locomotive",

    Subgroup.move_entities_from_subgroup("electric-transport-loc"),
    Subgroup.move_entities_from_subgroup("electric-transport-cargo"),
    Subgroup.move_entities_from_subgroup("electric-transport-fluid"),

    Subgroup.with("se-space-trains").update {
      Subgroup.move_entity "space-locomotive",
      Subgroup.move_entity "space-cargo-wagon",
      Subgroup.move_entity "space-fluid-wagon",
    },
  }

end

Subgroup.direct("train-transport").update {
  Subgroup.move_items_from_subgroup("electric-transport-basic"),
}

modgroup("water").update {
  Subgroup.with("cargo-ships").update {
    Subgroup.move_entity "boat",
    Subgroup.move_entity "indep-boat",
    Subgroup.move_entity "cargo_ship",
    Subgroup.move_entity "oil_tanker",
  },

  Subgroup.with("aai-vehicles-ironclad").move_entity "ironclad",
}

modgroup("aircraft").update {
  Subgroup.with("Aircraft").update {
    Subgroup.move_entity "cargo-plane",
    Subgroup.move_entity "gunship",
    Subgroup.move_entity "jet",
    Subgroup.move_entity "flying-fortress",
  }
}
