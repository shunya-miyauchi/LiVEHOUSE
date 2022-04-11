require 'rails_helper'

RSpec.describe 'お気に入り', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:livehouse) { FactoryBot.create(:livehouse) }
  let!(:livehouse_second) { FactoryBot.create(:livehouse_second) }  
  let!(:event) { FactoryBot.create(:event, livehouse: livehouse) }
  let!(:event_second) { FactoryBot.create(:event_second, livehouse: livehouse) }
  let!(:event_fourth) { FactoryBot.create(:event_fourth, livehouse: livehouse_second) }
  describe 'お気に入り登録機能' do
    context 'ログインしている場合' do
      before do
        sign_in user
        visit root_path
      end
      context 'お気に入りボタンを押した場合', js: true do
        before do
        end
        it '非同期でボタン表示が変わる' do
          all("#favorite_#{livehouse.id}")[0].click_link 'お気に入り'
          expect(page).not_to have_selector 'li', text: 'お気に入り'
          expect(page).to have_selector 'li', text: '外す'
        end
        it 'favoritesテーブルに登録される' do
          all("#favorite_#{livehouse.id}")[0].click_link 'お気に入り'
          expect(page).to have_selector 'li', text: '外す'
          expect(Favorite.where(user_id: user.id).count).to eq 1
        end
      end
      context '外すボタンを押した場合', js: true do
        before do
          FactoryBot.create(:favorite, user_id: user.id, livehouse_id: livehouse.id)
          visit current_path
        end
        it '非同期でボタン表示が変わる' do
          all("#favorite_#{livehouse.id}")[0].click_link '外す'
          expect(page).not_to have_selector 'li', text: '外す'
          expect(page).to have_selector 'li', text: 'お気に入り'
        end
        it 'favoritesテーブルから削除される' do
          all("#favorite_#{livehouse.id}")[0].click_link '外す'
          expect(page).to have_selector 'li', text: 'お気に入り'
          expect(Favorite.where(user_id: user.id).count).to eq 0
        end
      end
    end
    context 'ログインしていない場合' do
      it 'お気に入りボタンは表示されない' do
        expect(page).not_to have_selector 'li', text: 'お気に入り'
        expect(page).not_to have_selector 'li', text: '外す'
      end
    end
  end

  describe 'お気に入り一覧表示機能' do
    before do
      travel_to Time.zone.local(2022, 1, 3)
      sign_in user
    end
    context 'お気に入りが登録されている場合' do
      let!(:favorite) {FactoryBot.create(:favorite, user_id: user.id, livehouse_id: livehouse.id)}
      let!(:favorite_second) {FactoryBot.create(:favorite, user_id: user.id, livehouse_id: livehouse_second.id)}
      before do
        visit favorites_path
      end
      it 'お気に入りのライブハウス一覧が表示される' do
        expect(page).to have_content '下北沢BASEMENT BAR'
        expect(page).to have_content '心斎橋Pangea'
      end
      it 'お気に入りライブハウスのスケジュールが参照できる' do
        visit favorite_path(livehouse.id)
        expect(page).to have_content 'タイトル１'
        expect(page).to have_content 'タイトル２'
      end
      it 'お気に入りを外すと、一覧から消える' do
        all("#favorite_#{livehouse.id}")[0].click_link '外す'
        visit current_path
        expect(page).not_to have_content '下北沢BASEMENT BAR'
        expect(page).to have_content '心斎橋Pangea'
      end
    end
    context 'お気に入りが登録されていない場合' do
      it '登録されていない旨が表示される' do
        visit favorites_path
        expect(page).to have_content 'お気に入り登録して下さい。'
      end
    end
  end
end