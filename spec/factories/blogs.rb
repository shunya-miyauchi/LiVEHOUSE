FactoryBot.define do
  factory :blog do
    title { "MyString" }
    content { "MyText" }
    image { "MyText" }
    user { nil }
    event { nil }
  end
end
