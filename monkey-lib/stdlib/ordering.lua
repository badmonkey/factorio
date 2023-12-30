
local Ordering = {
  simple = "a#b#c#d#e#f#g#h#i#j#k#l#m#n#o#p#q#r#s#t#u#v#w#x#y#z"
}

function Ordering.new(sequence)
      local instance = { }

      function instance.next(self)
    local result = self._next
    self._next = self._sequence:match(result..'#(%a+)#')
    return result
  end

  instance._sequence = sequence .. '#'
  instance._next = instance._sequence:match('^(%a+)#')

  -- check for _next == nil

  return instance
end


return Ordering
