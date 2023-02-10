class Node
  attr_accessor :value
  attr_accessor :left
  attr_accessor :right
  def initialize(value = nil, left = nil, right = nil)
    @value = value
    @left = left
    @right = right
  end
end

class Tree
  attr_accessor :root

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def build_branch(list)
    if list.length == 0 then return nil end
    
    middle = (list.length / 2).floor
    left = build_tree(list[0...middle])
    right = build_tree(list[(middle + 1)..])

    middle = Node.new(list[middle], left, right)
    return middle
  end

  def build_tree(list)
    list.sort!
    @root = build_branch(list)
  end

  def insert(value)
    node = @root
    new_node = Node.new(value)
    while true
      if value <= node.value
        if node.left == nil
          node.left = new_node
          break
        end
        node = node.left
      else
        if node.right == nil
          node.right = new_node
          break
        end
        node = node.right
      end
    end
  end

  def remove(value, node = @root)
    return nil if node.nil?

    if value < node.value
      node.left = remove(value, node.left)
    elsif value > node.value
      node.right = remove(value, node.right)
    else
      return node.right if node.left.nil?
      return node.left if node.right.nil?
      leftmost = node.right
      while leftmost.left != nil
        leftmost = leftmost.left
      end

      node.value = leftmost.value
      node.right = remove(leftmost.value, node.right)
    end
    return node
  end

  def find(value)
    node = @root
    while node.value != value
      if value <= node.value
        if node.left == nil
          return nil
        end
        node = node.left
      else
        if node.right == nil
          return nil
        end
        node = node.right
      end
    end
    return node
  end

  def level_order (block = lambda {|i| puts i.value}, node = @root)
    queue = [node]
    while not queue.empty?
      thing = queue[0]
      if thing.left then queue.push(thing.left) end
      block.call(thing)
      if thing.right then queue.push(thing.right) end
      queue.shift()
    end
  end

  def in_order (block = lambda {|i| puts i.value}, node = @root)
    if node.left then in_order(block, node.left) end
    block.call(node)
    if node.right then in_order(block, node.right) end
  end

  def pre_order (block = lambda {|i| puts i.value}, node = @root)
    block.call(node)
    if node.left then pre_order(block, node.left) end
    if node.right then pre_order(block, node.right) end
  end

  def post_order (block = lambda {|i| puts i.value}, node = @root)
    if node.left then post_order(block, node.left) end
    if node.right then post_order(block, node.right) end
    block.call(node)
  end

  def height (node = @root)
    if not node then return 0 end
    left = 1 + height(node.left)
    right = 1 + height(node.right)
    if left > right
      return left
    else
      return right
    end
  end

  def depth (node, root = @root)
    if node == root then return 0 end
    if node.value > root.value
      return 1 + depth(node, root.right)
    else
      return 1 + depth(node, root.left)
    end
  end

  def balanced? (node = @root)
    if not node then return true end
    left = height(node.left)
    right = height(node.right)
    return (((left + 1) >= right) and ((right + 1) >= left) and balanced?(node.right) and balanced?(node.left))
  end

  def rebalance
    if not balanced?()
      list = []
      in_order(lambda{|i| list.append(i.value)})
      build_tree(list)
    end
  end
end


mytree = Tree.new
mytree.build_tree((Array.new(15) { rand(1..100) }))
puts mytree.balanced?
mytree.level_order(lambda {|i| print i.value, ", "})
puts 
mytree.pre_order(lambda {|i| print i.value, ", "})
puts 
mytree.post_order(lambda {|i| print i.value, ", "})
puts 
mytree.in_order(lambda {|i| print i.value, ", "})
puts 

mytree.insert(200)
mytree.insert(300)
mytree.insert(400)
puts mytree.balanced?
mytree.rebalance
puts mytree.balanced?

mytree.level_order(lambda {|i| print i.value, ", "})
puts 
mytree.pre_order(lambda {|i| print i.value, ", "})
puts 
mytree.post_order(lambda {|i| print i.value, ", "})
puts 
mytree.in_order(lambda {|i| print i.value, ", "})
puts 

mytree.pretty_print