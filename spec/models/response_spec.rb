require 'rails_helper'

RSpec.describe Response, type: :model do
  it { should belong_to(:survey) }
  it { should belong_to(:user).optional }
  it { should have_many(:answers).dependent(:destroy) }
  it { should accept_nested_attributes_for(:answers) }
end