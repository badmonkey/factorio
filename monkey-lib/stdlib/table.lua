require("monkey-lib.stdlib.typef")

function table.format(tbl, indent)
  if tbl == nil then return "nil" end
  if not indent then indent = 0 end

  local toprint = "{\r\n"
  indent = indent + 2
  for k, v in pairs(tbl) do
    toprint = toprint .. string.rep(" ", indent)
    if (type(k) == "number") then
      toprint = toprint .. "[" .. k .. "] = "
    elseif (type(k) == "string") then
      toprint = toprint  .. k ..  " = "
    end

    local _type = rawtype(v)
    if (_type == "number") then
      toprint = toprint .. v .. ",\r\n"
    elseif (_type == "string") then
      toprint = toprint .. "\"" .. v .. "\",\r\n"
    elseif (_type == "table") then
      toprint = toprint .. table.format(v, indent + 2) .. ",\r\n"
    else
      toprint = toprint .. "\"" .. tostring(v) .. "\",\r\n"
    end
  end
  toprint = toprint .. string.rep(" ", indent-2) .. "}"
  return toprint
end


function table.copy_into(target, tbl)
  for k, v in pairs(tbl) do
    target[k] = v
  end
end
