# frozen_string_literal: true

# Module for game input/output
module GameIO
  def welcome_and_instructions_message
    puts <<~HEREDOC

      Welcome to my Connect Four Game built with Ruby!

      The rules are simple. Both players take turns dropping tokens into the
      6x7 grid until one of them wins by connecting four horizontally,
      vertically, or diagonally. If all spaces are filled before either
      player connects four tokens, then the game will end in a tie.

      This game will be played against the CPU, good luck!

      Your token: #{Game::PLAYER_TOKEN_1}
       CPU token: #{Game::PLAYER_TOKEN_2}
    HEREDOC
  end

  def next_column_choice
    current_game_state_message
    loop do
      board.draw
      choose_column_message
      column = string_to_int(gets&.chomp)
      return column if board.valid_column?(column)

      invalid_column_message
    end
  end

  def choose_column_message
    puts
    print "Choose a column between 0 and #{Board::WIDTH - 1} to drop your token into: "
  end

  def invalid_column_message
    puts <<~HEREDOC

      Full or invalid column entered, please try again...
    HEREDOC
  end

  def current_game_state_message
    puts <<~HEREDOC

      Current game state
    HEREDOC
  end
end
