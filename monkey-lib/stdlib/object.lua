
object = {}

function object.type(var)
  local _raw = type(var)
  if _raw == "table" then
    return _raw, rawget(var, "__type")
  end
  return _raw, nil
end

function object.name(var)
  if type(var) == "table" then
    -- are we a class?
    if rawget(var, "__type") == "class" then
      return rawget(var, "_cl_name")
    end

    -- are we an instance of a class?
    mt = getmetatable(var)
    if mt and rawget(mt, "__type") == "class" then
      return rawget(mt, "_cl_name")
    end
  end

  -- not an object
  return nil
end

function object.is_class(var)
  if type(var) == "table" then
    return rawget(var, "__type") == "class"
  end
  return false
end

function object.is_instance(var)
  if type(var) == "table" then
    return is_class(getmetatable(var))
  end
  return false
end
