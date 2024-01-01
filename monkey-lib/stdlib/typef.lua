
rawtype = type

function fulltype(var)
  local _raw = rawtype(var)
  if var and _raw == "table" then
    return _raw, rawget(var, "__type")
  end
  return _raw, nil
end

function type(var)
  local _raw, _extra = fulltype(var)
  return _extra or _raw
end

local function _class_name(var)
  local _raw = rawtype(var)
  if _raw == "string" then
    return var
  elseif _raw == "table" then
    if rawget(var, "__type") == "class" then
      return rawget(var, "_K_name")
    end
  end
  return nil
end

function is_class(var, class)
  local _name = _class_name(var)
  if _name then
    return (class and _class_name(class) == _name) or true
  end
  return false
end

function is_instance(var, class)
  if rawtype(var) == "table" then
    return is_class(getmetatable(var), class)
  end
  return false
end
