# frozen_string_literal: true

# P1: Extracting Hashtags from a Tweet

# Replace nil with the regular expression to extract all hashtags
def extract_hashtags(text)
  pattern = nil
  hashtags = text.scan(pattern)
  hashtags.flatten
end

# p extract_hashtags('Love this #beautiful day! #sunny')
