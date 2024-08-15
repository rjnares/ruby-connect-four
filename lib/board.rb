# frozen_string_literal: true

# Class for connect four game board
class Board
  WIDTH = 7
  HEIGHT = 6

  def initialize
    @board = Array.new(WIDTH) { Array.new(HEIGHT) }
  end

  # Returns false if column index is invalid or column is full, true otherwise
  def insert(column_index, token)
    row_index = board[column_index]&.index(nil)

    if row_index
      board[column_index][row_index] = token
      return true
    end

    false
  end

  private

  attr_reader :board
end
