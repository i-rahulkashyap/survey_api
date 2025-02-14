require 'rails_helper'

RSpec.describe User, type: :model do
  let(:organization) { create(:organization) }

  subject(:user) do
    described_class.new(
      email: "test@example.com",
      password: "password123",
      organization: organization
    )
  end

  # Association tests
  it { should belong_to(:organization) }
  it { should have_many(:surveys) }

  # Validation tests
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password).on(:create) }
  it { should validate_length_of(:password).is_at_least(6).on(:create) }
  it { should validate_presence_of(:organization) }

  describe 'email validation' do
    before { user.save }
    
    it 'validates uniqueness of email' do
      should validate_uniqueness_of(:email)
        .case_insensitive
        .with_message('has already been taken')
    end
  end
end