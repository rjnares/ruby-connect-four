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
    welcome_and_instructions_message

    loop do
      board.insert(next_column_choice, PLAYER_TOKEN_1)
      break if game_over?(PLAYER_TOKEN_1)

      board.insert(next_cpu_column_choice, PLAYER_TOKEN_2)
      break if game_over?(PLAYER_TOKEN_2)
    end

    return player_win_message if winner == PLAYER_TOKEN_1
    return player_lose_message if winner == PLAYER_TOKEN_2

    tie_message
  end

  private

  attr_reader :board
  attr_accessor :winner

  def next_cpu_column_choice
    board.available_columns.sample
  end

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
