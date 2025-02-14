class Response < ApplicationRecord
  belongs_to :survey
  belongs_to :user, optional: true # Allow anonymous responses (consider IP tracking instead)
  has_many :answers, dependent: :destroy

  accepts_nested_attributes_for :answers
end
