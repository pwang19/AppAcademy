require 'player.rb'

describe 'player' do
    let(:player) { Player.new('Player1')}

    it 'get attribute of name' do
        expect(player.name).to eq 'Player1'
    end

    context 'guess' do
        it 'asks for an input ' do
            allow(player).to receive(:gets).and_return('a')
            expect(player.guess).to eq 'a'
        end
    end

    context 'alert_invalid_guess' do
        it 'asks for an input ' do
            allow(player).to receive(:gets).and_return('a')
            expect(player.alert_invalid_guess).to eq 'a'
        end
    end
end