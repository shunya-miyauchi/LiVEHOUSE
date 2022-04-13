require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'アソシエーションテスト' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:livehouse) { FactoryBot.create(:livehouse) }
    let!(:event) { FactoryBot.create(:event, livehouse: livehouse) }
    context 'eventが削除された場合' do
      it '関連付けられたcommentも削除される' do
        FactoryBot.create(:comment, user_id: user.id, event_id: event.id)
        expect { event.destroy }.to change { Comment.count }.by(-1)
      end
    end
  end
end
