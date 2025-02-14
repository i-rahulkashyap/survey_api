class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :survey
  enum question_type: { multiple_choice: 0, short_answer: 1, true_false: 2, fill_in_the_blanks: 3, image_upload: 4, file_upload: 5 }
  validates :text, presence: true
  validates :question_type, inclusion: { in: question_types.keys }
end
