require './lib/connect4.rb'

describe Board do
    describe "#initialize" do
        it "creates a new empty game board" do
            game = Board.new
            expect(game.board).to eql(Array.new(6*7,0))
        end
    end
    describe "#get_pos" do
        it "returns nil for an empty position" do
            game = Board.new
            expect(game.get_pos(0,0)).to eql(0)
        end
    end
    describe "#put_symbol_in_column" do
        it "moves the new symbol to the lowest available space" do
            game = Board.new
            game.put_symbol_in_column("A",0)
            expect(game.get_pos(0,0)).to eql("A")
        end
    end
    describe "#board_full?" do
        it "returns false for an empty board" do
            game = Board.new
            expect(game.board_full?).to eql(false)
        end
        it "returns true for a full board" do
            game = Board.new
            7.times do |x|
                6.times do
                    game.put_symbol_in_column("A",x)
                end
            end
            expect(game.board_full?).to eql(true)
        end
    end
    describe "#row_winner" do
        it "returns nil for an empty board/row" do
            game = Board.new
            expect(game.row_winner(0)).to eql(nil)
        end
        it "returns the winning symbol for 4 in a row" do
            game = Board.new
            4.times do |col|
                game.put_symbol_in_column("A",col)
            end
            expect(game.row_winner(0)).to eql("A")
        end
        it "returns false for a row with 4 tokens but not in one line" do
            game = Board.new
            game.put_symbol_in_column("A",0)
            game.put_symbol_in_column("A",1)
            game.put_symbol_in_column("B",2)
            game.put_symbol_in_column("A",3)
            game.put_symbol_in_column("A",4)
            expect(game.row_winner(0)).to eql(nil)
        end
    end
    describe "#column_winner" do
        it "returns nil for an empty column" do
            game = Board.new
            expect(game.column_winner(0)).to eql(nil)
        end
        it "returns the winning symbol for 4 in a column" do
            game = Board.new
            4.times {game.put_symbol_in_column("A",0)}
            expect(game.column_winner(0)).to eql("A")
        end
        it "returns nil for a mixed full column" do
            game = Board.new
            3.times do
                game.put_symbol_in_column("A",0) 
                game.put_symbol_in_column("B",0)
            end
            expect(game.column_winner(0)).to eql(nil)
        end
    end
    describe "#diagonal_winner" do
        it "returns nil for an empty board" do
            game = Board.new
            expect(game.diagonal_winner).to eql(nil)
        end
        it "returns the winner for a diagonal win" do
            game = Board.new
            1.upto(4) do |col|
                col.times {game.put_symbol_in_column("A",col)}
            end
            expect(game.diagonal_winner).to eql("A")
        end
    end
end