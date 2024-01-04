require("stdlib.class")


ConfigCheck = class.configcheck()

function ConfigCheck:_init(modname, settings_type)
  self.modname = modname
  self.settings_type = settings_type
end


function ConfigCheck:has_feature(name)
  return settings[self.settings_type][self.modname .. "-" name].value
end

function ConfigCheck:value(name)
  return settings[self.settings_type][self.modname .. "-" name].value
end


Config = { }

function Config.of(modname)
  return {
    startup = ConfigCheck(modname, "startup"),
    global = Config.Check(modname, "runtime-global"),
    player = ConfigCheck(modname, "runtime-per-user")
  }
end
