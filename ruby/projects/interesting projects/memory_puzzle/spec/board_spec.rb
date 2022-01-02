require 'board.rb'

describe 'board' do
    let(:board) { Board.new(5, 4) }
    let(:board_large) { Board.new(10,10)}

    it 'has the correct initial variables' do
        expect(board.instance_variable_get(:@board).length).to eq(4)
        expect(board.instance_variable_get(:@board)[0].length).to eq(5)
        expect(board.instance_variable_get(:@size)).to eq(20)

        expect(board_large.instance_variable_get(:@board).length).to eq(10)
        expect(board_large.instance_variable_get(:@board)[0].length).to eq(10)
        expect(board_large.instance_variable_get(:@size)).to eq(100)
    end

    context '#generate_card_values' do
        it 'generates only enough card values for the board' do
            expect(board.generate_card_values.length).to eq(20)
            expect(board.generate_card_values.index('J')).to eq(9)
            expect(board.generate_card_values.index('K')).to eq(nil)

            expect(board_large.generate_card_values.length).to eq(100)
            expect(board_large.generate_card_values.index('BX')).to eq(49)
            expect(board_large.generate_card_values.index('BY')).to eq(nil)
        end
    end

    context '#won?' do
        it 'true if all cards are flipped up' do
            board.populate
            (0..3).each do |row|
                (0..4).each do |col|
                    board.reveal([row, col])
                end
            end
            expect(board.won?).to eq(true)
        end

        it 'false if not all cards are flipped up' do
            board.populate
            board.reveal([0,0])
            expect(board.won?).to eq(false)
        end
    end
end
