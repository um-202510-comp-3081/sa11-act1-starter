# frozen_string_literal: true

require 'p1_extract_hashtags'

# NOTE: Do not modify the tests.

RSpec.describe 'Hashtag Extraction' do
  describe '#extract_hashtags' do
    it 'extracts multiple hashtags from a tweet' do
      expect(extract_hashtags('I love #ruby and #programming!')).to eq(['#ruby', '#programming'])
    end

    it 'returns an empty array if no hashtags are present' do
      expect(extract_hashtags('Just a normal tweet without hashtags')).to eq([])
    end

    it 'handles a single hashtag' do
      expect(extract_hashtags('Only one #hashtag here')).to eq(['#hashtag'])
    end

    it 'extracts hashtags with numbers' do
      expect(extract_hashtags('Check out #ruby2023 and #web3')).to eq(['#ruby2023', '#web3'])
    end

    it 'handles hashtags at the beginning of the tweet' do
      expect(extract_hashtags('#FirstTweet Hello, Twitter!')).to eq(['#FirstTweet'])
    end

    it 'handles hashtags at the end of the tweet' do
      expect(extract_hashtags('This is the end #LastHashtag')).to eq(['#LastHashtag'])
    end

    it 'extracts hashtags with underscores' do
      expect(extract_hashtags('Using #snake_case in my #hash_tags')).to eq(['#snake_case', '#hash_tags'])
    end

    it 'handles multiple hashtags in a row' do
      expect(extract_hashtags('Multiple #hashtags #in #a #row')).to eq(['#hashtags', '#in', '#a', '#row'])
    end

    it 'is case-insensitive' do
      expect(extract_hashtags('#UPPERCASE #lowercase #MixedCase')).to eq(['#UPPERCASE', '#lowercase', '#MixedCase'])
    end

    it 'handles hashtags surrounded by punctuation' do
      expect(extract_hashtags('Wow! #amazing! (Truly #incredible)')).to eq(['#amazing', '#incredible'])
    end

    it 'ignores # symbol not followed by word characters' do
      expect(extract_hashtags('# Not a hashtag #valid # #123')).to eq(['#valid', '#123'])
    end

    it 'extracts hashtags from a multi-line string' do
      tweet = "This is a\n#multiline\ntweet with\n#multiple\nhashtags"
      expect(extract_hashtags(tweet)).to eq(['#multiline', '#multiple'])
    end

    it 'handles an empty string' do
      expect(extract_hashtags('')).to eq([])
    end

    it 'handles a string with only hashtags' do
      expect(extract_hashtags('#one #two #three')).to eq(['#one', '#two', '#three'])
    end
  end
end
