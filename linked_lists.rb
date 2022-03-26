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

  def pop
    if self.size <= 1
      @head = nil
      return 
    end
    current_node = @head
    trailing_node = nil
    while !current_node.next_node.nil?
      trailing_node = current_node
      current_node = current_node.next_node
    end
    trailing_node.next_node = nil
  end

  def contains?(value)
    if size <= 0
      p 'empty list'
      return false
    end
    current_node = @head
    for i in (0...size)
      if current_node.value == value
        p 'found it!' 
        return true
      end
      current_node = current_node.next_node
    end
    p 'couldn\'t be found'
    return false
  end

  def find(value)
    if size <= 0
      return nil
    end
    current_node = @head
    for i in (0...size)
      if current_node.value == value
        return i
      end
      current_node = current_node.next_node
    end
    return nil
  end

  def to_s
    if self.size == 0
      return
    end
    current_node = @head
    while !current_node.next_node.nil?
      print "(#{current_node.value}) -> "
      current_node = current_node.next_node
    end
    print "(#{current_node.value})\n"
  end

  def insert_at(value, index)
    if size == 0
      p 'ERROR'
      return
    end
    if index == 0
      prepend(value)
    elsif index == size - 1
      append(value)
    elsif index > size - 1 || index.negative?
      p "ERROR"
      return
    else
      current_node = @head
      trailing_node = nil
      for i in (0...index)
        trailing_node = current_node
        current_node = current_node.next_node
      end
      new_node = Node.new(value)
      trailing_node.next_node = new_node
      new_node.next_node = current_node
    end
  end

  def remove_at(index)
    if size == 0
      p 'ERROR'
      return
    end
    if index == 0
      @head = @head.next_node
    elsif index == size - 1
      pop
    elsif index > size - 1 || index.negative?
      p 'ERROR'
      return
    else
      current_node = @head
      trailing_node = nil
      for i in (0...index)
        trailing_node = current_node
        current_node = current_node.next_node
      end
      trailing_node.next_node = current_node.next_node
    end
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
ll.remove_at(1)
ll.append(0)
ll.append(1)
ll.append(2)
ll.append(3)
ll.append(4)
ll.append(5)
ll.to_s
ll.remove_at(4)
ll.to_s
ll.remove_at(4)
ll.to_s
ll.remove_at(1)
ll.to_s
