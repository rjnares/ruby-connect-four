# frozen_string_literal: true

require_relative 'game_io'

# Class for connect four gameplay
class Game
  include GameIO

  def initialize(board = Board.new)
    @board = board
  end

  private

  attr_reader :board

  def string_to_int(string)
    Integer(string || '', 10)
  rescue ArgumentError
    nil
  end
end
