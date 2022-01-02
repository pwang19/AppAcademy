class Board
    attr_accessor :size

    def initialize(n)
        @grid = Array.new(n) { Array.new(n, :N) }
        @size = n * n
    end

    def [](position)
        @grid[position[0]][position[1]]
    end

    def []=(position, value)
        @grid[position[0]][position[1]] = value
    end

    def num_ships
        result = 0
        @grid.each { |row| row.each { |position| result += 1 if position == :S }}
        result
    end

    def attack(position)
        if self[position] == :S
            self[position] = :H
            p 'you sunk my battleship!'
            return true
        else
            self[position] = :X
            return false
        end
    end

    def place_random_ships
        (self.size / 4).times do
            position = []
            loop do position = [rand(Math.sqrt(self.size)), rand(Math.sqrt(self.size))] 
                break if self[position] == :N
            end
            self[position] = :S
        end
    end

    def hidden_ships_grid
        @grid.map { |row| row.map { |position| position == :S ? position = :N : position }}
    end

    def self.print_grid(grid)
        (0..grid.length-1).each do |rowIndex|
            print grid[rowIndex][0].to_s
            (1..grid.length-1).each do |colIndex| 
                print ' ' + grid[rowIndex][colIndex].to_s
                print "\n" if colIndex == grid.length-1
            end
        end
    end

    def cheat
        Board.print_grid(@grid)
    end

    def print
        Board.print_grid(hidden_ships_grid)
    end
end
