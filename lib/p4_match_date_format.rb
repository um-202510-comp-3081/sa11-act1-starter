# frozen_string_literal: true

# P4: Matching a Date Format

# Replace nil with the regex that matches dates in the format `YYYY-MM-DD`.
def valid_date?(date)
  pattern = nil
  date.match?(pattern)
end

# p valid_date?("2023-03-15")
# p valid_date?("15-03-2023")
