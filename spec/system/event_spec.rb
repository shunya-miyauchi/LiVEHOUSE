require 'rails_helper'

RSpec.describe 'イベント管理', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:user_second) { FactoryBot.create(:user_second) }
  let!(:livehouse) { FactoryBot.create(:livehouse) }
  let!(:livehouse_second) { FactoryBot.create(:livehouse_second) }
  let!(:event) { FactoryBot.create(:event, livehouse: livehouse) }
  let!(:event_second) { FactoryBot.create(:event_second, livehouse: livehouse) }
  let!(:event_third) { FactoryBot.create(:event_third, livehouse: livehouse) }
  let!(:event_fourth) { FactoryBot.create(:event_fourth, livehouse: livehouse_second) }
  # describe -  テスト対象の機能や処理
  # context - 条件の概要、文脈や状況、条件分岐、〜の場合
  # it - 確認したいことを書く
  describe 'イベント一覧画面' do
    before do
      travel_to Time.zone.local(2022, 1, 3)
    end
    context 'ログインしている場合' do
      before do
        sign_in user
        visit livehouse_events_path(livehouse)
      end
      it 'ライブハウスのスケジュール一覧が表示される' do
        expect(page).to have_content 'ログアウト'
        expect(page).to have_content 'タイトル１'
        expect(page).to have_content 'タイトル２'
        expect(page).not_to have_content 'タイトル４'
      end
    end
    context 'ログインしていない場合' do
      before do
        visit livehouse_events_path(livehouse)
      end
      it 'ライブハウスのスケジュール一覧が表示される' do
        expect(page).to have_content 'ログイン'
        expect(page).to have_content 'タイトル１'
        expect(page).to have_content 'タイトル２'
        expect(page).not_to have_content 'タイトル４'
      end
    end
  end
  describe 'イベント詳細画面' do
    before do
      travel_to Time.zone.local(2022, 1, 3)
    end
    context 'ログインしている場合' do
      before do
        sign_in user
        visit livehouse_event_path(livehouse,event)
      end
      it 'イベント詳細を確認できる' do
        expect(page).to have_content 'ログアウト'
        expect(page).to have_content 'タイトル１'
        expect(page).to have_content '18:00 ／ 18:30'
        expect(page).to have_content '2000円'
        expect(page).to have_content 'あああ'
      end
    end
    context 'ログインしてない場合' do
      before do
        visit livehouse_event_path(livehouse,event)
      end
      it 'イベント詳細を確認できる' do
        expect(page).to have_content 'ログイン'
        expect(page).to have_content 'タイトル１'
        expect(page).to have_content '2000円'
        expect(page).to have_content 'あああ'
      end
    end
  end

  describe 'イベントコメント投稿機能' do
    before do
      FactoryBot.create(:comment, user_id: user.id, event_id: event.id)
      FactoryBot.create(:comment_second, user_id: user_second.id, event_id: event.id)
    end
    context 'ログインしている場合' do
      before do
        sign_in user
        visit livehouse_event_path(livehouse, event)
      end
      it 'コメント一覧が表示される' do
        expect(page).to have_selector '.comments_area', text: 'コメント１'
        expect(page).to have_selector '.comments_area', text: 'コメント２'
      end
      it 'コメント投稿フォームが表示される' do
        expect(page).to have_button '投稿'
      end
      it '投稿すると、非同期でコメント一覧に入力される', js: true do
        fill_in 'コメント入力', with: 'コメント３'
        click_button '投稿'
        expect(page).to have_selector '.comments_area', text: 'コメント３'
      end
    end
    context 'ログインしてない場合' do
      before do
        visit livehouse_event_path(livehouse, event)
      end
      it 'コメント一覧が表示される' do
        expect(page).to have_selector '.comments_area', text: 'コメント１'
        expect(page).to have_selector '.comments_area', text: 'コメント２'
      end
      it 'コメント投稿フォームが表示されない' do
        expect(page).not_to have_button '投稿'
      end
    end
  end
end
