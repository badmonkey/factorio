

function make_config(modname, typeId)
  local config = { }

  function config.has_feature(name)
    return settings[typeId][modname .. "-" name].value
  end

  function config.value(name)
    return settings[typeId][modname .. "-" name].value
  end

  return config
end


local Config = { }


function Config.of(modname)
  return {
    startup = make_config(modname, "startup")
  }
end


return Config
