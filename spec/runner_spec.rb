require './lib/connect4_runner.rb'

describe GameRunner do
    describe "#initialize" do
        before(:each) do
            @match = GameRunner.new("B","C")
        end
        it "sets the two players" do
            expect(@match.players).to eql(["B","C"])
        end
        it "sets the active player to the first player" do
            expect(@match.activeplayer).to eql("B")
        end
    end
end