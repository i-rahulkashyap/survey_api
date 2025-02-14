class ResponseSerializer
  include JSONAPI::Serializer
  attributes :id
  belongs_to :survey
  belongs_to :user
  has_many :answers
end
