require 'ai_player.rb'
require 'set'

describe 'AIPlayer' do
    let(:aiplayer) { AIPlayer.new('AI', 2)}

    it 'initializes variables correctly' do
        expect(aiplayer.name).to eq 'AI'
        expect(aiplayer.instance_variable_get(:@num_players)).to eq 2
    end

    context 'guess' do
        it 'should select the character from longest word out of the current list' do
            expect(aiplayer.guess('b', Set['bat', 'bar', 'ball', 'basketball', 'barf'])).to eq 'a'
            expect(aiplayer.guess('ba', Set['bat', 'bar', 'ball', 'basketball', 'barf'])).to eq 'l'
        end
    end
end