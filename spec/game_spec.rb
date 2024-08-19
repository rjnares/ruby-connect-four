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

    it 'sets a winner instance variable to nil' do
      actual = game.instance_variable_get(:@winner)
      expect(actual).to be_nil
    end
  end

  describe '#play' do
    before do
      allow(game).to receive(:welcome_and_instructions_message)
      allow(game).to receive(:next_column_choice)
      allow(game).to receive(:next_cpu_column_choice)
      allow(game).to receive(:player_win_message)
      allow(game).to receive(:player_lose_message)
      allow(game).to receive(:tie_message)
      allow(board).to receive(:insert)
    end

    context 'when player 1 wins' do
      before do
        allow(game).to receive(:winner).and_return(Game::PLAYER_TOKEN_1)
      end

      context 'on turn one (impossible but test behavior anyway)' do
        before do
          allow(game).to receive(:game_over?).and_return(true)
        end

        it 'invokes #welcome_and_instructions_message once' do
          expect(game).to receive(:welcome_and_instructions_message).once
          game.play
        end

        it 'invokes #next_column_choice once' do
          expect(game).to receive(:next_column_choice).once
          game.play
        end

        it 'invokes Board#insert once' do
          expect(board).to receive(:insert).once
          game.play
        end

        it 'invokes #game_over? once' do
          expect(game).to receive(:game_over?).once
          game.play
        end

        it 'does not invoke #next_cpu_column_choice' do
          expect(game).not_to receive(:next_cpu_column_choice)
          game.play
        end

        it 'invokes #winner once' do
          expect(game).to receive(:winner).once
          game.play
        end

        it 'invokes #player_win_message once' do
          expect(game).to receive(:player_win_message).once
          game.play
        end

        it 'does not invoke #player_lose_message' do
          expect(game).not_to receive(:player_lose_message)
          game.play
        end

        it 'does not invoke #tie_message' do
          expect(game).not_to receive(:tie_message)
          game.play
        end
      end

      context 'on turn four' do
        before do
          allow(game).to receive(:game_over?).and_return(false, false, false, false, false, false, true)
        end

        it 'invokes #welcome_and_instructions_message once' do
          expect(game).to receive(:welcome_and_instructions_message).once
          game.play
        end

        it 'invokes #next_column_choice exactly 4 times' do
          expect(game).to receive(:next_column_choice).exactly(4).times
          game.play
        end

        it 'invokes Board#insert exactly 7 times' do
          expect(board).to receive(:insert).exactly(7).times
          game.play
        end

        it 'invokes #game_over? exactly 7 times' do
          expect(game).to receive(:game_over?).exactly(7).times
          game.play
        end

        it 'invokes #next_cpu_column_choice exactly 3 times' do
          expect(game).to receive(:next_cpu_column_choice).exactly(3).times
          game.play
        end

        it 'invokes #winner once' do
          expect(game).to receive(:winner).once
          game.play
        end

        it 'invokes #player_win_message once' do
          expect(game).to receive(:player_win_message).once
          game.play
        end

        it 'does not invoke #player_lose_message' do
          expect(game).not_to receive(:player_lose_message)
          game.play
        end

        it 'does not invoke #tie_message' do
          expect(game).not_to receive(:tie_message)
          game.play
        end
      end
    end

    context 'when player 2 wins' do
      before do
        allow(game).to receive(:winner).and_return(Game::PLAYER_TOKEN_2)
      end

      context 'on turn one (impossible but test behavior anyway)' do
        before do
          allow(game).to receive(:game_over?).and_return(false, true)
        end

        it 'invokes #welcome_and_instructions_message once' do
          expect(game).to receive(:welcome_and_instructions_message).once
          game.play
        end

        it 'invokes #next_column_choice once' do
          expect(game).to receive(:next_column_choice).once
          game.play
        end

        it 'invokes Board#insert twice' do
          expect(board).to receive(:insert).twice
          game.play
        end

        it 'invokes #game_over? twice' do
          expect(game).to receive(:game_over?).twice
          game.play
        end

        it 'invokes #next_cpu_column_choice once' do
          expect(game).to receive(:next_cpu_column_choice).once
          game.play
        end

        it 'invokes #winner twice' do
          expect(game).to receive(:winner).twice
          game.play
        end

        it 'does not invoke #player_win_message' do
          expect(game).not_to receive(:player_win_message)
          game.play
        end

        it 'invokes #player_lose_message once' do
          expect(game).to receive(:player_lose_message).once
          game.play
        end

        it 'does not invoke #tie_message' do
          expect(game).not_to receive(:tie_message)
          game.play
        end
      end

      context 'on turn four' do
        before do
          allow(game).to receive(:game_over?).and_return(false, false, false, false, false, false, false, true)
        end

        it 'invokes #welcome_and_instructions_message once' do
          expect(game).to receive(:welcome_and_instructions_message).once
          game.play
        end

        it 'invokes #next_column_choice exactly four times' do
          expect(game).to receive(:next_column_choice).exactly(4).times
          game.play
        end

        it 'invokes Board#insert exactly eight times' do
          expect(board).to receive(:insert).exactly(8).times
          game.play
        end

        it 'invokes #game_over? exactly eight times' do
          expect(game).to receive(:game_over?).exactly(8).times
          game.play
        end

        it 'invokes #next_cpu_column_choice exactly four times' do
          expect(game).to receive(:next_cpu_column_choice).exactly(4).times
          game.play
        end

        it 'invokes #winner twice' do
          expect(game).to receive(:winner).twice
          game.play
        end

        it 'does not invoke #player_win_message' do
          expect(game).not_to receive(:player_win_message)
          game.play
        end

        it 'invokes #player_lose_message once' do
          expect(game).to receive(:player_lose_message).once
          game.play
        end

        it 'does not invoke #tie_message' do
          expect(game).not_to receive(:tie_message)
          game.play
        end
      end
    end

    context 'when player 1 fills board' do
      context 'on turn one (impossible but test behavior anyway)' do
        before do
          allow(game).to receive(:game_over?).and_return(true)
        end

        it 'invokes #welcome_and_instructions_message once' do
          expect(game).to receive(:welcome_and_instructions_message).once
          game.play
        end

        it 'invokes #next_column_choice once' do
          expect(game).to receive(:next_column_choice).once
          game.play
        end

        it 'invokes Board#insert once' do
          expect(board).to receive(:insert).once
          game.play
        end

        it 'invokes #game_over? once' do
          expect(game).to receive(:game_over?).once
          game.play
        end

        it 'does not invoke #next_cpu_column_choice' do
          expect(game).not_to receive(:next_cpu_column_choice)
          game.play
        end

        it 'invokes #winner twice' do
          expect(game).to receive(:winner).twice
          game.play
        end

        it 'does not invoke #player_win_message' do
          expect(game).not_to receive(:player_win_message)
          game.play
        end

        it 'does not invoke #player_lose_message' do
          expect(game).not_to receive(:player_lose_message)
          game.play
        end

        it 'invokes #tie_message once' do
          expect(game).to receive(:tie_message).once
          game.play
        end
      end

      context 'on turn four (impossible but test behavior anyway)' do
        before do
          allow(game).to receive(:game_over?).and_return(false, false, false, false, false, false, true)
        end

        it 'invokes #welcome_and_instructions_message once' do
          expect(game).to receive(:welcome_and_instructions_message).once
          game.play
        end

        it 'invokes #next_column_choice exactly four times' do
          expect(game).to receive(:next_column_choice).exactly(4).times
          game.play
        end

        it 'invokes Board#insert exactly seven times' do
          expect(board).to receive(:insert).exactly(7).times
          game.play
        end

        it 'invokes #game_over? exactly seven times' do
          expect(game).to receive(:game_over?).exactly(7).times
          game.play
        end

        it 'invokes #next_cpu_column_choice exactly three times' do
          expect(game).to receive(:next_cpu_column_choice).exactly(3).times
          game.play
        end

        it 'invokes #winner twice' do
          expect(game).to receive(:winner).twice
          game.play
        end

        it 'does not invoke #player_win_message' do
          expect(game).not_to receive(:player_win_message)
          game.play
        end

        it 'does not invoke #player_lose_message' do
          expect(game).not_to receive(:player_lose_message)
          game.play
        end

        it 'invokes #tie_message once' do
          expect(game).to receive(:tie_message).once
          game.play
        end
      end
    end

    context 'when player 2 fills board' do
      context 'on turn one (impossible but test behavior anyway)' do
        before do
          allow(game).to receive(:game_over?).and_return(false, true)
        end

        it 'invokes #welcome_and_instructions_message once' do
          expect(game).to receive(:welcome_and_instructions_message).once
          game.play
        end

        it 'invokes #next_column_choice once' do
          expect(game).to receive(:next_column_choice).once
          game.play
        end

        it 'invokes Board#insert twice' do
          expect(board).to receive(:insert).twice
          game.play
        end

        it 'invokes #game_over? twice' do
          expect(game).to receive(:game_over?).twice
          game.play
        end

        it 'invokes #next_cpu_column_choice once' do
          expect(game).to receive(:next_cpu_column_choice).once
          game.play
        end

        it 'invokes #winner twice' do
          expect(game).to receive(:winner).twice
          game.play
        end

        it 'does not invoke #player_win_message' do
          expect(game).not_to receive(:player_win_message)
          game.play
        end

        it 'does not invoke #player_lose_message' do
          expect(game).not_to receive(:player_lose_message)
          game.play
        end

        it 'invokes #tie_message once' do
          expect(game).to receive(:tie_message).once
          game.play
        end
      end

      context 'on turn four (impossible but test behavior anyway)' do
        before do
          allow(game).to receive(:game_over?).and_return(false, false, false, false, false, false, false, true)
        end

        it 'invokes #welcome_and_instructions_message once' do
          expect(game).to receive(:welcome_and_instructions_message).once
          game.play
        end

        it 'invokes #next_column_choice exactly four times' do
          expect(game).to receive(:next_column_choice).exactly(4).times
          game.play
        end

        it 'invokes Board#insert exactly eight times' do
          expect(board).to receive(:insert).exactly(8).times
          game.play
        end

        it 'invokes #game_over? exactly eight times' do
          expect(game).to receive(:game_over?).exactly(8).times
          game.play
        end

        it 'invokes #next_cpu_column_choice exactly four times' do
          expect(game).to receive(:next_cpu_column_choice).exactly(4).times
          game.play
        end

        it 'invokes #winner twice' do
          expect(game).to receive(:winner).twice
          game.play
        end

        it 'does not invoke #player_win_message' do
          expect(game).not_to receive(:player_win_message)
          game.play
        end

        it 'does not invoke #player_lose_message' do
          expect(game).not_to receive(:player_lose_message)
          game.play
        end

        it 'invokes #tie_message once' do
          expect(game).to receive(:tie_message).once
          game.play
        end
      end
    end
  end

  describe '#next_column_choice' do
    before do
      allow(game).to receive(:current_game_state_message)
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

      it 'invokes #current_game_state_message once' do
        expect(game).to receive(:current_game_state_message).once
        game.next_column_choice
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

      it 'invokes #current_game_state_message once' do
        expect(game).to receive(:current_game_state_message).once
        game.next_column_choice
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

      it 'invokes #current_game_state_message once' do
        expect(game).to receive(:current_game_state_message).once
        game.next_column_choice
      end

      it 'returns validated user input' do
        result = game.next_column_choice
        expect(result).to eq(column)
      end
    end
  end
end
