class Survey < ApplicationRecord
  belongs_to :user
  has_many :questions, dependent: :destroy
  has_many :responses, dependent: :destroy
  accepts_nested_attributes_for :questions  # Crucial
  validates :title, presence: true


  def generate_survey_link
    Rails.application.routes.url_helpers.take_survey_url(self)
  end

  def distribute_via_email(emails)
    emails.each do |email|
      SurveyMailer.with(survey: self, email: email).send_survey.deliver_now
    end
  end

  def response_rate
    responses.count.to_f / targeted_audience_count * 100
  end

  private

  def targeted_audience_count
    # space for targeted audience
  end

  
end


