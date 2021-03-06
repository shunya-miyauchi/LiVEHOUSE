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
                                content: 'あああ')
        expect(blog).not_to be_valid
      end
    end
  end

  describe 'scopeテスト' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:livehouse) { FactoryBot.create(:livehouse) }
    let!(:event) { FactoryBot.create(:event, livehouse: livehouse) }
    let!(:event_second) { FactoryBot.create(:event_second, livehouse: livehouse) }
    let!(:event_third) { FactoryBot.create(:event_third, livehouse: livehouse) }
    before do
      FactoryBot.create(:blog, user: user, event: event)
      FactoryBot.create(:blog_second, user: user, event: event_second)
      FactoryBot.create(:blog_third, user: user, event: event_third)
    end
    context ':reverse_event_held_on' do
      it 'イベント開催日の降順に並びかわる' do
        blogs = Blog.includes(:event).reverse_event_held_on
        expect(blogs.first.title).to eq 'タイトルう'
        expect(blogs.last.title).to eq 'タイトルあ'
      end
    end
  end
end
