require_relative '00_tree_node.rb'

class KnightPathFinder
    attr_reader :considered_positions

    def initialize(start_pos)
        @root_node = PolyTreeNode.new(start_pos)
        @considered_positions = [start_pos]
    end

    def build_move_tree
        queue = [@root_node]
        until queue.empty?
            node = queue.shift
            new_move_positions(node.value).each do |position|
                node.add_child(PolyTreeNode.new(position))
            end
            queue.append(*node.children)
        end
        @root_node
    end

    def self.valid_moves(pos)
        move = [1, 2]
        moves = [move.dup, move.reverse]
        (0..2).each do |index|
            move[index % 2] = -move[index % 2]
            moves.append(move.dup, move.reverse)
        end
        moves.map do |move|
            move[0] += pos[0]
            move[1] += pos[1]
        end
        moves.filter do |move|
            move[0].between?(0, 7) and move[1].between?(0, 7)
        end
    end

    def new_move_positions(pos)
        moves = self.class.valid_moves(pos).filter do |position|
            !@considered_positions.include? position
        end
        @considered_positions += moves
        moves
    end

    def find_path(pos)
        node = @root_node.bfs(pos)
        trace_path_back(node)
    end

    def trace_path_back(node)
        path = []
        while !node.nil? and !node.value.nil?
            path.unshift(node.value)
            node = node.parent
        end
        path
    end
end