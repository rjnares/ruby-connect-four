# frozen_string_literal: true

# Module for game input/output
module GameIO
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
