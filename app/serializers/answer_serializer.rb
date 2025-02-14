class AnswerSerializer
  include JSONAPI::Serializer
  attributes :id, :question_id, :text_value, :file_url 
end
