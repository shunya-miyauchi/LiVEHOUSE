require 'rails_helper'

RSpec.describe Livehouse, type: :model do
  describe 'アソシエーションテスト' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:livehouse) { FactoryBot.create(:livehouse) }
    let!(:event) { FactoryBot.create(:event, livehouse: livehouse) }
    context 'livehouseが削除された場合' do
      it '関連付けられたfavoriteも削除される' do
        FactoryBot.create(:favorite, user_id: user.id, livehouse_id: livehouse.id)
        expect { livehouse.destroy }.to change { Favorite.count }.by(-1)
      end
      it '関連付けられたeventも削除される' do
        expect { livehouse.destroy }.to change { Event.count }.by(-1)
      end
    end
  end
  describe 'geocoderテスト' do
    context 'livehouseが作成された場合' do
      let!(:livehouse){ FactoryBot.create(:livehouse) }
      it '経度緯度が自動で保存される' do
        expect( livehouse.latitude ).to be_present
        expect( livehouse.longitude ).to be_present
      end
    end
  end
end
