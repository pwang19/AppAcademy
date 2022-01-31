require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    return true if board.winner != evaluator and !board.winner.nil?
    return false if board.winner.nil?
  end

  def winning_node?(evaluator)
    return true if board.winner == evaluator
    children.all? { |child| child.winning_node?(evaluator) } if !children.length.zero?
  end

  def other_player
    next_mover_mark == :x ? :o : :x
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    result = []
    (0..board.rows.length - 1).each do |row|
      (0..board.rows.length - 1).each do |col|
        if board.empty?([row, col])
          child_board = board.dup
          child_board[[row,col]] = other_player
          result << TicTacToeNode.new(child_board, other_player, [row,col])
        end
      end
    end
    result
  end
end
