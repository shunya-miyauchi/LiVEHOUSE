# livehouse
@livehouses =
Livehouse.create!([
                    {
                      name: 'Spotify O-nest',
                      address: '東京都渋谷区円山町2-3 6F',
                      url: 'https://shibuya-o.com/nest/',
                      nearest_station: '渋谷駅より徒歩5分',
                      place_id: '14'
                    },
                    {
                      name: 'shibuya eggman',
                      address: '東京都渋谷区神南1-6-8',
                      url: 'http://eggman.jp/',
                      nearest_station: '渋谷駅から徒歩10分',
                      place_id: '14'
                    },
                    {
                      name: '渋谷CLUB QUATTRO',
                      address: '東京都渋谷区宇田川町32-13 クアトロ･パルコ4･5F',
                      url: 'http://www.club-quattro.com/',
                      nearest_station: '渋谷駅から徒歩7分',
                      place_id: '14'
                    },
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
                    # {
                    #   name: '新代田FEVER',
                    #   address: '東京都世田谷区羽根木1-1-14 新代田ビル1F',
                    #   url: 'https://www.fever-popo.com/',
                    #   nearest_station: '新代田駅より徒歩30秒',
                    #   place_id: '15'
                    # },
                    # {
                    #   name: '新宿LOFT',
                    #   address: '東京都新宿区歌舞伎町1-12-9 タテハナビルB2',
                    #   url: 'http://www.loft-prj.co.jp/LOFT/',
                    #   nearest_station: '新宿駅東口より徒歩10分',
                    #   place_id: '16'
                    # },
                    # {
                    #   name: 'Live House Marble',
                    #   address: '東京都新宿区歌舞伎町2-45-2 ジャストビルB1F',
                    #   url: 'http://marble-web.jp/html/map.html',
                    #   nearest_station: '新宿駅東口より徒歩5分',
                    #   place_id: '16'
                    # },
                    # {
                    #   name: '高田馬場CLUB PHASE',
                    #   address: '東京都豊島区高田3-8-5 セントラルワセダB1F',
                    #   url: 'http://www.club-phase.com/top.html',
                    #   nearest_station: '高田馬場駅より徒歩5分',
                    #   place_id: '17'
                    # },
                    # {
                    #   name: '池袋LiveGarage Adm',
                    #   address: '東京都豊島区東池袋1-22-1 GSハイムB1F',
                    #   url: 'http://www.adm-rock.com/index03.html',
                    #   nearest_station: '池袋駅東口より徒歩10分',
                    #   place_id: '17'
                    # },
                    # {
                    #   name: '池袋LiveGarage Adm',
                    #   address: '東京都豊島区東池袋1-22-1 GSハイムB1F',
                    #   url: 'http://www.adm-rock.com/index03.html',
                    #   nearest_station: '池袋駅東口より徒歩10分',
                    #   place_id: '18'
                    # },
                    # {
                    #   name: 'Live House Pangea',
                    #   address: '大阪市中央区西心斎橋2-10-34 心斎橋ウエスト363ビル1F',
                    #   url: 'https://livepangea.com/',
                    #   nearest_station: '四ツ橋駅より徒歩3分',
                    #   place_id: '42'
                    # }
                  ])

# users
@users = []
5.times do |n|
  @users <<
  User.create!(
    name: Faker::Name.last_name,
    display_name: Faker::Internet.username(specifier: 5..15),
    email: Faker::Internet.safe_email,
    password: 123456,
    image: File.open("./public/images/image#{n + 1}.png")
  )
end

# events
@events = []
5.times do |_n|
  @livehouses.each do |livehouse|
    @events <<
    Event.create!(
      title: Faker::Book.title,
      held_on: Faker::Date.between(from: '2022-4-1', to: '2022-5-31'),
      open: "19:00",
      start: "20:#{Faker::Number.within(range: 10..30)}",
      price: 3000,
      artist: Faker::Music::RockBand.name,
      url: 'https://diveintocode.jp/',
      livehouse_id: livehouse.id
    )
  end
end

# blogs
# comments
# joins
@users.each do |user|
  @events.each do |event|
    Blog.create!(
      title: Faker::Games::Pokemon.name,
      content: "あああああああああああああああああああああああああああああああ",
      images: [open("#{Rails.root}/public/images/image1.png")],
      user_id: user.id,
      event_id: event.id
    )
    Comment.create!(
      content: Faker::Games::Pokemon.name,
      user_id: user.id,
      event_id: event.id
    )
    Join.create!(
      user_id: user.id,
      event_id: event.id
    )
  end
end

# favorites
@users.each do |user|
  @livehouses.each do |livehouse|
    Favorite.create!(
      user_id: user.id,
      livehouse_id: livehouse.id
    )
  end
end
