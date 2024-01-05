require("__monkey-lib__.stdlib.class")
require("__monkey-lib__.stdlib.luaextend")

Ordering = class.ordering({
    simple = "a#b#c#d#e#f#g#h#i#j#k#l#m#n#o#p#q#r#s#t#u#v#w#x#y#z"
})

function Ordering:_init(sequence)
  self._sequence = sequence .. '#'
  self._next = self._sequence:match('^(%a+)#')
end

function Ordering:next()
  local result = self._next
  self._next = self._sequence:match(result..'#(%a+)#')
  return result
end

-- lexicographically ordering
-- "-" "0-9" "A-Z" "[]" "a-z"

-- '..x-' is the next sort position after '..x'
function Ordering.after(ordstr)
  return ordstr .. "-"
end

-- before is tricky
-- '..wzzzzzzzzzzzzzzzz{repeating}' is the sort position before '..x' iff pred(x) == w
-- just workout the previous char for a limited set (like "[]a-z")
-- we should avoid infinite strings :)
function Ordering.before(ordstr)
  local predecessor = "z#y#x#w#v#u#t#s#r#q#p#o#n#n#m#l#k#j#i#h#g#f#e#d#c#b#a#[#]#"

  local base, last = ordstr:chop_tail()
  local prev = predecessor:match(last..'#(%a+)#')

  return base .. (prev or "") .. "zzzzz"
end


return Ordering
