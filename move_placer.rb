# frozen_string_literal: false

require 'timeout'

# Class to input the moves from the user and place it in the board.
class MovePlacer
  # Declare constants and load module.
  MOVE_TIMEOUT = 20

  # Initialize
  def initialize(size)
    @size = size
    @user_input = nil
    @moves = []
    @index_array = []
  end

  # Gets the user input. User must enter a move in a specified time ie. 20.
  def get_user_input(player)
    puts "Enter a #{player} move (use comma separated coordinates shown in matrix!!). You have 20 seconds."
    begin
      Timeout.timeout MOVE_TIMEOUT do
        @user_input = gets.chomp
      end
    rescue Timeout::Error
      return nil
    end
    u, v = @user_input.split(',')
    [u.to_i, v.to_i]
  end

  # Method to place a move in the board after user has entered the move.
  def place_move(board, player, index)
    board[index] = player == 'player_O' ? 'O' : 'X'
    player = player == 'player_O' ? 'player_X' : 'player_O'
    [board, player]
  end

  # Generate validation array for user input
  def index_array
    [*0...@size].each do |x|
      [*0...@size].each do |y|
        @index_array << [x, y]
      end
    end
  end

  # Checks if the move entered is valid or not.
  def valid_move?(index)
    index_array
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
