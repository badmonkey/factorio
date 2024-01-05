
function table.format(tbl)
  return serpent.block(tbl)
end

function table.format_array(tbl)
  for i = 1, table_size(tbl) do
    local val = tbl[i]
    if not val then
      tbl[i] = "nil"
    elseif type(val) == "table" then
      tbl[i] = serpent.line(val)
    else
      tbl[i] = tostring(val)
    end
  end
  return table.concat(tbl, " ")
end

function table.copy_into(target, tbl)
      for k, v in pairs(tbl) do
    target[k] = v
  end
end


function string.chop_head(input)
  return string.sub(input, 1, 1), string.sub(input, 2, -1)
end

function string.chop_tail(input)
  return string.sub(input, 1, -2), string.sub(input, -1)
end



local default = {}
Switch = {
  default = default,
  on = function(var)
    return setmetatable({ switch = var }, {
        __type = "switch",
        __call = function (t, cases)
          local item = t["switch"] or default
          local f = cases[item] or cases[default] or function () end
          local _type = type(f)
          if _type == "function" then
            return f(item)
          end
          return f
        end
    })
  end
}


function dumplog(...)
  log(table.format_array({...}))
end
