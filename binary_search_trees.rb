class Node
  include Comparable

  attr_accessor :data, :l_child, :r_child

  def initialize(data = nil)
    @data = data
    @l_child = nil
    @r_child = nil
  end

  def isLeaf?
    @l_child == nil && @r_child == nil ? true : false  
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

arr = [0, 1, 2, 3, 4, 5, 6, 7, 8, 8, 0]
arr = mergesort(arr).uniq
tree = Tree.new
tree.insert(9)
tree.root = tree.build_tree(arr, 0, arr.length - 1)
tree.pretty_print
puts""
 tree.insert(9)
 tree.insert(20)
 tree.insert(1)
 tree.insert(-1)
 tree.pretty_print
 puts ""
 tree.delete(4)
 tree.pretty_print
 puts ""
 tree.delete(2)
 tree.pretty_print
 puts ""
 tree.delete(0)
 tree.pretty_print
 puts ""
 tree.delete(8)
 tree.pretty_print
 puts ""

 tree.delete(5)
 tree.pretty_print
 puts ""
p tree.find(tree.root, -1)


