class SurveyMailer < ApplicationMailer
  default from: 'no-reply@surveyapp.com'

  def send_survey
    @survey = params[:survey]
    @url = @survey.generate_survey_link
    mail(to: params[:email], subject: 'You have been invited to participate in a survey')
  end
end