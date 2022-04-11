FactoryBot.define do
  factory :comment do
    user { nil }
    event { nil }
    content { "MyText" }
  end
end
