require("__monkey-lib__.stdlib.object")
require("__monkey-lib__.stdlib.luaextend")



local function _construct_instance(obj, klass, ...)
  if not klass then return end

  if klass._init then
    if klass._cl_extends then
      obj.super = function(self, ...)
        _construct_instance(obj, klass._cl_extends, ...)
        self.super = nil
      end
    else
      obj.super = function(self, ...)
        error("class "..klass._cl_name.." has no base class to call super() on!")
      end
    end

    klass._init(obj, ...)

    if klass._cl_extends and obj.super ~= nil then
      error("class " .. klass._cl_name .. " failed to call super()")
    end

  else
    _construct_instance(obj, klass._cl_extends, ...)
  end
end


local _KLASS_METATABLE = {
  __call = function(class_tbl, ...)
    local obj = {
      __type = class_tbl._cl_name
    }

    setmetatable(obj, class_tbl)
    _construct_instance(obj, class_tbl, ...)

    return obj
  end
}


local function _defclass(typeid, base, members)
  local klass = {
    __type = "class",
    _cl_name = typeid,
    _cl_extends = base
  }

  table.copy_into(klass, members)

  function klass.__index(tbl, key)
    local v = rawget(klass, key)
    if v ~= nil then return v end

    local base = rawget(klass, "_cl_extends")
    if base ~= nil then return base[key] end

    -- property getter?
    error("missing member " .. rawget(klass, "_cl_name") .. "." .. key)
  end

  setmetatable(klass, _KLASS_METATABLE)
  return klass
end


local function defclass(typeid, base, members)
  -- class.foo(base: class)
  -- class.foo(base: class, members: map)
  if object.is_class(base) then
    return _defclass(typeid, base, members or {})
  end

  -- class.foo(members: map)
  if type(base) == "table" then
    return _defclass(typeid, nil, base or {})
  end

  -- class.foo()
  return _defclass(typeid, nil, {})
end

class = { }

local mt = {
  __index = function(tbl, key)
    return function(...)
      local c = defclass(key, ...)
      rawset(tbl, key, c)
      return c
    end
  end
}
setmetatable(class, mt)


return class
