class Node
  include Comparable

  attr_accessor :data, :l_child, :r_child

  def initialize(data = nil)
    @data = data
    @l_child = nil
    @r_child = nil
  end
end

class Tree
  attr_accessor :root

  def initialize
    @root = nil
  end

  def build_tree(array, start, fin)
   if start > fin
    return
   end
   mid = ((start + fin) / 2)
   node = Node.new(array[mid])
   node.l_child = build_tree(array, start, mid - 1)
   node.r_child = build_tree(array, mid + 1, fin)
   node
  end

  def find(root, data)
    if root == nil || root.data == data
      return root
    elsif root.data < data
      return find(root.r_child, data)
    else return find(root.l_child, data)
    end
  end

  def insert(value)
    current_node = @root
    if current_node == nil
      @root = Node.new(value)
      return @root
    end
    while true
      if current_node.data > value
        if current_node.l_child == nil
          current_node.l_child = Node.new(value)
          return
        else
          current_node = current_node.l_child
        end

      elsif current_node.data < value
        if current_node.r_child == nil
          current_node.r_child = Node.new(value)
          return
        else
          current_node = current_node.r_child
        end
      else
        return
      end
    end
  end

  def delete(data)
    deleteRec(@root, data)
  end

  def deleteRec(root, data)
    if root.nil?
      return
    end
    if data < root.data
      root.l_child = deleteRec(root.l_child, data)
    elsif data > root.data
      root.r_child = deleteRec(root.r_child, data)

    elsif data == root.data
      if root.l_child.nil?
        return root.r_child
      elsif root.r_child.nil?
        return root.l_child
      end
      root.data = minValue(root.r_child)
      root.r_child = deleteRec(root.r_child, root.data)
    end
    return root
  end

  def minValue(root)
    minv = root.data
    while !root.l_child.nil?
      minv = root.l_child.data
      root = root.l_child
    end
    return minv
  end

  def level_order(&block)
    queue = [@root]
    output = []
    while !queue.empty?
      queue.push(queue[0].l_child) if queue[0].l_child
      queue.push(queue[0].r_child) if queue[0].r_child
      if block_given?
        yield queue[0].data
      end
      unless block_given?
        output.push(queue[0].data)
        queue.shift  
      end
    end
    p output
  end

  def preorder(current_node, output = nil, &block)
    output = [] if output.nil?
    return if current_node.nil?

    output.push(current_node.data) unless block_given?
    block.call(current_node.data) if block_given?
    preorder(current_node.l_child, output)
    preorder(current_node.r_child, output)
    output
  end

  def inorder(current_node, output = nil, &block)
    output = [] if output.nil?
    return if current_node.nil?

    inorder(current_node.l_child, output)
    output.push(current_node.data) unless block_given?
    block.call(current_node.data) if block_given?
    inorder(current_node.r_child, output)
    output
  end

  def postorder(current_node, output = nil, &block)
    output = [] if output.nil?
    return if current_node.nil?

    postorder(current_node.l_child, output)
    postorder(current_node.r_child, output)
    output.push(current_node.data) unless block_given?
    block.call(current_node.data) if block_given?
    output
  end 

  def height(root)
    return 0 if root.nil?

    left = height(root.l_child)
    right = height(root.r_child)
    height = (left < right) ? (right + 1) : (left + 1)
    return height
  end

  def depth(data, depth = nil, root = nil)
    root = @root if root.nil?
    depth = 0 if depth.nil?
    return 'doesn\'t exist in tree' if find(@root, data).nil?
    return depth if root == nil || root.data == data

    if root.data < data
      depth += 1
      return depth(data, depth, root.r_child)
    elsif root.data > data
      depth += 1
      return depth(data, depth, root.l_child)
    end
    return depth
  end

  def balanced?(root, balanced = nil)
    balanced = [] if balanced.nil?
    return if !balanced
    return if root.nil?
    balanced?(root.l_child, balanced)
    balanced?(root.r_child, balanced)
    left = height(root.l_child)
    # p 'data:'
    # p root.data
    # p 'left:'
    # p left
    right = height(root.r_child)
    # p 'right:'
    # p right
    if left - right > 1 || right - left > 1
      balanced.push(false)
    end
    (balanced.include? false) ? false : true
  end

  def rebalance
    arr = inorder(@root)
    @root = build_tree(arr, 0, arr.length - 1)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.r_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.r_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.l_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.l_child
  end

end

def merge(l_array, r_array)
  merged_array = []
  while !l_array.empty? && !r_array.empty?
    if l_array[0] < r_array[0]
      merged_array.push(l_array.shift)
    elsif l_array[0] >= r_array[0]
      merged_array.push(r_array.shift)
    end
  end
  if l_array.empty?
    merged_array += r_array
  elsif r_array.empty?
    merged_array += l_array
  end
  merged_array
end

def mergesort(array)
  if array.length == 1
    return array
  else
    midpoint = array.length / 2
    l_arr = mergesort(array.slice(0...midpoint))
    r_arr = mergesort(array.slice(midpoint...array.length))
    merge(l_arr, r_arr)
  end
end

arr = (Array.new(15) { rand(1..100) })
arr = mergesort(arr).uniq
tree = Tree.new
tree.root = tree.build_tree(arr, 0, arr.length - 1)
tree.pretty_print
puts 'Is tree balanced?'
p tree.balanced?(tree.root)
puts 'Breadth first traversal:'
tree.level_order
puts 'Preorder traversal:'
p tree.preorder(tree.root)
puts 'Postorder traversal:'
p tree.postorder(tree.root)
puts 'Inorder traversal:'
p tree.inorder(tree.root)
for i in 1..15 do
  tree.insert(rand(101..200))
end
tree.pretty_print
puts 'Is tree balanced?'
p tree.balanced?(tree.root)
puts ""
tree.rebalance
tree.pretty_print
puts 'Is tree balanced?'
p tree.balanced?(tree.root)
puts 'Breadth first traversal:'
tree.level_order
puts 'Preorder traversal:'
p tree.preorder(tree.root)
puts 'Postorder traversal:'
p tree.postorder(tree.root)
puts 'Inorder traversal:'
p tree.inorder(tree.root)


