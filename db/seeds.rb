# livehouse
Livehouse.create!([
  {
    name: '下北沢BASEMENT BAR',
    address: '東京都世田谷区代沢5-18-1 カラバッシュビルB1F',
    url: 'https://toos.co.jp/basementbar/',
    nearest_station: '下北沢駅より徒歩10分',
    place_id: '15'
  },
  {
    name: '下北沢SHELTER',
    address: '東京都世田谷区北沢2-6-10仙田ビルB1',
    url: 'http://www.loft-prj.co.jp/SHELTER/',
    nearest_station: '下北沢駅より徒歩５分',
    place_id: '15'
  },
  {
    name: '新代田FEVER',
    address: '東京都世田谷区羽根木1-1-14 新代田ビル1F',
    url: 'https://www.fever-popo.com/',
    nearest_station: '新代田駅より徒歩30秒',
    place_id: '15'
  },
  {
    name: 'Spotify O-nest',
    address: '東京都渋谷区円山町2-3 6F',
    url: 'https://shibuya-o.com/nest/',
    nearest_station: '渋谷駅より徒歩5分',
    place_id: '14'
  },
  {
    name: 'Live House Pangea',
    address: '大阪市中央区西心斎橋2-10-34 心斎橋ウエスト363ビル1F',
    url: 'https://livepangea.com/',
    nearest_station: '四ツ橋駅より徒歩3分'
  }
])

# users
5.times do |n|
  User.create!(
    name: "みやうち#{n + 1}",
    display_name: "miyauchi#{n + 1}",
    email: "#{n + 1}aaa@gmail.com",
    password: 123_456,
    image: File.open("./public/images/image#{n + 1}.png")
  )
end

# events
from = Time.parse('2022/4/1')
to = Time.parse('2022/4/30')
open = 1900
start = 2100
5.times do |_n|
  Livehouse.all.each_with_index do |livehouse, idx|
    Event.create!(
      title: "タイトル#{idx + 1}",
      held_on: Random.rand(from..to),
      open: Random.rand(open..start),
      start: Random.rand(open..start),
      price: 3000,
      artist: "ミヤウチ#{idx + 1}",
      url: 'https://diveintocode.jp/',
      livehouse_id: livehouse.id
    )
  end
end

# blogs
5.times do |n|
  Blog.create!(
    title: "タイトル#{n + 1}",
    content: "本文#{n + 1}",
    images: [open("#{Rails.root}/public/images/image#{n + 1}.png")],
    user_id: User.find_by(name: "みやうち#{n + 1}").id,
    event_id: Event.find_by(title: "タイトル#{n + 1}").id
  )
end

# comments
5.times do |n|
  Comment.create!(
    content: "あああ#{n + 1}",
    user_id: User.find_by(name: "みやうち#{n + 1}").id,
    event_id: Event.find_by(title: "タイトル#{n + 1}").id
  )
end

# favorites
5.times do |n|
  Livehouse.all.each_with_index do |livehouse, _idx|
    Favorite.create!(
      user_id: User.find_by(name: "みやうち#{n + 1}").id,
      livehouse_id: livehouse.id
    )
  end
end

# joins
5.times do |n|
  Join.create!(
    user_id: User.find_by(name: "みやうち#{n + 1}").id,
    event_id: Event.find_by(title: "タイトル#{n + 1}").id
  )
end
