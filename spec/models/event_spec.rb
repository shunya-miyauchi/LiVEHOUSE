require 'rails_helper'

RSpec.describe Event, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let!(:livehouse) { FactoryBot.create(:livehouse) }
  let!(:event) { FactoryBot.create(:event, livehouse: livehouse) }
  let!(:event_second) { FactoryBot.create(:event_second, livehouse: livehouse) }
  let!(:event_third) { FactoryBot.create(:event_third, livehouse: livehouse) }
  let!(:event_fourth) { FactoryBot.create(:event_fourth, livehouse: livehouse) }
  before do
    travel_to Time.zone.local(2022, 1, 10)
  end
  describe 'アソシエーションテスト' do
    context 'eventが削除された場合' do
      it '関連付けられたcommentも削除される' do
        FactoryBot.create(:comment, user_id: user.id, event_id: event.id)
        expect { event.destroy }.to change { Comment.count }.by(-1)
      end
    end
  end

  describe 'scopeテスト' do
    context ':date_after_today' do
      it '開催日が今日以降' do
        events = Event.date_after_today
        expect(events).to include(event_second,event_third,event_fourth)
        expect(events).not_to include(event)
      end
    end
    context ':this_week' do
      it '開催日が今週(今日以降)' do
        events = Event.this_week
        expect(events).to include(event_second)
        expect(events).not_to include(event,event_third,event_fourth)
      end
    end
    context ':date_before_today' do
      it '開催日が今日より前' do
        events = Event.date_before_today
        expect(events).to include(event)
        expect(events).not_to include(event_second,event_third,event_fourth)
      end
    end
    context ':next_week' do
      it '開催日が来週' do
        events = Event.next_week
        expect(events).to include(event_third)
        expect(events).not_to include(event,event_second,event_fourth)
      end
    end
    context ':after_next_week' do
      it '開催日が再来週以降' do
        events = Event.after_next_week
        expect(events).to include(event_fourth)
        expect(events).not_to include(event,event_second,event_third)
      end
    end
    context ':sort_held_on' do
      it '開催日順の昇順並にびかわる' do
        events = Event.sort_held_on
        expect(events.first.title).to eq 'タイトル１'
        expect(events.last.title).to eq 'タイトル４'
      end
    end
    context ':reverse_held_on' do
      it '開催日順の降順に並びかわる' do
        events = Event.reverse_held_on
        expect(events.first.title).to eq 'タイトル４'
        expect(events.last.title).to eq 'タイトル１'
      end
    end
  end
end
