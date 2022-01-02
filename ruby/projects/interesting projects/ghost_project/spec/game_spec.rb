require 'game.rb'

describe 'Game' do
    let(:game) { Game.new({
        'Player1' => true, 
        'Player2' => true, 
        'Player3' => false
        })}
    
    # before do
    #     allow($stdout).to receive(:write)
    # end

    it 'sets all initial variable values correctly' do
        expect(game.instance_variable_get(:@players).keys.map { |player| player.name}).to eq ['Player1', 'Player2', 'Player3']
        expect(game.instance_variable_get(:@current_player).name).to eq 'Player1'
        expect(game.instance_variable_get(:@previous_player)).to eq nil
        expect(game.instance_variable_get(:@fragment)).to eq ''
        expect(game.instance_variable_get(:@dictionary).length).to eq 39081
        expect(game.instance_variable_get(:@current_possible_words).length).to eq 39081
    end

    context '#next_player!' do
        it 'advances to the next player' do
            game.next_player!
            expect(game.instance_variable_get(:@current_player).name).to eq 'Player2'
            expect(game.instance_variable_get(:@previous_player).name).to eq 'Player1'
            game.next_player!
            expect(game.instance_variable_get(:@current_player).name).to eq 'Player3'
            expect(game.instance_variable_get(:@previous_player).name).to eq 'Player2'
            game.next_player!
            expect(game.instance_variable_get(:@current_player).name).to eq 'Player1'
            expect(game.instance_variable_get(:@previous_player).name).to eq 'Player3'
        end
    end

    context '#valid_play?' do
        it 'true if the next character will allow fragment to still potentially spell a word' do
            expect(game.valid_play?('a')).to eq true
            expect(game.valid_play?('z')).to eq true
            game.instance_variable_set(:@fragment, 'ab')
            expect(game.valid_play?('a')).to eq true
        end

        it 'false if the next character will not allow fragment to potentially spell a word' do
            game.instance_variable_set(:@fragment, 'ab')
            expect(game.valid_play?('z')).to eq false
        end
    end

    context '#losses' do
        it 'spells no losses! if losses count is 0' do
            expect(game.losses(0)).to eq 'no losses!'
        end

        it 'spells more of the word GHOST the more losses the player has' do
            expect(game.losses(1)).to eq 'G'
            expect(game.losses(2)).to eq 'GH'
            expect(game.losses(3)).to eq 'GHO'
            expect(game.losses(4)).to eq 'GHOS'
            expect(game.losses(5)).to eq 'GHOST'
        end
    end

    context '#take_turn' do
        it 'updates all variables correctly after a turn is made' do
            allow(game.instance_variable_get(:@current_player)).to receive(:gets).and_return('a')
            game.take_turn(game.instance_variable_get(:@current_player))
            expect(game.instance_variable_get(:@current_player).name).to eq 'Player2'
            expect(game.instance_variable_get(:@previous_player).name).to eq 'Player1'
            expect(game.instance_variable_get(:@fragment)).to eq 'a'
            expect(game.instance_variable_get(:@dictionary).length).to eq 39081
            expect(game.instance_variable_get(:@current_possible_words).length).to eq 2390
        end
    end
end