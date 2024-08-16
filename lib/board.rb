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

  def win?(token)
    win_vertically?(token) || win_horizontally?(token) || win_diagonally?(token)
  end

  def valid_column?(column)
    return false unless (0...WIDTH).include?(column)

    board[column].count(nil).positive?
  end

  private

  attr_reader :board

  def win_vertically?(token)
    search_string = token * 4
    board.any? { |column| column.join.include?(search_string) }
  end

  def win_horizontally?(token)
    search_string = token * 4

    HEIGHT.times do |row_index|
      row = board.each_with_object([]) { |column, array| array << column[row_index] }
      return true if row.join.include?(search_string)
    end

    false
  end

  def win_diagonally?(token)
    search_string = token * 4
    win_diagonally_top_left_to_bottom_right?(0, HEIGHT - 1, search_string) ||
      win_diagonally_bottom_left_to_top_right?(0, 0, search_string)
  end

  def win_diagonally_top_left_to_bottom_right?(column_index, row_index, search_string)
    return false unless in_range?(column_index, row_index)

    c = column_index
    r = row_index
    diagonals = []

    while in_range?(c, r)
      diagonals << board[c, r]
      c += 1
      r -= 1
    end

    return true if diagonals.join.include?(search_string)

    win_diagonally_top_left_to_bottom_right?(column_index, row_index - 1, search_string) ||
      win_diagonally_top_left_to_bottom_right?(column_index + 1, row_index, search_string)
  end

  def win_diagonally_bottom_left_to_top_right?(column_index, row_index, search_string)
    return false unless in_range?(column_index, row_index)

    c = column_index
    r = row_index
    diagonals = []

    while in_range?(c, r)
      diagonals << board[c][r]
      c += 1
      r += 1
    end

    return true if diagonals.join.include?(search_string)

    win_diagonally_bottom_left_to_top_right?(column_index, row_index + 1, search_string) ||
      win_diagonally_bottom_left_to_top_right?(column_index + 1, row_index, search_string)
  end

  def in_range?(column_index, row_index)
    column_index_in_range = (0...WIDTH).include?(column_index)
    row_index_in_range = (0...HEIGHT).include?(row_index)
    column_index_in_range && row_index_in_range
  end
end
