# frozen_string_literal: true

# Module for game input/output
module GameIO
  def next_column_choice
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
    print "Choose a column between 0 and #{board.WIDTH - 1} to drop your token into: "
  end

  def invalid_column_message
    puts <<~HEREDOC

      Full or invalid column entered, please try again...
    HEREDOC
  end
end
