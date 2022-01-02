class Board
    attr_reader :legal_positions

    def initialize(size)
        @board = Array.new(size) {Array.new(size, '_')}
        @legal_positions = []

        (0..size-1).each do |index1|
            (0..size-1).each do |index2|
                @legal_positions << [index1, index2]
            end
        end
    end

    def valid?(position)
        @legal_positions.index(position) != nil
    end

    def place_mark(position, mark)
        raise 'Error: Invalid move.' if !valid?(position)
        @board[position[0]][position[1]] = mark
        @legal_positions.delete([position[0],position[1]])
    end

    def print
        @board.each { |row| p row }
    end

    def win_row?(mark)
        @board.each { |row| return true if row == Array.new(row.length, mark) }
        false
    end

    def win_col?(mark)
        @board = @board.transpose
        result = win_row?(mark)
        @board = @board.transpose
        result
    end

    def win_diagonal?(mark)
        diagonal_complete?(mark) or diagonal_complete?(mark, true)
    end

    def diagonal_complete?(mark, reverse=false)
        if reverse
            (0..@board.length-1).each do |index|
                return false if @board[@board.length-index-1][index] != mark
            end
        else
            (0..@board.length-1).each do |index|
                return false if @board[index][index] != mark
            end
        end
        true
    end

    def win?(mark)
        win_row?(mark) or win_col?(mark) or win_diagonal?(mark)
    end

    def empty_positions?
        @board.each { |row| row.each { |position| return true if position == '_'}}
        false
    end

end