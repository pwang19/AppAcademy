require 'human_player'

describe 'human_player' do
    let(:player) { HumanPlayer.new(:X) }

    it "class should be defined" do
        expect(Object.const_defined?("HumanPlayer")).to eq(true)
    end

    it 'asks for the player for an input' do
        allow(player).to receive(:gets).and_return('1 2')
        expect(player.get_position([[1, 2]])).to eq([1, 2])
    end

end