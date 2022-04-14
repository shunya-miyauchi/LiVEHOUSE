FactoryBot.define do
  factory :livehouse do
    name { '下北沢BASEMENT BAR' }
    address { '東京都世田谷区代沢5-18-1' }
    url { 'https://toos.co.jp/basementbar/' }
    place_id { '15' }
  end
  factory :livehouse_second, class: Livehouse do
    name { '心斎橋Pangea' }
    address { '大阪府大阪市中央区西心斎橋2-10-34' }
    url { 'https://livepangea.com/' }
    place_id { '42' }
  end
end
