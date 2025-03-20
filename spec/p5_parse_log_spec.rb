# frozen_string_literal: true

require 'p5_parse_log'

# NOTE: Do not modify the tests.

RSpec.describe 'Log Entry Parsing' do
  describe '#parse_log_entry' do
    context 'when the log entry is valid' do
      it 'correctly parses an ERROR log entry' do
        expect(parse_log_entry('ERROR: Disk space low')).to eq(['ERROR', 'Disk space low'])
      end

      it 'correctly parses an INFO log entry' do
        expect(parse_log_entry('INFO: Application started')).to eq(['INFO', 'Application started'])
      end

      it 'correctly parses a WARN log entry' do
        expect(parse_log_entry('WARN: High memory usage')).to eq(['WARN', 'High memory usage'])
      end

      it 'handles log messages with multiple words' do
        expect(parse_log_entry('ERROR: Database connection failed after timeout')).to eq(['ERROR',
                                                                                          'Database connection failed after timeout'])
      end

      it 'handles log messages with punctuation' do
        expect(parse_log_entry("WARN: Unexpected input: '$pecial_char'!")).to eq(['WARN',
                                                                                  "Unexpected input: '$pecial_char'!"])
      end

      it 'handles log messages with numbers' do
        expect(parse_log_entry('INFO: Process 12345 started')).to eq(['INFO', 'Process 12345 started'])
      end
    end

    context 'when the log entry is invalid' do
      it 'returns nil for a log entry without a severity level' do
        expect(parse_log_entry('Application crashed')).to be_nil
      end

      it 'returns nil for a log entry with an invalid severity level' do
        expect(parse_log_entry('DEBUG: This is a debug message')).to be_nil
      end

      it 'returns nil for a log entry without a colon separator' do
        expect(parse_log_entry('ERROR - Disk space low')).to be_nil
      end

      it 'returns nil for an empty string' do
        expect(parse_log_entry('')).to be_nil
      end
    end

    context 'edge cases and special scenarios' do
      it 'handles log entries with multiple colons' do
        expect(parse_log_entry('INFO: Time: 12:30:45')).to eq(['INFO', 'Time: 12:30:45'])
      end

      it 'is case-sensitive for severity levels' do
        expect(parse_log_entry('info: Lowercase severity')).to be_nil
      end
    end

    context 'tricky cases' do
      it "doesn't match severity level within the message" do
        expect(parse_log_entry('INFO: Contains ERROR in message')).to eq(['INFO', 'Contains ERROR in message'])
      end

      it 'handles log entries with very long messages' do
        long_message = 'A' * 1000
        expect(parse_log_entry("WARN: #{long_message}")).to eq(['WARN', long_message])
      end

      it "doesn't match if severity level is not at the start" do
        expect(parse_log_entry('Log ERROR: System failure')).to be_nil
      end

      it 'handles log entries with Unicode characters' do
        expect(parse_log_entry('INFO: Unicode test: こんにちは')).to eq(['INFO', 'Unicode test: こんにちは'])
      end
    end
  end
end
