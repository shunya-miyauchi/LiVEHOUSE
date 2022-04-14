require 'rails_helper'

RSpec.describe 'ライブハウス情報管理', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:livehouse) { FactoryBot.create(:livehouse) }
  # describe -  テスト対象の機能や処理
  # context - 条件の概要、文脈や状況、条件分岐、〜の場合
  # it - 確認したいことを書く
  describe 'ライブハウス情報画面' do
    context 'ログインしている場合' do
      before do
        sign_in user
        visit livehouse_events_path(livehouse)
      end
      it 'ライブハウス情報を確認できる' do
        click_on 'ライブハウス情報'
        expect(page).to have_content 'ログアウト'
        expect(page).to have_content '下北沢BASEMENT BAR'
        expect(page).to have_content '東京都世田谷区代沢5-18-1'
      end
      it 'google mapで場所が確認できる' do
        click_on 'ライブハウス情報'
        expect(page).to have_css '#map'
      end
    end
    context 'ログインしていない場合' do
      before do
        visit livehouse_events_path(livehouse)
      end
      it 'ライブハウス情報を確認できる' do
        click_on 'ライブハウス情報'
        expect(page).to have_content 'ログイン'
        expect(page).to have_content '下北沢BASEMENT BAR'
        expect(page).to have_content '東京都世田谷区代沢5-18-1'
      end
      it 'google mapで場所が確認できる' do
        click_on 'ライブハウス情報'
        expect(page).to have_css '#map'
      end
    end
  end
end
