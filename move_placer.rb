# frozen_string_literal: false

require 'timeout'
require_relative 'board_initializer'

# Class to input the moves from the user and place it in the board.
class MovePlacer
  # Declare constants and load module.
  MOVE_TIMEOUT = 20
  include BoardInitializer

  # Initialize
  def initialize
    @user_input = nil
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
    print_board(board)
    [board, player]
  end
end
