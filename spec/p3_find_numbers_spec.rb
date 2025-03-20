# frozen_string_literal: true

require 'p3_find_numbers'

# NOTE: Do not modify the tests.

RSpec.describe 'Number Extraction' do
  describe '#find_numbers' do
    context 'when the string contains numbers' do
      it 'extracts integer and decimal numbers' do
        expect(find_numbers('The order was placed for 100.25 units at a price of 20.75 each.')).to eq(['100.25',
                                                                                                       '20.75'])
      end

      it 'extracts only integer numbers' do
        expect(find_numbers('There are 5 apples and 10 oranges.')).to eq(%w[5 10])
      end

      it 'extracts numbers at the beginning and end of the string' do
        expect(find_numbers('123 middle 456')).to eq(%w[123 456])
      end

      it 'extracts negative numbers' do
        expect(find_numbers('The temperature dropped from 10 to -5 degrees.')).to eq(['10', '-5'])
      end
    end

    context "when the string doesn't contain numbers" do
      it 'returns an empty array for a string without numbers' do
        expect(find_numbers('This string has no numbers.')).to eq([])
      end

      it 'returns an empty array for an empty string' do
        expect(find_numbers('')).to eq([])
      end
    end

    context 'edge cases and special scenarios' do
      it 'handles multiple consecutive numbers' do
        expect(find_numbers('Numbers: 1 2 3 4 5')).to eq(%w[1 2 3 4 5])
      end

      it 'extracts numbers from a string with special characters' do
        expect(find_numbers('Price: $99.99, Discount: 20% off!')).to eq(['99.99', '20'])
      end

      it 'handles very large and very small numbers' do
        expect(find_numbers('Range: 9999999999999999 to 0.00000000000001')).to eq(['9999999999999999',
                                                                                   '0.00000000000001'])
      end

      it 'extracts numbers from a string with mixed content' do
        expect(find_numbers('2 dogs, 3 cats, and 1 fish')).to eq(%w[2 3 1])
      end

      it 'handles numbers with leading zeros' do
        expect(find_numbers('The code is 007.')).to eq(['007'])
      end
    end

    context 'tricky cases' do
      it "doesn't extract numbers from words" do
        expect(find_numbers('I have a4 paper and 2B pencils.')).to eq(%w[4 2])
      end

      it 'extracts numbers from a string with unicode characters' do
        expect(find_numbers('The temperature is 22°C')).to eq(['22'])
      end

      it 'handles ordinal numbers' do
        expect(find_numbers('He came in 1st place, she was 2nd.')).to eq(%w[1 2])
      end
    end
  end
end
