# frozen_string_literal: true

require 'p4_match_date_format'

# NOTE: Do not modify the tests.

RSpec.describe 'Date Validation' do
  describe '#valid_date?' do
    context 'when the date is in the correct format' do
      it 'returns true for a valid date' do
        expect(valid_date?('2023-03-15')).to be true
      end

      it 'returns true for the earliest possible date' do
        expect(valid_date?('0001-01-01')).to be true
      end

      it 'returns true for the latest possible date' do
        expect(valid_date?('9999-12-31')).to be true
      end

      it 'returns true for a leap year date' do
        expect(valid_date?('2024-02-29')).to be true
      end
    end

    context 'when the date is in an incorrect format' do
      it 'returns false for a date with incorrect separator' do
        expect(valid_date?('2023/03/15')).to be false
      end

      it 'returns false for a date in DD-MM-YYYY format' do
        expect(valid_date?('15-03-2023')).to be false
      end

      it 'returns false for a date in MM-DD-YYYY format' do
        expect(valid_date?('03-15-2023')).to be false
      end

      it 'returns false for a date without leading zeros' do
        expect(valid_date?('2023-3-15')).to be false
      end

      it 'returns false for a date with spaces' do
        expect(valid_date?('2023 - 03 - 15')).to be false
      end
    end

    context 'when the date has invalid values' do
      it 'returns false for an invalid month' do
        expect(valid_date?('2023-13-15')).to be false
      end

      it 'returns false for an invalid day' do
        expect(valid_date?('2023-03-32')).to be false
      end
    end

    context 'edge cases and special scenarios' do
      it 'returns false for an empty string' do
        expect(valid_date?('')).to be false
      end

      it 'returns false for a date string with additional text' do
        expect(valid_date?('Date: 2023-03-15')).to be false
      end

      it 'returns false for a partially correct date string' do
        expect(valid_date?('2023-03-')).to be false
      end

      it 'returns false for a date with non-digit characters' do
        # Using 'O' instead of '0'
        expect(valid_date?('2O23-O3-15')).to be false
      end
    end

    context 'tricky cases' do
      it 'returns true for the last day of each month' do
        expect(valid_date?('2023-01-31')).to be true
        expect(valid_date?('2023-04-30')).to be true
        expect(valid_date?('2023-02-28')).to be true
      end
    end
  end
end
