class Node
  attr_reader :x_coordinate, :y_coordinate, :level

  def initialize(x_coordinate, y_coordinate, level = nil)
    @x_coordinate = x_coordinate
    @y_coordinate = y_coordinate
    @level = level
  end

end

class KnightsTravail
  attr_reader :board

  NEXT_MOVES_X = [1, 1, -1, -1, 2, 2, -2, -2]
  NEXT_MOVES_Y = [2, -2, 2, -2, 1, -1, 1, -1]

  def initialize
    @board = Array.new
    @visited = []
  end

  def populate_board
    for x in 1..8 do
      for y in 1..8 do
        node = Node.new(x, y)
        # coordinate = [x, y]
        @board.push(node)
      end
    end
  end

  def print_board
    @board.each { |x|
      puts x.join(' ')
    }
  end

  def valid_node?(node)
    return false if node.x_coordinate > 8 || node.x_coordinate < 1 || node.y_coordinate > 8 || node.y_coordinate < 1

    true
  end

  def make_next_moves(node)
    next_moves = []
    for i in 0..7 do
      next_node = Node.new(node.x_coordinate + NEXT_MOVES_X[i], node.y_coordinate + NEXT_MOVES_Y[i], node.level + 1)
      if valid_node?(next_node) && !@visited.include?(next_node)
        next_moves.push(next_node)
        @visited.push(next_node)
        # print next_node.x_coordinate
        # print ', '
        # print next_node.y_coordinate
        # puts ''
      end
    end
    next_moves
  end

  def find_path(x_1, y_1, x_2, y_2)
    queue = []
    queue.push(Node.new(x_1, y_1, 0))
    while !queue.nil?
      holder = queue.shift
      if holder.x_coordinate == x_2 && holder.y_coordinate == y_2
        p "Steps needed from [#{x_1}, #{y_1}] to [#{x_2}, #{y_2}]: #{holder.level}"
        return holder.level
      end
      next_moves = make_next_moves(holder)
      next_moves.each do |move| 
        queue.push(move)
        # p move.x_coordinate
      end
    end
  end
end

test = KnightsTravail.new
test.find_path(1, 1, 4, 8)
