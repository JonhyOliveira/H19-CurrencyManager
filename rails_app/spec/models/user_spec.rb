# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'can be created if valid' do
    user = User.new
    user.email = Faker::Internet.email
    user.password = Faker::Internet.password

    expect { user.save }.to change(User, :count)
  end

  context 'is not valid' do
    it 'with an invalid email' do
      user = User.new
      user.email = 'joao123@'
      user.password = Faker::Internet.password

      expect(user).to_not be_valid
    end

    it 'with a small password' do
      user = User.new
      user.email = Faker::Internet.email
      user.password = '1234'

      expect(user).to_not be_valid
    end
  end

  context 'can not be created' do
    it 'if another one with the same email already exists' do
      user = User.new
      user.email = Faker::Internet.email
      user.password = Faker::Internet.password

      user.save

      user_copy = User.new
      user_copy.email = user.email
      user_copy.password = Faker::Internet.password

      expect { user.save }.to_not change(User, :count)
    end
  end
end
