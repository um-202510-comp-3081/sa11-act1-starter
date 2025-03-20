# frozen_string_literal: true

# P2: Validating a Password

# Replace nil with the regex for a password that must contain:
#   - at least one uppercase letter
#   - one lowercase letter
#   - one digit
#   - be 8 to 16 characters long
def valid_password?(password)
  pattern = nil
  password.match?(pattern)
end

# p valid_password?("Passw0rd")
# p valid_password?("pass")
