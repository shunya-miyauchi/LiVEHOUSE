FactoryBot.define do
  factory :event do
    title { "タイトル１" }
    held_on { "2022-6-1" }
    open { "18:00" }
    start { "18:30" }
    price { 3000 }
    artist { "あああ / あああ" }
  end
  factory :event_second,class: Event do
    title { "タイトル２" }
    held_on { "2022-12-1" }
    open { "19:00" }
    start { "19:30" }
    price { 4000 }
    artist { "いいい / いいい" }
  end
  factory :event_third,class: Event do
    title { "タイトル３" }
    held_on { "2022-6-1" }
    open { "19:00" }
    start { "19:30" }
    price { 4000 }
    artist { "ううう / ううう" }
  end
  factory :event_fourth,class: Event do
    title { "タイトル４" }
    held_on { "2023-6-1" }
    open { "19:00" }
    start { "19:30" }
    price { 3000 }
    artist { "えええ / えええ" }
  end
end
