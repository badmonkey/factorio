require("stdlib.class")
require("stdlib.ordering")

local Setting = class.setting()

function Setting:_init(modname, setting_type)
  self.modname = modname
  self.order = Ordering(Ordering.simple)
  self.setting_type = setting_type
end

function Setting:bool_on(input)
  if type(input) == string then
    input = {name = input}
  end
  input.default_value = true
  return self:boolean(input)
end

function Setting:bool_off(input)
  if type(input) == string then
    input = {name = input}
  end
  input.default_value = false
  return self:boolean(input)
end

function Setting:boolean(input)
  return {
    type = "bool-setting",
    name = self.modname .. "-" .. input.name,
    order = self.order:next(),
    setting_type = self.setting_type,
    default_value = input.default_value
  }
end

function Setting:choice(input)
  local allowed = {}

  for i, value in ipairs(input) do
    allowed[i] = value
  end

  return {
    type = "string-setting",
    name = self.modname .. "-" .. input.name,
    order = self.order:next(),
    setting_type = self.setting_type,
    default_value = input.default_value or allowed[1]
    allowed_values = allowed
  }
end


Settings = { }

function Settings.of(modname)
  return {
    startup = Setting(modname, "startup"),
    global = Setting(modname, "runtime-global"),
    player = Setting(modname, "runtime-per-user")
  }
end
