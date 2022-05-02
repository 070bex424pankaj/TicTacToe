# Script to play tic tac toe game in the command line interface
# frozen_string_literal: false

require_relative 'board_initializer'
require_relative 'move_placer'
require_relative 'move_validator'
require_relative 'game_checker'

# Class to initialize objects of all the classes and run the methods sequentially to run tictactoe
class TicTacToeMain
  include BoardInitializer

  def initialize
    @size = nil
    @player_o = 'O'
    @player_x = 'X'
    @player = 'player_O'
    @board = {}
    @move_place = MovePlacer.new
    @move_validate = MoveValidator.new
    @game = GameChecker.new
  end

  # Get the size for tictactoe
  def input_size
    input_size_flag = true
    while input_size_flag
      puts 'Enter the size for tictactoe'
      @size = gets.chomp.to_i
      input_size_flag = false if @size >= 3 && @size <= 6

    end
  end

  # Set the winning pattern for tictactoe
  def initialize_winning_pattern
    @player_o *= @size
    @player_x *= @size
  end

  # Entry method
  def main
    print "\n"
    input_size
    initialize_winning_pattern
    @board = init_board(@size, @board)
    print_board(@board)
    if game.nil?
      puts "#{@player} lost the game due to timeout error!"
      return nil
    end

    @game.game_winner(@board, @size, @player_o, @player_x)
  end

  # Method to check if game has ended or not
  def game
    until @game.game_ended?(@board, @size, @player_o, @player_x)
      index = @move_place.get_user_input(@player)
      return nil if index.nil?

      if @move_validate.valid_move?(index, @size) && @move_validate.repeated_moves?(index)
        @board, @player = @move_place.place_move(@board, @player, index)
      else
        puts 'Enter a valid move from the matrix'
      end
    end
    true
  end
end

# Initialize an object of TicTacToe class
t_t_t = TicTacToeMain.new
puts 'Game ended' if t_t_t.main.nil?
