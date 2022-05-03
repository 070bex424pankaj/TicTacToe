# class to initialize and print the board
# frozen_string_literal: false

# class to initialize and print the board.
class BoardInitializer
  # Declare Constants
  EMPTY = '-'.freeze

  def initialize(size)
    @size = size
  end

  # Initializes the game board.
  def init_board(board)
    [*0...@size].each do |x|
      [*0...@size].each do |y|
        board[[x, y]] = EMPTY
      end
    end
    board
  end

  # Prints the game board in the matrix format
  def print_board(board)
    board.each do |x, y|
      print "\n\t\t\t..................\n" if x[0] != 0 && x[1].zero?
      print "\t\t\t" if x[1].zero?
      y == '-' ? (print " #{x[0]},#{x[1]} |") : (print "  #{y}  |")
    end
    print("\n")
  end
end
