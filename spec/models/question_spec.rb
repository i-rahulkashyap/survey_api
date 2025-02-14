require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should belong_to(:survey) }
  it { should have_many(:answers).dependent(:destroy) }
  it { should validate_presence_of(:text) }
  it { should define_enum_for(:question_type).with_values([:multiple_choice, :short_answer, :true_false, :fill_in_the_blanks, :image_upload, :file_upload]) }
end