require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションテスト' do
    context 'nameカラム' do
      it '空欄である' do
        user = FactoryBot.build(:user, name: '')
        expect(user).not_to be_valid
      end
    end
    context 'display_nameカラム' do
      it '5文字以上でなければならない' do
        user = FactoryBot.build(:user, display_name: 'aaaa')
        expect(user).not_to be_valid
      end
      it '15文字以下でなければならない' do
        user = FactoryBot.build(:user, display_name: 'aaaaaaaaaaaaaaaa')
        expect(user).not_to be_valid
      end
      it '一意でなければならない' do
        FactoryBot.create(:user, display_name: 'aaaaa')
        user = FactoryBot.build(:user, display_name: 'aaaaa')
        expect(user).not_to be_valid
      end
      it '大文字が入っていてはならない' do
        user = FactoryBot.build(:user, display_name: 'aaaaaａ')
        expect(user).not_to be_valid
      end
      it '半角大文字が入っていてはならない' do
        user = FactoryBot.build(:user, display_name: 'aaaaaA')
        expect(user).not_to be_valid
      end
    end
  end
  describe 'アソシエーションテスト' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:livehouse) { FactoryBot.create(:livehouse) }
    let!(:event) { FactoryBot.create(:event, livehouse: livehouse) }
    context 'userが削除された場合' do
      it '関連付けられたfavoriteも削除される' do
        FactoryBot.create(:favorite, user_id: user.id, livehouse_id: livehouse.id)
        expect { user.destroy }.to change { Favorite.count }.by(-1)
      end
      it '関連付けられたcommentも削除される' do
        FactoryBot.create(:comment, user_id: user.id, event_id: event.id)
        expect { user.destroy }.to change { Comment.count }.by(-1)
      end
      it '関連付けられたjoinも削除される' do
        FactoryBot.create(:join, user_id: user.id, event_id: event.id)
        expect { user.destroy }.to change { Join.count }.by(-1)
      end
    end
  end
end
