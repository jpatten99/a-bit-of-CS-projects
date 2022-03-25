class LinkedList
  attr_reader :head

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
ll.append(9)
ll.append(8)
ll.append(8)
ll.append(8)
ll.append(8)
ll.append(8)
ll.append(7)
ll.print_list
ll.prepend(10)
ll.print_list
ll.prepend(5)
ll.print_list
ll.append(8)
ll.print_list
