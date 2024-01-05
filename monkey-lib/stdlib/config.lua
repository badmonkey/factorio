require("__monkey-lib__.stdlib.class")


ConfigCheck = class.configcheck()

function ConfigCheck:_init(modname, settings_type)
  self._modname = modname
  self._settings_type = settings_type
end


function ConfigCheck:has_feature(name)
  return settings[self._settings_type][self._modname .. "-" .. name].value == true
end

function ConfigCheck:value(name)
  return settings[self._settings_type][self._modname .. "-" .. name].value
end


Config = { }

function Config.of(modname)
  return {
    startup = ConfigCheck(modname, "startup"),
    global = ConfigCheck(modname, "runtime-global"),
    player = ConfigCheck(modname, "runtime-per-user")
  }
end
