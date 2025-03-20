# frozen_string_literal: true

require 'p2_validate_passwords'

# NOTE: Do not modify the tests.

RSpec.describe 'Password Validation' do
  describe '#valid_password?' do
    context 'when the password meets all criteria' do
      it 'returns true for a valid password' do
        expect(valid_password?('Passw0rd')).to be true
      end
      it 'accepts a password with exactly 8 characters' do
        expect(valid_password?('Abcd1234')).to be true
      end

      it 'accepts a password with exactly 16 characters' do
        expect(valid_password?('Abcdefgh12345678')).to be true
      end
    end

    context 'when the password is invalid' do
      it "returns false for a password that's too short" do
        expect(valid_password?('Ab1')).to be false
      end

      it "returns false for a password that's too long" do
        expect(valid_password?('Abcdefgh123456789')).to be false
      end

      it 'returns false for a password without an uppercase letter' do
        expect(valid_password?('password123')).to be false
      end

      it 'returns false for a password without a lowercase letter' do
        expect(valid_password?('PASSWORD123')).to be false
      end

      it 'returns false for a password without a digit' do
        expect(valid_password?('PasswordABC')).to be false
      end
    end

    context 'edge cases and special scenarios' do
      it 'returns true for a password with special characters' do
        expect(valid_password?('P@ssw0rd!')).to be true
      end

      it 'returns true for a password with spaces' do
        expect(valid_password?('Pass w0rd')).to be true
      end

      it 'returns false for an empty string' do
        expect(valid_password?('')).to be false
      end

      it 'returns true for a password with all criteria at the extremes' do
        # 8 characters
        expect(valid_password?('Aa1aaaaa')).to be true
        # 16 characters
        expect(valid_password?('Aa1aaaaaaaaaaaaa')).to be true
      end

      it 'returns false for a password with criteria just outside the extremes' do
        # 7 characters
        expect(valid_password?('Aa1aaaa')).to be false
        # 17 characters
        expect(valid_password?('Aa1aaaaaaaaaaaaaa')).to be false
      end
    end

    context 'multiple criteria failures' do
      it 'returns false for a password failing multiple criteria' do
        # too short, no uppercase, no digit
        expect(valid_password?('pass')).to be false
      end
    end

    context 'tricky inputs' do
      it 'returns false for a password with only uppercase and digits' do
        expect(valid_password?('PASSWORD123')).to be false
      end

      it 'returns false for a password with only lowercase and digits' do
        expect(valid_password?('password123')).to be false
      end

      it 'returns false for a password with only letters' do
        expect(valid_password?('PASSWORDpass')).to be false
      end
    end
  end
end
