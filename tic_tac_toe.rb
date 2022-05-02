# Script to play tic tac toe game in the command line interface

require "timeout"


class TicTacToe

    # Declare the constants
    MOVE_TIMEOUT = 20
    EMPTY = '-'
    PLAYER_O = 'OOO'
    PLAYER_X = 'XXX'
    INDEX_ARRAY = [[0,0],[0,1],[0,2],[1,0],[1,1],[1,2],[2,0],[2,1],[2,2]]

    def initialize
        @moves = []
        @board = {}
    end

    # Initializes the game board.
    def init_board(n)
        for x in 0...n
            for y in 0...n
                @board[[x, y]] = EMPTY
            end
        end
    end

    # Prints the game board in the matrix format
    def print_board
        @board.each do |x,y|
            if x[0] != 0 and x[1] == 0 then print "\n\t\t\t..................\n" end
            if x[1] == 0 then print "\t\t\t" end
            if y == '-' then print " #{x[0]},#{x[1]} |" else print "  #{y}  |" end
        end
        print("\n")

    end

    # Method to check if any of the player has won the game or not.
    def has_won(size, player)
        diag_2 = ''
        for i in 0...size
            row_s = ''
            cols_s = ''
            diag_1 = ''
            @board.each do |x,y|
                if i == x[0] then row_s += y end
                if i == x[1] then cols_s += y end
                if x[0] == x[1] then diag_1 += y end
                if x[0] == i and x[1] == 2-i then diag_2 += y end
            end           
            if row_s == player or cols_s == player or diag_1 == player then return true end
        end
        if diag_2 == player then return true end
        return false    
    end

    # Checks if the board has been full or not.
    def board_full
        !@board.values.include?(EMPTY)     
    end

    # Decides the winner of the game. Returns nil if there are none.
    def game_winner(size, player_O, player_X)
        if has_won(size, player_O)
            return 'player_O'
        elsif has_won(size, player_X)
            return 'player_X'
        elsif board_full
            return nil
        end
    end

    # Checks if the game has ended or not
    def game_ended(size, player_O, player_X)
        board_full or has_won(size, player_O) or has_won(size, player_X)
    end

    # Gets the user input. User must enter a move in a specified time ie. 20.
    def get_user_input(player)
        puts "Enter a #{player} move (use comma separated coordinates shown in matrix!!). You have 20 seconds."
        user_input = nil
        begin
            Timeout::timeout MOVE_TIMEOUT do
              user_input = gets.chomp
            end
        rescue Timeout::Error
            puts "Player #{player} lost the game due to timeout error!!!"
            return nil
        end
        u,v = user_input.split(',')
        index = [u.to_i, v.to_i]
        return index
    end

    # Checks if the move entered is valid or not.
    def valid_move(index)
        if INDEX_ARRAY.include?(index)
            return true
        else
            return false
        end
    end

    # Checks if there are repeated moves or not.
    def repeated_moves(index)
        if @moves.include?(index)
            puts "Repeated moves!!!!!!"
            return false
        else
            @moves << index
            return true
        end
    end

    # Method to place a move in the board after user has entered the move.
    def place_move(player, index)
        @board[index] = player == 'player_O' ? "O" : "X"
    end

    #Entry method
    def game
        print "\n"
        size = 3
        init_board(size)
        print_board
        player = "player_O"

        while !game_ended(size, PLAYER_O, PLAYER_X)
            index = get_user_input(player)

            if index.nil?
                return nil
            end

            if valid_move(index) and repeated_moves(index)
                place_move(player, index)
                player = player == 'player_O' ? "player_X" : "player_O"
                print_board
            else
                puts "Enter a valid move from the matrix"
            end
        end

        winner = game_winner(size, PLAYER_O, PLAYER_X)
        if winner.nil?
            puts "The game has ended. No one is the winner"
        else
            puts "The winner is #{winner}"
        end
    return true
    end
    
end

# Initialize an object of TicTacToe class
t_t_t = TicTacToe.new
puts "Game ended" if t_t_t.game.nil?
