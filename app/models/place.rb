class Place < ActiveHash::Base
  self.data = [
    # {id: 1, prefecture: '北海道', area: '札幌'},{id: 2, prefecture: '北海道', area: 'その他'},{id: 3, prefecture: '青森県', area: ''},
    # {id: 4, prefecture: '岩手県', area: ''},{id: 5, prefecture: '宮城県', area: ''}, {id: 6, prefecture: '秋田県', area: ''},
    # {id: 7, prefecture: '山形県', area: ''},{id: 8, prefecture: '福島県', area: ''}, {id: 9, prefecture: '茨城県', area: ''},
    # {id: 10, prefecture: '栃木県', area: ''},{id: 11, prefecture: '群馬県', area: ''}, {id: 12, prefecture: '埼玉県', area: ''},
    # {id: 13, prefecture: '千葉県', area: ''},
    { id: 14, prefecture: '東京都', area: '渋谷•原宿周辺' }, { id: 15, prefecture: '東京都', area: '下北沢周辺' },
    # { id: 16, prefecture: '東京都', area: '新宿周辺' }, { id: 17, prefecture: '東京都', area: '池袋周辺' }, { id: 18, prefecture: '東京都', area: '高円寺周辺' },
    # { id: 19, prefecture: '東京都', area: '六本木•赤坂周辺' }, { id: 20, prefecture: '東京都', area: 'お台場•豊洲周辺' }, { id: 21, prefecture: '東京都', area: '吉祥寺周辺' },
    # { id: 22, prefecture: '東京都', area: '調布•府中周辺' }, { id: 23, prefecture: '東京都', area: '八王子周辺' }, { id: 24, prefecture: '東京都', area: '町田周辺' },
    # { id: 25, prefecture: '東京都', area: 'その他23区内' }, { id: 26, prefecture: '東京都', area: 'その他都下' },
    # {id: 27, prefecture: '神奈川県', area: '横浜•川崎'},
    # {id: 28, prefecture: '神奈川県', area: 'その他'},{id: 29, prefecture: '新潟県', area: ''},{id: 30, prefecture: '富山県', area: ''},
    # {id: 31, prefecture: '石川県', area: ''},{id: 32, prefecture: '福井県', area: ''},{id: 33, prefecture: '山梨県', area: ''},
    # {id: 34, prefecture: '長野県', area: ''}, {id: 35, prefecture: '岐阜県', area: ''},{id: 36, prefecture: '静岡県', area: ''},
    # {id: 37, prefecture: '愛知県', area: '名古屋'}, {id: 38, prefecture: '愛知県', area: 'その他'}, {id: 39, prefecture: '三重県', area: ''},
    # {id: 40, prefecture: '滋賀県', area: ''}, {id: 41, prefecture: '京都府', area: ''}, 
    # {id: 42, prefecture: '大阪府', area: '心斎橋•難波'},{id: 43, prefecture: '大阪府', area: '梅田'},{id: 44, prefecture: '大阪府', area: 'その他'},
    # {id: 45, prefecture: '兵庫県', area: ''},
    # {id: 46, prefecture: '奈良県', area: ''}, {id: 47, prefecture: '和歌山県', area: ''},{id: 48, prefecture: '鳥取県', area: ''},
    # {id: 49, prefecture: '島根県', area: ''}, {id: 50, prefecture: '岡山県', area: ''},{id: 51, prefecture: '広島県', area: ''},
    # {id: 52, prefecture: '山口県', area: ''}, {id: 53, prefecture: '徳島県', area: ''},{id: 54, prefecture: '香川県', area: ''},
    # {id: 55, prefecture: '愛媛県', area: ''}, {id: 56, prefecture: '高知県', area: ''},{id: 57, prefecture: '福岡県', area: ''},
    # {id: 58, prefecture: '佐賀県', area: ''}, {id: 59, prefecture: '長崎県', area: ''},{id: 60, prefecture: '熊本県', area: ''},
    # {id: 61, prefecture: '大分県', area: ''}, {id: 62, prefecture: '宮崎県', area: ''},{id: 63, prefecture: '鹿児島県', area: ''},
    # {id: 64, prefecture: '沖縄県', area: ''}
  ]

  def prefecture_area
    if area.blank?
      prefecture
    else
      "#{prefecture}/ #{area}"
    end
  end
end
