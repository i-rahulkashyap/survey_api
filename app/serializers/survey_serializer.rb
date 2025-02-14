class SurveySerializer
  include JSONAPI::Serializer
  attributes :id, :title, :description, :theme, :response_id
  belongs_to :user # Make sure you have a user association defined
  has_many :questions  # Make sure you have a questions association defined

  attribute :response_id do |survey, params|
    if params && params[:current_user]
      response = survey.responses.find_by(user_id: params[:current_user].id)
      response ? response.id : nil
    end
  end
  
  
end
