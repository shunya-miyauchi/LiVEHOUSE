require 'rails_helper'

RSpec.describe 'ライブハウス情報管理', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:livehouse) { FactoryBot.create(:livehouse) }
  let!(:livehouse_second) { FactoryBot.create(:livehouse_second) }
  let!(:event) { FactoryBot.create(:event, livehouse: livehouse) }
  let!(:event_second) { FactoryBot.create(:event_second, livehouse: livehouse_second) }
  # describe -  テスト対象の機能や処理
  # context - 条件の概要、文脈や状況、条件分岐、〜の場合
  # it - 確認したいことを書く
  describe 'ライブハウス情報表示' do
    context 'ログインしている場合' do
      before do
        sign_in user
        visit livehouse_event_path(livehouse,event)
      end
      it 'ライブハウス情報を確認できる' do
        find("#livehouse-tab").click
        expect(page).to have_content 'ログアウト'
        expect(page).to have_content '下北沢BASEMENT BAR'
        expect(page).to have_content '東京都世田谷区代沢5-18-1'
      end
      it 'google mapで場所が確認できる' do
        find("#livehouse-tab").click
        expect(page).to have_css '#map'
      end
    end
    context 'ログインしていない場合' do
      before do
        visit livehouse_event_path(livehouse,event)
      end
      it 'ライブハウス情報を確認できる' do
        find("#livehouse-tab").click
        expect(page).to have_content 'ログイン'
        expect(page).to have_content '下北沢BASEMENT BAR'
        expect(page).to have_content '東京都世田谷区代沢5-18-1'
      end
      it 'google mapで場所が確認できる' do
        find("#livehouse-tab").click
        expect(page).to have_css '#map'
      end
    end
  end

  describe 'ライブハウス検索機能' do
    context 'トップページの場合' do
      before do
        travel_to Time.zone.local(2022, 1, 3)
        sign_in user
        visit root_path
      end
      context '地域を選択し、検索する' do
        before do
          select '東京都/ 下北沢周辺', from: 'q[place_id_eq]'
          find(".livehouse_search").click_button "検索"
        end
        it 'その地域のライブハウス名が表示される' do
          expect(page).to have_content '下北沢BASEMENT BAR'
          expect(page).not_to have_content 'Spotify O-nest'
        end
      end
      context '検索されたライブハウス名をクリックする' do
        before do
          select '東京都/ 下北沢周辺', from: 'q[place_id_eq]'
          find(".livehouse_search").click_button "検索"
          click_link '下北沢BASEMENT BAR'
        end
        it 'そのライブハウスのスケジュールが表示される' do
          expect(page).to have_content 'タイトル１'
          expect(page).to have_content 'あああ / あああ'
        end
      end
    end
    context 'ライブハウスページの場合' do
      before do
        travel_to Time.zone.local(2022, 1, 3)
        sign_in user
        visit livehouse_events_path(livehouse)
      end
      context '地域を選択し、検索する' do
        before do
          select '東京都/ 渋谷•原宿周辺', from: 'q_livehouse[place_id_eq]'
          find(".livehouse_search").click_button "検索"
        end
        it 'その地域のライブハウス名が表示される' do
          expect(page).not_to have_selector '#livehouses_area', text: '下北沢BASEMENT BAR'
          expect(page).to have_selector '#livehouses_area', text:'Spotify O-nest'
        end
      end
      context '検索されたライブハウス名をクリックする' do
        before do
          select '東京都/ 渋谷•原宿周辺', from: 'q_livehouse[place_id_eq]'
          find(".livehouse_search").click_button "検索"
          click_link 'Spotify O-nest'
        end
        it 'そのライブハウスのスケジュールが表示される' do
          expect(page).not_to have_selector '.card_title', text: 'タイトル２'
        end
      end
    end
    context 'ブログページの場合' do
      before do
        travel_to Time.zone.local(2022, 1, 3)
        sign_in user
        visit blogs_path
      end
      context '地域を選択し、検索する' do
        before do
          select '東京都/ 下北沢周辺', from: 'q[place_id_eq]'
          find(".livehouse_search").click_button "検索"
        end
        it 'その地域のライブハウス名が表示される' do
          expect(page).to have_content '下北沢BASEMENT BAR'
          expect(page).not_to have_content 'Spotify O-nest'
        end
      end
      context '検索されたライブハウス名をクリックする' do
        before do
          select '東京都/ 下北沢周辺', from: 'q[place_id_eq]'
          find(".livehouse_search").click_button "検索"
          click_link '下北沢BASEMENT BAR'
        end
        it 'そのライブハウスのスケジュールが表示される' do
          expect(page).to have_content 'タイトル１'
          expect(page).to have_content 'あああ / あああ'
        end
      end
    end
  end
end
