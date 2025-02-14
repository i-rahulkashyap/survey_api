FactoryBot.define do
  factory :question do
    survey { nil }
    question_type { 1 }
    text { "MyText" }
    options { "" }
    required { false }
    order { 1 }
  end
end
