class LinkedList

  def initialize
    @head = nil
  end

  def append(value)
    # head is nil? -> linked list is empty, make node to be appended the head
    if @head.nil?
      @head = Node.new(value)
    else
      # start at head node, keep iterating until the node we're checking has no next node, this means we've hit the end
      # place node 1 place beyond tail node (tail node's next_node)
      current_node = @head
      while !current_node.next_node.nil?
        current_node = current_node.next_node
      end
      current_node.next_node = Node.new(value)
    end
  end

  def prepend(value)
    node = Node.new(value)
    head_holder = @head
    @head = node
    node.next_node = head_holder
  end

  def size
    if @head.nil?
      return 0
    else 
      count = 1
      current_node = @head
      while !current_node.next_node.nil?
        count += 1
        current_node = current_node.next_node
      end
    end
    count
  end
  
  def head
    @head
  end

  def tail
    if self.size == 1
      return @head
    else
      current_node = @head
      while !current_node.next_node.nil?
        current_node = current_node.next_node
      end
      return current_node
    end
  end

  # zero based indexing
  def at(index)
    if index > self.size-1 || index < 0
      return 'ERROR'
    end
    current_node = @head
    for i in (0...index)
      current_node = current_node.next_node
    end
    current_node.value
  end

  def print_list
    current_node = @head
    while !current_node.next_node.nil?
      print "#{current_node.value}--->"
      current_node = current_node.next_node
    end
    print "#{current_node.value}\n"
  end
end

class Node
  attr_reader :value, :next_node

  def initialize(value = nil)
    @next_node = nil
    @value = value
  end

  def value=(value)
    @value = value
  end

  def next_node=(next_node)
    @next_node = next_node
  end
end

ll = LinkedList.new
p ll.size
ll.append(9)
p ll.size
ll.append(8)
ll.append(8)
ll.append(8)
ll.append(8)
ll.append(8)
ll.append(7)
p ll.size
ll.print_list
ll.prepend(10)
p ll.size
ll.print_list
ll.prepend(5)
p ll.size
ll.print_list
ll.append(8)
p ll.size
ll.print_list
p ll.at(0)
p ll.at(10)
p ll.at(9)
p ll.at(2)
p ll.at(-1)
p ll.at(2)