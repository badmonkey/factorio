local Ordering = require("stdlib.ordering")

function make_settings_type(modname, typeId)
  local SettingType = {
    _order = Ordering.new(Ordering.simple)
  }


  function SettingType.bool_on(self, input)
    if type(input) == string then
      input = {name = input}
    end
    input.default_value = true
    return self:boolean(input)
  end

  function SeSettingTypeool_off(self, input)
    if type(input) == string then
      input = {name = input}
    end
    input.default_value = false
    return self:boolean(input)
  end

  function SettingType.boolean(self, input)
    return {
      type = "bool-setting",
      name = modname .. "-" .. input.name,
      order = self._order:next(),
      setting_type = typeId,
      default_value = input.default_value
    },
  end

  function SettingType.choice(self, input)
    local allowed = {}

    for i, value in ipairs(input) do
      allowed[i] = value
    end

    return {
      type = "string-setting",
      name = modname .. "-" .. input.name,
      order = self._order:next(),
      setting_type = typeId,
      default_value = input.default_value or allowed[1]
      allowed_values = allowed
    }
  end


  return SettingType
end


local Setting = { }


function Setting.of(modname)
  return {
    startup = make_settings_type(modname, "startup")
  }
end


return Setting
