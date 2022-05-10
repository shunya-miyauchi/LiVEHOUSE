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
        travel_to Time.zone.local(2022, 1, 3)
        sign_in user
        visit livehouse_events_path(livehouse)
      end
      context 'お気に入りボタンを押した場合' do
        before do
          select '東京都/ 下北沢周辺', from: 'livehouse_search[place_id_eq]'
          find('.livehouse_search').click_button '検索'
          all("#favorite_#{livehouse.id}")[0].click_on 'favorite_border'
        end
        it '非同期でボタン表示が変わる' do
          expect(page).to have_selector 'li', text: 'favorite'
          expect(page).not_to have_selector 'li', text: 'favorite_border'
        end
        it 'favoritesテーブルに登録される' do
          sleep 0.1
          expect(Favorite.where(user_id: user.id).count).to eq 1
        end
      end
      context '外すボタンを押した場合' do
        before do
          FactoryBot.create(:favorite, user_id: user.id, livehouse_id: livehouse.id)
          visit current_path
          select '東京都/ 下北沢周辺', from: 'livehouse_search[place_id_eq]'
          find('.livehouse_search').click_button '検索'
        end
        it '非同期でボタン表示が変わる' do
          all("#favorite_#{livehouse.id}")[0].click_link 'favorite'
          expect(page).to have_selector 'li', text: 'favorite_border'
        end
        it 'favoritesテーブルから削除される' do
          all("#favorite_#{livehouse.id}")[0].click_link 'favorite'
          expect(page).to have_selector 'li', text: 'favorite_border'
          sleep 0.1
          expect(Favorite.where(user_id: user.id).count).to eq 0
        end
      end
    end
    context 'ログインしていない場合' do
      before do
        visit root_path
      end
      it 'お気に入りボタンは表示されない' do
        expect(page).not_to have_content 'favorite_border'
        expect(page).not_to have_content 'favorite'
      end
    end
  end

  describe 'お気に入り一覧表示機能' do
    before do
      travel_to Time.zone.local(2022, 1, 3)
      sign_in user
    end
    context 'お気に入りが登録されている場合' do
      let!(:favorite) { FactoryBot.create(:favorite, user_id: user.id, livehouse_id: livehouse.id) }
      let!(:favorite_second) { FactoryBot.create(:favorite, user_id: user.id, livehouse_id: livehouse_second.id) }
      before do
        visit favorites_path
      end
      it 'お気に入りのライブハウス一覧が表示される' do
        expect(page).to have_content '下北沢BASEMENT BAR'
        expect(page).to have_content 'Spotify O-nest'
      end
      it 'お気に入りライブハウスのスケジュールが参照できる' do
        visit favorites_path
        expect(page).to have_content 'タイトル１'
        expect(page).to have_content 'タイトル２'
      end
      it 'お気に入りを外すと、一覧から消える' do
        all("#favorite_#{livehouse.id}")[0].click_link 'favorite'
        visit current_path
        expect(page).not_to have_content '下北沢BASEMENT BAR'
        expect(page).to have_content 'Spotify O-nest'
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
