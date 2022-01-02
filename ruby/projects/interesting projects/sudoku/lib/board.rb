require_relative 'tile.rb'
require 'set'

class Board
    def initialize(grid = nil)
        @grid = grid || Array.new(9) {Array.new(9, Tile.new(0, false))}
    end

    def self.from_file(filename)
        return nil if filename == nil
        puzzle = File.read(filename).split
        grid = Array.new(9) {Array.new(9, nil)}
        (0..8).each do |row|
            (0..8).each do |col|
                input = puzzle[row][col]
                if input != '0'
                    grid[row][col] = Tile.new(input.to_i, true)
                else
                    grid[row][col] = Tile.new(0, false)
                end
            end
        end
        grid
    end

    def update_value(position, value)
        @grid[position[0]][position[1]].update_value(value)
    end

    def render
        print "------------\n"
        separator = 0
        @grid.each do |row|
            row.each do |element|
                separator += 1
                if element.to_s == 0
                    print ' '
                else
                    print element.to_s
                end
                if separator % 3 == 0
                    print '|'
                end
            end
            print "\n"
            if separator % 27 == 0
                print "------------\n"
            end
        end
        solved?
    end

    def solved?
        complete = Set[1,2,3,4,5,6,7,8,9]
        @grid.each do |row|
            return false if row.map(&:to_s).to_set != complete
        end
        @grid.transpose.each do |row|
            return false if row.map(&:to_s).to_set != complete
        end

        return false if box_solved? == false

        true
    end

    def box_solved?
        # not the most DRY code, but it works...
        complete = Set[1,2,3,4,5,6,7,8,9]

        return false if (@grid[0][0..2] | @grid[1][0..2] | @grid[2][0..2]).map(&:to_s).to_set != complete
        return false if (@grid[0][3..5] | @grid[1][3..5] | @grid[2][3..5]).map(&:to_s).to_set != complete
        return false if (@grid[0][6..8] | @grid[1][6..8] | @grid[2][6..8]).map(&:to_s).to_set != complete

        return false if (@grid[3][0..2] | @grid[4][0..2] | @grid[5][0..2]).map(&:to_s).to_set != complete
        return false if (@grid[3][3..5] | @grid[4][3..5] | @grid[5][3..5]).map(&:to_s).to_set != complete
        return false if (@grid[3][6..8] | @grid[4][6..8] | @grid[5][6..8]).map(&:to_s).to_set != complete

        return false if (@grid[6][0..2] | @grid[7][0..2] | @grid[8][0..2]).map(&:to_s).to_set != complete
        return false if (@grid[6][3..5] | @grid[7][3..5] | @grid[8][3..5]).map(&:to_s).to_set != complete
        return false if (@grid[6][6..8] | @grid[7][6..8] | @grid[8][6..8]).map(&:to_s).to_set != complete

        true
    end

end