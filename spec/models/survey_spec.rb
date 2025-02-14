require 'rails_helper'

RSpec.describe Survey, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:questions).dependent(:destroy) }
  it { should have_many(:responses).dependent(:destroy) }
  it { should accept_nested_attributes_for(:questions) }
  it { should validate_presence_of(:title) }
end