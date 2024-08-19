# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  subject(:board) { described_class.new }
  let(:array) { board.instance_variable_get(:@board) }

  describe '#initialize' do
    context 'when invoked' do
      it 'creates an array of length 7' do
        expect(array.length).to eq(7)
      end

      it 'creates an array of nested arrays each of length 6' do
        result = array.all? { |nested_array| nested_array.length == 6 }
        expect(result).to eq(true)
      end

      it 'creates an array of nested arrays where each value is nil' do
        result = array.flatten.all?(&:nil?)
        expect(result).to eq(true)
      end
    end
  end

  describe '#insert' do
    let(:token) { '#' }

    context 'when an invalid column index is given' do
      let(:column_index) { 100 }

      it 'returns false' do
        result = board.insert(column_index, token)
        expect(result).to eq(false)
      end
    end
    context 'when a valid column index is given' do
      let(:column_index) { 0 }
      let(:column) { array[column_index] }

      context 'when the column is empty' do
        it 'adds a single token to the column' do
          board.insert(column_index, token)
          expect(column.count(token)).to eq(1)
        end

        it 'adds a single token to the bottom-most space of the column' do
          board.insert(column_index, token)
          expect(column.last(column.length - 1).all?(&:nil?))
        end

        it 'return true' do
          result = board.insert(column_index, token)
          expect(result).to eq(true)
        end
      end

      context 'when the column is half-full' do
        before do
          (column.length - 3).times { |row_index| column[row_index] = token }
        end

        it 'adds a single token to the column' do
          previous_num_tokens = column.count(token)
          board.insert(column_index, token)
          expect(column.count(token)).to eq(previous_num_tokens + 1)
        end

        it 'adds a single token to the bottom-most space of the column' do
          bottom_most_index = column.index(nil)
          board.insert(column_index, token)
          expect(column.index(nil)).to eq(bottom_most_index + 1)
        end

        it 'returns true' do
          result = board.insert(column_index, token)
          expect(result).to eq(true)
        end
      end

      context 'when the column is full' do
        before do
          column.fill(token)
        end

        it 'returns false' do
          result = board.insert(column_index, token)
          expect(result).to eq(false)
        end
      end
    end
  end

  describe '#full?' do
    context 'when board is empty' do
      it 'returns false' do
        expect(board.full?).to eq(false)
      end
    end

    context 'when board is not empty or full' do
      it 'returns false' do
        array.each_with_index { |column, index| column[index] = '#' }
        expect(board.full?).to eq(false)
      end
    end

    context 'when board is full' do
      it 'returns true' do
        array.each { |column| column.fill('#') }
        expect(board.full?).to eq(true)
      end
    end
  end

  describe '#win?' do
    let(:token) { '#' }

    context 'when testing for win conditions' do
      before do
        allow(board).to receive(:win_vertically?)
        allow(board).to receive(:win_horizontally?)
        allow(board).to receive(:win_diagonally?)
      end

      it 'calls #win_vertically? once' do
        expect(board).to receive(:win_vertically?).with(token).once
        board.win?(token)
      end

      it 'calls #win_horizontally? once' do
        expect(board).to receive(:win_horizontally?).with(token).once
        board.win?(token)
      end

      it 'calls #win_diagonally? once' do
        expect(board).to receive(:win_diagonally?).with(token).once
        board.win?(token)
      end
    end

    context 'when column contains four connected tokens' do
      let(:column) { array[0] }

      before do
        column.fill(token)
      end

      it 'returns true' do
        result = board.win?(token)
        expect(result).to eq(true)
      end
    end

    context 'when column contains four non-connected tokens' do
      let(:column) { array[0] }

      before do
        column.fill(token)
        column[3] = nil
      end

      it 'returns false' do
        result = board.win?(token)
        expect(result).to eq(false)
      end
    end

    context 'when four tokens are connected horizontally' do
      let(:row_index) { 4 }

      before do
        4.times { |column_index| array[column_index][row_index] = token }
      end
      it 'returns true' do
        result = board.win?(token)
        expect(result).to eq(true)
      end
    end

    context 'when four tokens are connected diagonally (top-left to bottom-right)' do
      before do
        4.times do |index|
          column = array[index]
          column[column.length - 1 - index] = token
        end
      end

      it 'returns true' do
        result = board.win?(token)
        expect(result).to eq(true)
      end
    end

    context 'when four tokens are connected diagonally (bottom-left to top-right)' do
      before do
        4.times { |index| array[index][index] = token }
      end

      it 'returns true' do
        result = board.win?(token)
        expect(result).to eq(true)
      end
    end

    context 'when four tokens are NOT connected' do
      it 'returns false' do
        result = board.win?(token)
        expect(result).to eq(false)
      end
    end
  end

  describe '#valid_column?' do
    context 'when column is out of range' do
      let(:out_of_range_column) { -1 }

      it 'returns false' do
        result = board.valid_column?(out_of_range_column)
        expect(result).to eq(false)
      end
    end

    context 'when column is full' do
      let(:full_column) { 0 }

      before do
        array[full_column].fill('#')
      end

      it 'returns false' do
        result = board.valid_column?(full_column)
        expect(result).to eq(false)
      end
    end

    context 'when column is in range and non-full' do
      let(:valid_column) { 0 }

      it 'returns true' do
        result = board.valid_column?(valid_column)
        expect(result).to eq(true)
      end
    end
  end

  describe '#draw' do
    before do
      allow(board).to receive(:print_token_rows)
      allow(board).to receive(:print_columns_row)
    end

    context 'when invoked' do
      it 'invokes #print_token_rows once' do
        expect(board).to receive(:print_token_rows).once
        board.draw
      end

      it 'invokes #print_columns_row once' do
        expect(board).to receive(:print_columns_row).once
        board.draw
      end
    end
  end

  describe '#available_columns' do
    context 'when columns 0-6 are not full' do
      it 'returns columns 0-6 in an array' do
        result = board.available_columns
        expect(result).to eq([0, 1, 2, 3, 4, 5, 6])
      end
    end

    context 'when columns 0-3 are full' do
      it 'returns columns 4-6 in an array' do
        0.upto(3) { |i| array[i].fill('#') }
        result = board.available_columns
        expect(result).to eq([4, 5, 6])
      end
    end

    context 'when columns 4-6 are full' do
      it 'returns columns 0-3 in an array' do
        4.upto(6) { |i| array[i].fill('#') }
        result = board.available_columns
        expect(result).to eq([0, 1, 2, 3])
      end
    end

    context 'when columns 0-6 are full' do
      it 'returns an empty array' do
        0.upto(6) { |i| array[i].fill('#') }
        result = board.available_columns
        expect(result).to eq([])
      end
    end
  end
end
