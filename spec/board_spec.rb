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
          (column.length - 3).times { |index| column[index] = token }
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
end
