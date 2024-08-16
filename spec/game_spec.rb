# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  let(:board) { double('board') }
  subject(:game) { described_class.new(board) }

  describe '#initialize' do
    context 'when invoked with a board instance' do
      it 'sets the board instance variable to that instance' do
        actual = game.instance_variable_get(:@board)
        expect(actual).to eq(board)
      end
    end

    context 'when invoked without a board instance' do
      subject(:game_with_no_board_instance) { described_class.new }

      it 'sets the board instance variable to a new instance' do
        actual = game_with_no_board_instance.instance_variable_get(:@board)
        expect(actual).not_to eq(board)
      end
    end
  end
end
