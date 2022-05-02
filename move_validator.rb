# frozen_string_literal: false

# Class to validate if the user input moves are valid or not
class MoveValidator
  def initialize
    @moves = []
    @index_array = []
  end

  # Generate validation array for user input
  def index_array(size)
    [*0...size].each do |x|
      [*0...size].each do |y|
        @index_array << [x, y]
      end
    end
  end

  # Checks if the move entered is valid or not.
  def valid_move?(index, size)
    index_array(size)
    if @index_array.include?(index)
      true
    else
      false
    end
  end

  # Checks if there are repeated moves or not.
  def repeated_moves?(index)
    if @moves.include?(index)
      puts 'Repeated moves!!!!!!'
      false
    else
      @moves << index
      true
    end
  end
end
