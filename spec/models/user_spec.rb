require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    organization = Organization.create(name: 'elitmus.com')
    user = User.new(email: 'test@elitmus.com', password: 'password', organization: organization)
    expect(user).to be_valid
  end

  it 'is not valid without an email' do
    user = User.new(password: 'password')
    expect(user).to_not be_valid
  end

  it 'is not valid with a non-elitmus.com email' do
    organization = Organization.create(name: 'elitmus.com')
    user = User.new(email: 'test@gmail.com', password: 'password', organization: organization)
    expect(user).to_not be_valid
  end
end