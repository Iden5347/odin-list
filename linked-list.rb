class Node
  attr_accessor :value
  attr_accessor :next
  def initialize(value = nil, next_node = nil)
    @value = value
    @next = next_node
  end
end

class LinkedList

  def initialize
    @size = 0
    @first = nil
    @last = nil
  end

  def append(value)
    node = Node.new(value)
    if @last != nil
      @last.next = node
    end
    @last = node
    if @size == 0
      @first = @last
    end
    @size += 1
  end

  def prepend(value)
    node = Node.new(value)
    node.next = @first
    @first = node
    if size == 0
      @last = @first
    end
    @size += 1
  end

  def insert_at(value, index)
    if index == 0
      new_node = Node.new(value)
      new_node.next = @first
      @first = new_node
    else
      node = @first
      for i in 1...index
        node = node.next
      end
      new_node = Node.new(value)
      new_node.next = node.next
      node.next = new_node
    end
    if size == 0
      @last = @first
    end
    @size += 1
  end

  def size
    return @size
  end
  
  def head
    return @first
  end
  
  def tail
    return @last
  end

  def at(index)
    node = @first
    for i in 0...index
      node = node.next
    end
    return node
  end

  def shift
    @first = @first.next
    @size -= 1
  end

  def remove_at(index)
    if index == 0
      @first = @first.next
    else
      node = @first
      for i in 1...index
        node = node.next
      end
      node.next = node.next.next
    end
    @size -= 1
  end

  def contains?(value)
    node = @first
    while node != nil
      if node.value == value then return true end
      node = node.next
    end
    return false
  end

  def find(value)
    node = @first
    i = 0
    while node != nil
      if node.value == value then return i end
      node = node.next
      i += 1
    end
    return nil
  end

  def to_s
    nodestring = ""
    node = @first
    for i in 0...@size
      nodestring += "( #{node.value} ) -> "
      node = node.next
    end
    nodestring += "nil"
    return nodestring
  end

end

mylist = LinkedList.new
mylist.insert_at("1", 0)
mylist.insert_at("2", 1)
mylist.insert_at("3", 2)
mylist.insert_at("4", 3)
puts mylist.to_s