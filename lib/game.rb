# frozen_string_literal: true

require 'colorize'
require_relative 'game_io'
require_relative 'board'

# Class for connect four gameplay
class Game
  include GameIO

  PLAYER_TOKEN_1 = "\u25CF".encode('UTF-8').colorize(color: :blue)
  PLAYER_TOKEN_2 = "\u25CF".encode('UTF-8').colorize(color: :red)

  def initialize(board = Board.new)
    @board = board
    @winner = nil
  end

  def play
    board.insert(0, PLAYER_TOKEN_1)
    board.insert(0, PLAYER_TOKEN_2)
    board.insert(1, PLAYER_TOKEN_2)
    board.insert(1, PLAYER_TOKEN_1)
    board.insert(2, PLAYER_TOKEN_1)
    board.insert(2, PLAYER_TOKEN_1)
    board.insert(6, PLAYER_TOKEN_2)
    board.insert(6, PLAYER_TOKEN_2)
    next_column_choice
  end

  private

  attr_reader :board
  attr_accessor :winner

  def game_over?(token)
    if board.win?(token)
      self.winner = token
      return true
    elsif board.full?
      return true
    end

    false
  end

  def string_to_int(string)
    Integer(string || '', 10)
  rescue ArgumentError
    nil
  end
end
