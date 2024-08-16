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

  describe '#next_column_choice' do
    before do
      allow(board).to receive(:draw)
      allow(game).to receive(:choose_column_message)
      allow(game).to receive(:string_to_int)
      allow(game).to receive(:gets)
      allow(game).to receive(:invalid_column_message)
    end

    context 'when user input is invalid once' do
      before do
        allow(board).to receive(:valid_column?).and_return(false, true)
      end

      it 'invokes Board#draw twice' do
        expect(board).to receive(:draw).twice
        game.next_column_choice
      end

      it 'invokes #choose_column_message twice' do
        expect(game).to receive(:choose_column_message).twice
        game.next_column_choice
      end

      it 'invokes #string_to_int twice' do
        expect(game).to receive(:string_to_int).twice
        game.next_column_choice
      end

      it 'invokes #gets twice' do
        expect(game).to receive(:gets).twice
        game.next_column_choice
      end

      it 'invokes Board#valid_column? twice' do
        expect(board).to receive(:valid_column?).twice
        game.next_column_choice
      end

      it 'invokes #invalid_column_message once' do
        expect(game).to receive(:invalid_column_message).once
        game.next_column_choice
      end
    end

    context 'when user input is invalid five times' do
      before do
        allow(board).to receive(:valid_column?).and_return(false, false, false, false, false, true)
      end

      it 'invokes Board#draw six times' do
        expect(board).to receive(:draw).exactly(6).times
        game.next_column_choice
      end

      it 'invokes #choose_column_message six times' do
        expect(game).to receive(:choose_column_message).exactly(6).times
        game.next_column_choice
      end

      it 'invokes #string_to_int six times' do
        expect(game).to receive(:string_to_int).exactly(6).times
        game.next_column_choice
      end

      it 'invokes #gets six times' do
        expect(game).to receive(:gets).exactly(6).times
        game.next_column_choice
      end

      it 'invokes Board#valid_column? six times' do
        expect(board).to receive(:valid_column?).exactly(6).times
        game.next_column_choice
      end

      it 'invokes #invalid_column_message five times' do
        expect(game).to receive(:invalid_column_message).exactly(5).times
        game.next_column_choice
      end
    end

    context 'when user input is valid' do
      let(:column) { 0 }

      before do
        allow(game).to receive(:string_to_int).and_return(column)
        allow(board).to receive(:valid_column?).and_return(true)
      end

      it 'returns validated user input' do
        result = game.next_column_choice
        expect(result).to eq(column)
      end
    end
  end
end
