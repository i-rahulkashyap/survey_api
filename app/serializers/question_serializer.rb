class QuestionSerializer
  include JSONAPI::Serializer
  attributes :id, :question_type, :text, :options, :required, :order
  belongs_to :survey
end
