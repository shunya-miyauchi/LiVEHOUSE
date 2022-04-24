require 'rails_helper'

RSpec.describe 'イベント参加記録', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:livehouse) { FactoryBot.create(:livehouse) }
  let!(:event) { FactoryBot.create(:event, livehouse: livehouse) }
  let!(:event_second) { FactoryBot.create(:event_second, livehouse: livehouse) }
  let!(:event_third) { FactoryBot.create(:event_third, livehouse: livehouse) }
  describe 'イベント参加登録機能' do
    before do
      travel_to Time.zone.local(2022, 1, 3)
    end
    context 'ログインしている場合' do
      before do
        sign_in user
        visit livehouse_events_path(livehouse)
      end
      context 'イベント参加ボタンを押した場合' do
        before do
          all("#join_#{event.id} .join")[0].click
        end
        it '非同期でボタン表示が変わる' do
          expect(page).to have_selector "#join_#{event.id}", text: '不参加'
        end
        it 'joinsテーブルに登録される' do
          sleep 0.1
          expect(Join.where(user_id: user.id).size).to eq 1
        end
      end
      context 'イベント不参加ボタンを押した場合' do
        before do
          FactoryBot.create(:join, user_id: user.id, event_id: event.id)
          visit current_path
          all("#join_#{event.id} .unjoin")[0].click
        end
        it '非同期でボタン表示が変わる' do
          expect(page).to have_selector "#join_#{event.id}", text: '参加'
        end
        it 'joinsテーブルから削除される' do
          sleep 0.1
          expect(Join.where(user_id: user.id).size).to eq 0
        end
      end
    end
    context 'ログインしていない場合' do
      before do
        visit livehouse_events_path(livehouse)
      end
      it 'お気に入りボタンは表示されない' do
        expect(page).not_to have_content '参加'
        expect(page).not_to have_content '不参加'
      end
    end
  end

  describe '登録イベント参照機能(ライブ予定)' do
    before do
      travel_to Time.zone.local(2022, 1, 10)
      sign_in user
    end
    context 'イベントを登録している場合' do
      let!(:join) { FactoryBot.create(:join, user_id: user.id, event_id: event.id) }
      let!(:join_second) { FactoryBot.create(:join, user_id: user.id, event_id: event_second.id) }
      before do
        visit user_path(user)
      end
      it '登録したイベントだけが表示される' do
        expect(page).to have_content 'タイトル２'
        expect(page).not_to have_content 'タイトル３'
      end
      it '過去のイベントは表示されない' do
        expect(page).not_to have_content 'タイトル１'
      end
      it 'イベント参加を外すと、一覧から消える' do
        all("#join_#{event_second.id} .unjoin")[0].click
        visit current_path
        expect(page).not_to have_content 'タイトル２'
      end
    end
    context 'イベントを登録していない場合' do
      it '参加予定のイベントがない旨が表示される' do
        visit user_path(user)
        expect(page).to have_content '参加予定のイベントはありません。'
      end
    end
  end
end
