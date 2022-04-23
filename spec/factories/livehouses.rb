FactoryBot.define do
  factory :livehouse do
    name { '下北沢BASEMENT BAR' }
    address { '東京都世田谷区代沢5-18-1' }
    url { 'https://toos.co.jp/basementbar/' }
    place_id { '15' }
  end
  factory :livehouse_second, class: Livehouse do
    name { 'Spotify O-nest' }
    address { '東京都渋谷区円山町2-3 6F' }
    url { 'https://shibuya-o.com/nest/' }
    place_id { '14' }
  end
end
