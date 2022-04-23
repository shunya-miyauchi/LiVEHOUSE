require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'バリデーションテスト' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:livehouse) { FactoryBot.create(:livehouse) }
    let!(:event) { FactoryBot.create(:event, livehouse: livehouse) }
    context 'contentカラム' do
      it '空欄である' do
        comment = FactoryBot.build(:comment,
                                   user_id: user.id,
                                   event_id: event.id,
                                   content: '')
        expect(comment).not_to be_valid
      end
    end
  end
  describe 'scopeテスト' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:livehouse) { FactoryBot.create(:livehouse) }
    let!(:event) { FactoryBot.create(:event, livehouse: livehouse) }
    before do
      FactoryBot.create(:comment, user_id: user.id, event_id: event.id)
      FactoryBot.create(:comment_second, user_id: user.id, event_id: event.id)
      FactoryBot.create(:comment_third, user_id: user.id, event_id: event.id)
    end
    context ':reverse_created_at' do
      it '新しく作成された順に並びかわる' do
        comments = Comment.reverse_created_at
        expect(comments.first.content).to eq 'コメント３'
        expect(comments.last.content).to eq 'コメント１'
      end
    end
  end
end
