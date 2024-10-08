# frozen_string_literal: true

# Class for connect four game board
class Board
  WIDTH = 7
  HEIGHT = 6
  EMPTY_TOKEN = "\u25CC".encode('UTF-8')

  def initialize
    @board = Array.new(WIDTH) { Array.new(HEIGHT) }
  end

  # Returns false if column index is invalid or column is full, true otherwise
  def insert(column_index, token)
    row_index = board[column_index]&.index(nil)

    return false unless row_index

    board[column_index][row_index] = token
    true
  end

  def full?
    board.flatten.count(nil).zero?
  end

  def win?(token)
    win_vertically?(token) || win_horizontally?(token) || win_diagonally?(token)
  end

  def draw
    print_token_rows
    print_columns_row
  end

  def valid_column?(column)
    return false unless (0...WIDTH).include?(column)

    board[column].count(nil).positive?
  end

  def available_columns
    board.each_with_object([]).with_index do |(column, columns), index|
      columns << index if column.count(nil).positive?
    end
  end

  private

  attr_reader :board

  def win_vertically?(token)
    search_string = token * 4
    board.any? do |column|
      column.map { |t| t.nil? ? ' ' : t }.join.include?(search_string)
    end
  end

  def win_horizontally?(token)
    search_string = token * 4

    HEIGHT.times do |row_index|
      row = board.each_with_object([]) { |column, array| array << column[row_index] }
      return true if row.map { |t| t.nil? ? ' ' : t }.join.include?(search_string)
    end

    false
  end

  def win_diagonally?(token)
    search_string = token * 4
    win_diagonally_top_left_to_bottom_right?(0, HEIGHT - 1, search_string) ||
      win_diagonally_bottom_left_to_top_right?(0, 0, search_string)
  end

  def diagonals(column_index, row_index, top_left_to_bottom_right: true)
    diagonals = []

    while in_range?(column_index, row_index)
      diagonals << (board[column_index][row_index] || ' ')
      column_index += 1
      row_index += (top_left_to_bottom_right ? -1 : 1)
    end

    diagonals
  end

  def win_diagonally_top_left_to_bottom_right?(column_index, row_index, search_string)
    return false unless in_range?(column_index, row_index)

    return true if diagonals(column_index, row_index).join.include?(search_string)

    win_diagonally_top_left_to_bottom_right?(column_index, row_index - 1, search_string) ||
      win_diagonally_top_left_to_bottom_right?(column_index + 1, row_index, search_string)
  end

  def win_diagonally_bottom_left_to_top_right?(column_index, row_index, search_string)
    return false unless in_range?(column_index, row_index)

    return true if diagonals(column_index, row_index, top_left_to_bottom_right: false).join.include?(search_string)

    win_diagonally_bottom_left_to_top_right?(column_index, row_index + 1, search_string) ||
      win_diagonally_bottom_left_to_top_right?(column_index + 1, row_index, search_string)
  end

  def in_range?(column_index, row_index)
    column_index_in_range = (0...WIDTH).include?(column_index)
    row_index_in_range = (0...HEIGHT).include?(row_index)
    column_index_in_range && row_index_in_range
  end

  def print_token_rows
    puts
    (HEIGHT - 1).downto(0) do |row_index|
      0.upto(WIDTH - 1) do |column_index|
        token = board[column_index][row_index]
        print " #{token.nil? ? EMPTY_TOKEN : token} "
      end
      puts
    end
  end

  def print_columns_row
    puts
    0.upto(WIDTH - 1) { |column_index| print " #{column_index} " }
    puts
  end
end
