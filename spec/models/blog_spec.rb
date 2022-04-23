require 'rails_helper'

RSpec.describe Blog, type: :model do
  describe 'バリデーションテスト' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:livehouse) { FactoryBot.create(:livehouse) }
    let!(:event) { FactoryBot.create(:event, livehouse: livehouse) }
    context 'titleカラム' do
      it '空欄である' do
        blog = FactoryBot.build(:blog,
                                user_id: user.id,
                                event_id: event.id,
                                title: '',
                                content: 'あああ'
                              )
        expect(blog).not_to be_valid
      end
    end
  end
end