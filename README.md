# Connect Four

This is my implementation of the [Connect Four](https://www.theodinproject.com/lessons/ruby-connect-four) project assigned in the [Testing Ruby With RSpec](https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby#testing-ruby-with-rspec) section of the [Ruby Course](https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby) which is part of the [Full Stack Ruby on Rails](https://www.theodinproject.com/paths/full-stack-ruby-on-rails) curriculum from the [The Odin Project](https://www.theodinproject.com).

## Project Description

This simple Ruby application is a connect four game played on the console by running `bundle exec ruby main.rb`. The game revolves around the Player and CPU taking turns placing tokens into the `6 x 7` connect four grid. Every turn, the Player inputs their next move on the console by entering an integer between `0` and `6` which represents a column index on the connect four grid. The CPU behavior is to choose a random, non-filled column to insert its next token.

A winner is declared when either the Player or CPU connect four tokens vertically, horizontally, or diagonally. However, if all the spaces in the connect four grid are filled before a winner is declared, then the game ends in a tie.

## Skills Applied

The main goal of this project was to apply Test-Driven Development using RSpec as taught in the [Testing Ruby With RSpec](https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby#testing-ruby-with-rspec) section of the [Ruby Course](https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby). In this project, I accomplished this goal in the following manner:
* Creating a `Board` class for managing game board state
* Creating a `GameIO` module for game input/output operations
* Creating a `Game` class for managing the game play sequence
* Creating unit tests for the `Board` class in the `spec/board_spec.rb` file
* Creating unit tests for the `GameIO` module and `Game` class in the `spec/game_spec.rb` file
