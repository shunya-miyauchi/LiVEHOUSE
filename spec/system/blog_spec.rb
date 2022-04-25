require 'rails_helper'

RSpec.describe 'ブログ機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:livehouse) { FactoryBot.create(:livehouse) }
  let!(:event) { FactoryBot.create(:event, livehouse: livehouse) }
  let!(:event_second) { FactoryBot.create(:event_second, livehouse: livehouse) }
  let!(:event_third) { FactoryBot.create(:event_third, livehouse: livehouse) }
  let!(:blog) { FactoryBot.create(:blog, user: user, event: event) }
  before do
    sign_in user
  end
  describe '一覧表示機能' do
    before do
      FactoryBot.create(:blog_second, user: user, event: event_second)
      FactoryBot.create(:blog_third, user: user, event: event_third)
      visit blogs_path
    end
    it 'ブログ一覧が表示される' do
      expect(page).to have_content 'タイトルあ'
      expect(page).to have_content 'タイトルい'
      expect(page).to have_content 'タイトルう'
    end
    it '最新のブログが一番上に表示される' do
      expect(all('.card_header .title a')[0].text).to eq 'タイトルう'
      expect(all('.card_header .title a')[1].text).to eq 'タイトルい'
    end
  end

  describe '新規投稿機能' do
    before do
      travel_to Time.zone.local(2022, 1, 10)
      FactoryBot.create(:join, user_id: user.id, event_id: event.id)
      sign_in user
      visit new_blog_path
    end
    context '新規投稿した場合' do
      before do
        select 'タイトル１', from: 'blog[event_id]'
        fill_in 'タイトル',	with: 'ブログ１'
        fill_in '本文',	with: '本文１'
        attach_file('画像選択', "#{Rails.root}/spec/factories/images/qujila-flower.png", make_visible: true)
        find('.submit_btn').click
      end
      it '一覧ページに遷移する' do
        expect(page).to have_content 'ブログ１'
        expect(page).to have_content 'タイトルあ'
      end
    end
    context '投稿に失敗した場合' do
      before do
        find('.submit_btn').click
      end
      it '保存できませんとメッセージが表示される' do
        expect(page).to have_content 'タイトルを入力してください'
      end
    end
  end

  describe '画像投稿機能' do
    before do
      travel_to Time.zone.local(2022, 1, 10)
      FactoryBot.create(:join, user_id: user.id, event_id: event.id)
      sign_in user
    end
    context '複数画像を投稿した場合' do
      before do
        visit new_blog_path
        select 'タイトル１', from: 'blog[event_id]'
        fill_in 'タイトル',	with: 'ブログ１'
        fill_in '本文',	with: '本文１'
        attach_file('画像選択', [
                      "#{Rails.root}/spec/factories/images/qujila-flower.png",
                      "#{Rails.root}/spec/factories/images/ushibeaf.png"
                    ], make_visible: true)
        find('.submit_btn').click
      end
      it '一覧ページへ遷移する' do
        expect(page).to have_content 'ブログ１'
        expect(page).to have_content 'タイトルあ'
      end
    end
    context '詳細画面の場合' do
      let!(:blog_third) { FactoryBot.create(:blog_third, user: user, event: event_third) }
      before do
        visit blog_path(blog_third)
      end
      it '複数枚の画像表示される' do
        expect(page).to have_selector("img[src$='qujila-flower.png']")
        expect(page).to have_selector("img[src$='ushibeaf.png']")
      end
    end
  end

  describe '編集機能' do
    before do
      travel_to Time.zone.local(2022, 1, 18)
      FactoryBot.create(:join, user_id: user.id, event_id: event_second.id)
      FactoryBot.create(:join, user_id: user.id, event_id: event.id)
      sign_in user
      visit edit_blog_path(blog)
    end
    context 'イベントを修正した場合' do
      before do
        select 'タイトル２', from: 'blog[event_id]'
        find('.submit_btn').click
      end
      it '一覧でのイベント名が変更になる' do
        expect(page).to have_content 'タイトル２'
        expect(page).not_to have_content 'タイトル１'
      end
    end
    context 'タイトルを修正した場合' do
      before do
        fill_in 'タイトル',	with: '修正しました'
        find('.submit_btn').click
      end
      it '一覧でのタイトルが変更になる' do
        expect(page).to have_content '修正しました'
        expect(page).not_to have_content 'タイトルあ'
      end
    end
    context '本文を修正した場合' do
      before do
        select 'タイトル１', from: 'blog[event_id]'
        fill_in '本文',	with: '修正しました'
        find('.submit_btn').click
      end
      it '詳細画面での本文が変更になる' do
        expect(page).to have_content '修正しました'
        expect(page).not_to have_content '本文あ'
      end
    end
    context '画像を修正した場合' do
      before do
        select 'タイトル１', from: 'blog[event_id]'
        attach_file('画像選択', "#{Rails.root}/spec/factories/images/ushibeaf.png", make_visible: true)
        find('.submit_btn').click
      end
      it '詳細画面での画像が変更になる' do
        visit blog_path(blog)
        expect(page).to have_selector("img[src$='ushibeaf.png']")
      end
    end
  end

  describe '削除機能' do
    before do
      sign_in user
    end
    context '一覧画面で削除した場合' do
      before do
        visit blogs_path
        all('.dropdown .material-icons')[0].click
        all('.dropdown .delete')[0].click
      end
      it '一覧からブログが削除される' do
        expect(Blog.where(user_id: user.id).size).to eq 0
      end
    end
  end
end
