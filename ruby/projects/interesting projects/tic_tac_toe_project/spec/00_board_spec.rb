require 'board'

describe 'Board' do
    let(:board) { Board.new(3) }
    let(:board4) { Board.new(4) }

    it "class should be defined" do
        expect(Object.const_defined?("Board")).to eq(true)
    end

    it "@board should be of the initiating dimensions" do
        expect(board.instance_variable_get(:@board).length).to eq(3)
        expect(board.instance_variable_get(:@board)[0].length).to eq(3)
        expect(board4.instance_variable_get(:@board).length).to eq(4)
        expect(board4.instance_variable_get(:@board)[0].length).to eq(4)
    end

    it '@legal_positions should be populated by default with all positions' do
        expect(board.instance_variable_get(:@legal_positions).length).to eq(9)
        expect(board4.instance_variable_get(:@legal_positions).length).to eq(16)
    end

    it '@legal_positions should not include a position that has a mark on it' do
        board.place_mark([1,0], :O)
        expect(board.instance_variable_get(:@legal_positions).index([1,0])).to eq(nil)
    end

    context 'valid?' do
        it 'should return true if within range of board' do
            expect(board.valid?([0,0])).to eq(true)
            expect(board.valid?([1,1])).to eq(true)
            expect(board.valid?([2,2])).to eq(true)

            expect(board4.valid?([3,3])).to eq(true)
        end

        it 'should return false if outside of range of board' do
            expect(board.valid?([-1,0])).to eq(false)
            expect(board.valid?([-1,-1])).to eq(false)
            expect(board.valid?([0,-1])).to eq(false)
            expect(board.valid?([3,0])).to eq(false)
            expect(board.valid?([0,3])).to eq(false)
            expect(board.valid?([3,3])).to eq(false)

            expect(board4.valid?([4,0])).to eq(false)
            expect(board4.valid?([0,4])).to eq(false)
            expect(board4.valid?([4,4])).to eq(false)
        end
    end

    context 'place_mark' do
        it 'should raise an error if the position is outside of board bounds' do
            expect{board.place_mark([-1,0], :X)}.to raise_error 'Error: Invalid move.'
            expect{board.place_mark([0,-1], :X)}.to raise_error 'Error: Invalid move.'
            expect{board.place_mark([-1,-1], :X)}.to raise_error 'Error: Invalid move.'
        end

        it 'should raise an error if the position is occupied' do
            board.place_mark([0,0], :X)
            expect{board.place_mark([0,0], :O)}.to raise_error 'Error: Invalid move.'
        end
    end

    context 'print' do
        it 'should print out the current state of the board' do
            expect{board.print}.to output("[\"_\", \"_\", \"_\"]\n[\"_\", \"_\", \"_\"]\n[\"_\", \"_\", \"_\"]\n").to_stdout
            expect{board4.print}.to output("[\"_\", \"_\", \"_\", \"_\"]\n[\"_\", \"_\", \"_\", \"_\"]\n[\"_\", \"_\", \"_\", \"_\"]\n[\"_\", \"_\", \"_\", \"_\"]\n").to_stdout
        end
    end

    context 'win_row?' do
        it 'should be true if 1st row is filled with the mark' do
            board.place_mark([0,0], :X)
            board.place_mark([0,1], :X)
            board.place_mark([0,2], :X)
            expect(board.win_row?(:X)).to eq(true)

            board4.place_mark([0,0], :X)
            board4.place_mark([0,1], :X)
            board4.place_mark([0,2], :X)
            board4.place_mark([0,3], :X)
            expect(board4.win_row?(:X)).to eq(true)
        end

        it 'should be true if 2nd row is filled with the mark' do
            board.place_mark([1,0], :X)
            board.place_mark([1,1], :X)
            board.place_mark([1,2], :X)
            expect(board.win_row?(:X)).to eq(true)

            board4.place_mark([1,0], :X)
            board4.place_mark([1,1], :X)
            board4.place_mark([1,2], :X)
            board4.place_mark([1,3], :X)
            expect(board4.win_row?(:X)).to eq(true)
        end

        it 'should be true if 3rd row is filled with the mark' do
            board.place_mark([2,0], :X)
            board.place_mark([2,1], :X)
            board.place_mark([2,2], :X)
            expect(board.win_row?(:X)).to eq(true)

            board4.place_mark([2,0], :X)
            board4.place_mark([2,1], :X)
            board4.place_mark([2,2], :X)
            board4.place_mark([2,3], :X)
            expect(board4.win_row?(:X)).to eq(true)
        end

        it 'should be false if none of the rows are filled with the mark' do
            board.place_mark([0,0], :X)
            board.place_mark([0,1], :X)
            board.place_mark([1,0], :X)
            board.place_mark([1,1], :X)
            board.place_mark([2,0], :X)
            board.place_mark([2,1], :X)
            expect(board.win_row?(:X)).to eq(false)
        end

        it 'should be false if any row is filled with a different mark' do
            board.place_mark([0,0], :X)
            board.place_mark([0,1], :X)
            board.place_mark([0,2], :X)
            expect(board.win_row?(:O)).to eq(false)
        end
    end

    context 'win_col?' do
        it 'should be true if 1st column is filled with the mark' do
            board.place_mark([0,0], :X)
            board.place_mark([1,0], :X)
            board.place_mark([2,0], :X)
            expect(board.win_col?(:X)).to eq(true)
        end

        it 'should be true if 2nd column is filled with the mark' do
            board.place_mark([0,1], :X)
            board.place_mark([1,1], :X)
            board.place_mark([2,1], :X)
            expect(board.win_col?(:X)).to eq(true)
        end

        it 'should be true if 3rd column is filled with the mark' do
            board.place_mark([0,2], :X)
            board.place_mark([1,2], :X)
            board.place_mark([2,2], :X)
            expect(board.win_col?(:X)).to eq(true)
        end

        it 'should be false if none of the columns are filled with the mark' do
            board.place_mark([0,0], :X)
            board.place_mark([1,0], :X)
            board.place_mark([0,1], :X)
            board.place_mark([1,1], :X)
            board.place_mark([0,2], :X)
            board.place_mark([1,2], :X)
            expect(board.win_col?(:X)).to eq(false)
        end

        it 'should be false if any column is filled with a different mark' do
            board.place_mark([0,0], :X)
            board.place_mark([1,0], :X)
            board.place_mark([2,0], :X)
            expect(board.win_col?(:O)).to eq(false)
        end
    end

    context 'win_diagonal?' do
        it 'should be true if the mark wins the first diagonal' do
            board.place_mark([0,0], :X)
            board.place_mark([1,1], :X)
            board.place_mark([2,2], :X)
            expect(board.win_diagonal?(:X)).to eq(true)
        end

        it 'should be true if the mark wins the other diagonal' do
            board.place_mark([2,0], :X)
            board.place_mark([1,1], :X)
            board.place_mark([0,2], :X)
            expect(board.win_diagonal?(:X)).to eq(true)
        end

        it 'should be false if a different mark wins the first diagonal' do
            board.place_mark([0,0], :X)
            board.place_mark([1,1], :X)
            board.place_mark([2,2], :X)
            expect(board.win_diagonal?(:O)).to eq(false)
        end
    end

    context 'win?' do
        it 'should be true if 1st row is filled with the mark' do
            board.place_mark([0,0], :X)
            board.place_mark([0,1], :X)
            board.place_mark([0,2], :X)
            expect(board.win?(:X)).to eq(true)
        end

        it 'should be true if 2nd row is filled with the mark' do
            board.place_mark([1,0], :X)
            board.place_mark([1,1], :X)
            board.place_mark([1,2], :X)
            expect(board.win?(:X)).to eq(true)
        end

        it 'should be true if 3rd row is filled with the mark' do
            board.place_mark([2,0], :X)
            board.place_mark([2,1], :X)
            board.place_mark([2,2], :X)
            expect(board.win?(:X)).to eq(true)
        end

        it 'should be false if any row is filled with a different mark' do
            board.place_mark([0,0], :X)
            board.place_mark([0,1], :X)
            board.place_mark([0,2], :X)
            expect(board.win?(:O)).to eq(false)
        end

        it 'should be true if 1st column is filled with the mark' do
            board.place_mark([0,0], :X)
            board.place_mark([1,0], :X)
            board.place_mark([2,0], :X)
            expect(board.win?(:X)).to eq(true)
        end

        it 'should be true if 2nd column is filled with the mark' do
            board.place_mark([0,1], :X)
            board.place_mark([1,1], :X)
            board.place_mark([2,1], :X)
            expect(board.win?(:X)).to eq(true)
        end

        it 'should be true if 3rd column is filled with the mark' do
            board.place_mark([0,2], :X)
            board.place_mark([1,2], :X)
            board.place_mark([2,2], :X)
            expect(board.win?(:X)).to eq(true)
        end

        it 'should be false if any column is filled with a different mark' do
            board.place_mark([0,0], :X)
            board.place_mark([1,0], :X)
            board.place_mark([2,0], :X)
            expect(board.win?(:O)).to eq(false)
        end

        it 'should be true if the mark wins the first diagonal' do
            board.place_mark([0,0], :X)
            board.place_mark([1,1], :X)
            board.place_mark([2,2], :X)
            expect(board.win?(:X)).to eq(true)
        end

        it 'should be true if the mark wins the other diagonal' do
            board.place_mark([2,0], :X)
            board.place_mark([1,1], :X)
            board.place_mark([0,2], :X)
            expect(board.win?(:X)).to eq(true)
        end

        it 'should be false if a different mark wins the first diagonal' do
            board.place_mark([0,0], :X)
            board.place_mark([1,1], :X)
            board.place_mark([2,2], :X)
            expect(board.win?(:O)).to eq(false)
        end
    end

    context 'empty_positions?' do
        it 'should be true if all positions are empty' do
            expect(board.empty_positions?).to eq(true)
        end

        it 'should be true if only 1 position is empty' do
            board.place_mark([0,0], :X)
            board.place_mark([0,1], :X)
            board.place_mark([0,2], :X)
            board.place_mark([1,0], :X)
            board.place_mark([1,1], :X)
            board.place_mark([1,2], :X)
            board.place_mark([2,0], :X)
            board.place_mark([2,1], :X)
            expect(board.empty_positions?).to eq(true)
        end

        it 'should be false if all positions are filled' do
            board.place_mark([0,0], :X)
            board.place_mark([0,1], :X)
            board.place_mark([0,2], :X)
            board.place_mark([1,0], :X)
            board.place_mark([1,1], :X)
            board.place_mark([1,2], :X)
            board.place_mark([2,0], :X)
            board.place_mark([2,1], :X)
            board.place_mark([2,2], :X)
            expect(board.empty_positions?).to eq(false)
        end
    end
end