FactoryBot.define do
  factory :user do
    email { "MyString" }
    password_digest { "MyString" }
    organization { nil }
  end
end
