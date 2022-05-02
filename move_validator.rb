# frozen_string_literal: false

# Class to validate if the user input moves are valid or not
class MoveValidator
  # Declare Constants
  INDEX_ARRAY = [[0, 0], [0, 1], [0, 2], [1, 0], [1, 1], [1, 2], [2, 0], [2, 1], [2, 2]].freeze

  def initialize
    @moves = []
  end

  # Checks if the move entered is valid or not.
  def valid_move?(index)
    if INDEX_ARRAY.include?(index)
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
