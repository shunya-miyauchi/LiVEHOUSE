FactoryBot.define do
  factory :event do
    title { "MyString" }
    held_on { "2022-04-03" }
    open { "MyString" }
    start { "MyString" }
    price { 1 }
    artist { "MyString" }
    livehouse { nil }
  end
end
