require './lib/connect4_runner.rb'

describe GameRunner do
    describe "#initialize" do
        it "sets the two players" do
            match = GameRunner.new("B","C")
            expect(match.players).to eql(["B","C"])
        end
        it "sets the active player to the first player" do
            match = GameRunner.new("B","C")
            expect(match.activeplayer).to eql("B")
        end
    end
end