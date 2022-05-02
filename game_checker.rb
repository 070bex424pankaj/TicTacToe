# frozen_string_literal: false

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
  def get_patterns(board, size, index)
    board.each do |x, y|
      @row_s += y if index == x[0]
      @cols_s += y if index == x[1]
      @diag1 += y if x[0] == x[1]
      @diag2 += y if x[0] == index && x[1] == size - 1 - index
    end
  end

  # Method to check if any of the player has won the game or not.
  def won?(board, size, player)
    @diag2 = ''
    [*0...size].each do |index|
      @row_s = ''
      @cols_s = ''
      @diag1 = ''
      get_patterns(board, size, index)
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
