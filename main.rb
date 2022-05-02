# Script to play tic tac toe game in the command line interface
# frozen_string_literal: false

require_relative 'board_initializer'
require_relative 'move_placer'
require_relative 'move_validator'
require_relative 'game_checker'

# Class to initialize objects of all the classes and run the methods sequentially to run tictactoe
class TicTacToeMain
  # Declare the constants
  SIZE = 3
  PLAYER_O = 'OOO'.freeze
  PLAYER_X = 'XXX'.freeze
  include BoardInitializer

  def initialize
    @player = 'player_O'
    @board = {}
    @move_place = MovePlacer.new
    @move_validate = MoveValidator.new
    @game = GameChecker.new
  end

  # Entry method
  def main
    print "\n"
    @board = init_board(SIZE, @board)
    print_board(@board)
    if game.nil?
      puts "#{@player} lost the game due to timeout error!"
      return nil
    end

    @game.game_winner(@board, SIZE, PLAYER_O, PLAYER_X)
  end

  # Method to check if game has ended or not
  def game
    until @game.game_ended?(@board, SIZE, PLAYER_O, PLAYER_X)
      index = @move_place.get_user_input(@player)
      return nil if index.nil?

      if @move_validate.valid_move?(index) && @move_validate.repeated_moves?(index)
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
