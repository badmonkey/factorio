require("stdlib.class")

Ordering = class.ordering({
    simple = "a#b#c#d#e#f#g#h#i#j#k#l#m#n#o#p#q#r#s#t#u#v#w#x#y#z"
})

function Ordering:_init(sequence)
  self.sequence = sequence .. '#'
  self.next = self.sequence:match('^(%a+)#')
end

function Ordering:next()
  local result = self._next
  self._next = self._sequence:match(result..'#(%a+)#')
  return result
end


return Ordering
