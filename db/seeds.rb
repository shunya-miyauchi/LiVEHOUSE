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
    name: Faker::Name.last_name,
    display_name: "miyauchi#{n+1}",
    email: Faker::Internet.email,
    password: Faker::Internet.password(min_length: 8),
    image: File.open("./public/images/image#{n + 1}.png")
  )
end

# events
5.times do |_n|
  Livehouse.all.each do |livehouse|
    Event.create!(
      title: Faker::Music::RockBand.name,
      held_on: Faker::Date.between(from: '2022-4-1', to: '2022-5-31'),
      open: "19:#{Faker::Number.within(range: 10..30)}",
      start: "20:#{Faker::Number.within(range: 10..30)}",
      price: Faker::Number.number(digits: 4),
      artist: Faker::JapaneseMedia::OnePiece.character,
      url: 'https://diveintocode.jp/',
      livehouse_id: livehouse.id
    )
  end
end

# blogs
User.all.each do |user|
  Event.all.each do |event|
    Blog.create!(
      title: Faker::Games::Pokemon.name,
      content: Faker::Book.title,
      images: [open("#{Rails.root}/public/images/image1.png")],
      user_id: user.id,
      event_id: event.id
    )
  end
end

# comments
User.all.each do |user|
  Event.all.each do |event|
    Comment.create!(
      content: Faker::Games::Pokemon.name,
      user_id: user.id,
      event_id: event.id
    )
  end
end

# favorites
User.all.each do |user|
  Livehouse.all.each do |livehouse|
    Favorite.create!(
      user_id: user.id,
      livehouse_id: livehouse.id
    )
  end
end

# joins
User.all.each do |user|
  Event.all.each do |event|
    Join.create!(
      user_id: user.id,
      event_id: event.id
    )
  end
end
