require 'computer_player'

describe 'computer_player' do
    let(:player) { ComputerPlayer.new(:X) }

    it "class should be defined" do
        expect(Object.const_defined?("ComputerPlayer")).to eq(true)
    end

    it 'return a random position out of the legal_positions' do
        expect([[1, 2], [0,0]].include?(player.get_position([[1, 2], [0,0]])))
    end

end