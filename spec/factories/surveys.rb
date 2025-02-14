FactoryBot.define do
  factory :survey do
    user { nil }
    title { "MyString" }
    description { "MyText" }
    theme { "MyString" }
  end
end
