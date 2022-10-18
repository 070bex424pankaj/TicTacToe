# Script to play tic tac toe game in the command line interface
# frozen_string_literal: false

require_relative 'board_initializer'
require_relative 'move_placer'
require_relative 'game_checker'

# Class to initialize objects of all the classes and run the methods sequentially to run tictactoe
class TicTacToeMain
  def initialize
    @size = nil
    @player_o = 'O'
    @player_x = 'X'
    @player = 'player_O'
    @board = {}

    input_size
    initialize_winning_pattern

    @board_initializer = BoardInitializer.new(@size)
    @move_placer = MovePlacer.new(@size)
    @game_checker = GameChecker.new(@size, @player_o, @player_x)
  end

  # Get the size for tictactoe
  def input_size
    input_size_flag = true
    while input_size_flag
      puts 'Enter the size for tictactoe(3<=size<=6)'
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
    @board = @board_initializer.init_board(@board)
    @board_initializer.print_board(@board)
    if game.nil?
      puts "#{@player} lost the game due to timeout error!"
      return nil
    end

    @game_checker.game_winner(@board)
  end

  # Method to check and place move
  def check_and_place_move(index)
    if @move_placer.valid_move?(index) && @move_placer.repeated_moves?(index)
      @board, @player = @move_placer.place_move(@board, @player, index)
      @board_initializer.print_board(@board)
    else
      puts 'Enter a valid move from the matrix'
    end
  end

  # Method to check if game has ended or not
  def game
    until @game_checker.game_ended?(@board)
      index = @move_placer.get_user_input(@player)
      return nil if index.nil?

      check_and_place_move(index)
    end
    true
  end
end

# Initialize an object of TicTacToe class
t_t_t = TicTacToeMain.new
puts 'Game ended' if t_t_t.main.nil?

#after reset