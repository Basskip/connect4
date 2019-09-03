require_relative 'connect4.rb'

class GameRunner
    attr_reader :players
    def initialize(player1 = "A", player2 = "B")
        @board = Board.new
        @players = [player1, player2]
        @activeplayer = 0
    end

    def start
        puts "Welcome to connect 4"
        until @board.board_full? || @board.winner
            puts "Player #{@players[@activeplayer]}  select your move"
            @board.put_symbol_in_column(@players[@activeplayer], get_move.to_i)
            print @board.get_printable_board
            puts "Game Over, it's a draw" if @board.board_full?
            puts "Player #{@players[@activeplayer]} wins!" if @board.winner
            @activeplayer = (@activeplayer == 0 ? 1 : 0)
        end
    end

    def activeplayer
        @players[@activeplayer]
    end

    def get_move
        move = gets.chomp
        until move.match?(/[0-6]/) do
            print "Invalid move, try again:"
            move = gets.chomp
        end
        move
    end
end