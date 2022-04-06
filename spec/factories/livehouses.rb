FactoryBot.define do
  factory :livehouse do
    name { '下北沢BASEMENT BAR' }
    address { '東京都世田谷区代沢5-18-1' }
    url { 'https://toos.co.jp/basementbar/' }
  end
  factory :livehouse_second, class: Livehouse do
    name { '新宿ACB' }
    address { '東京都新宿区歌舞伎町2-36-3' }
    url { 'https://acb-hall.jp/' }
  end
  factory :livehouse_third, class: Livehouse do
    name { '心斎橋Pangea' }
    address { '大阪府大阪市中央区西心斎橋2-10-34' }
    url { 'https://livepangea.com/' }
  end
end
