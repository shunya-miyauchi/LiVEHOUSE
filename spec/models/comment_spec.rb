require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "バリデーションテスト" do
    let!(:user) { FactoryBot.create(:user) }
    let!(:livehouse) { FactoryBot.create(:livehouse) }
    let!(:event) { FactoryBot.create(:event, livehouse: livehouse) }
    context 'contentカラム' do
      it '空欄である' do
        comment = FactoryBot.build(:comment, 
          user_id: user.id, 
          event_id: event.id,
          content: ""
        )
        expect(comment).not_to be_valid
      end
    end
  end
end