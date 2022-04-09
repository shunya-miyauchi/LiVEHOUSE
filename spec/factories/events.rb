FactoryBot.define do
  factory :event do
    title { 'タイトル１' }
    held_on { '2022-1-3' }
    open { '18:00' }
    start { '18:30' }
    price { 2000 }
    artist { 'あああ / あああ' }
  end
  factory :event_second, class: Event do
    title { 'タイトル２' }
    held_on { '2022-1-10' }
    open { '18:30' }
    start { '19:00' }
    price { 3000 }
    artist { 'いいい / いいい' }
  end
  factory :event_third, class: Event do
    title { 'タイトル３' }
    held_on { '2022-1-17' }
    open { '19:00' }
    start { '19:30' }
    price { 4000 }
    artist { 'ううう / ううう' }
  end
  factory :event_fourth, class: Event do
    title { 'タイトル４' }
    held_on { '2022-1-24' }
    open { '19:30' }
    start { '20:00' }
    price { 5000 }
    artist { 'えええ / えええ' }
  end
end
