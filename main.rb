# Script to play tic tac toe game in the command line interface
# frozen_string_literal: false

require_relative 'board_initializer'
require_relative 'move_placer'
require_relative 'move_validator'
require_relative 'game_checker'

# Class that generates tic tac toe game in command line interface
class GameChecker
  # Declare the constants
  EMPTY = '-'.freeze

  def initialize
    @moves = []
    @row_s = ''
    @cols_s = ''
    @diag1 = ''
    @diag2 = ''
  end

  # Get patterns for rows, cols and diagonals to see if there is a winning pattern or not
  def get_patterns(board, index)
    board.each do |x, y|
      @row_s += y if index == x[0]
      @cols_s += y if index == x[1]
      @diag1 += y if x[0] == x[1]
      @diag2 += y if x[0] == index && x[1] == 2 - index
    end
  end

  # Method to check if any of the player has won the game or not.
  def won?(board, size, player)
    @diag2 = ''
    [*0...size].each do |index|
      @row_s = ''
      @cols_s = ''
      @diag1 = ''
      get_patterns(board, index)
      return true if [@row_s, @cols_s, @diag1].include?(player)
    end
    return true if @diag2 == player

    false
  end

  # Checks if the board has been full or not.
  def board_full?(board)
    !board.values.include?(EMPTY)
  end

  # Decides the winner of the game. Returns nil if there are none.
  def game_winner(board, size, player_o, player_x)
    if won?(board, size, player_o)
      puts 'The winner is player_O'
    elsif won?(board, size, player_x)
      puts 'The winner is player_X'
    elsif board_full?(board)
      puts 'No one is winner'
      nil
    end
  end

  # Checks if the game has ended or not
  def game_ended?(board, size, player_o, player_x)
    board_full?(board) or won?(board, size, player_o) or won?(board, size, player_x)
  end
end

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
