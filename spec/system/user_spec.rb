require 'rails_helper'

RSpec.describe 'ユーザー管理', type: :system do
  let!(:livehouse) { FactoryBot.create(:livehouse) }
  let!(:livehouse_second) { FactoryBot.create(:livehouse_second) }
  let!(:event) { FactoryBot.create(:event, livehouse: livehouse) }
  let!(:event_second) { FactoryBot.create(:event_second, livehouse: livehouse) }
  let!(:event_third) { FactoryBot.create(:event_third, livehouse: livehouse) }
  let!(:event_fourth) { FactoryBot.create(:event_fourth, livehouse: livehouse_second) }
  describe '新規会員登録機能' do
    context '会員登録した場合' do
      it 'トップ画面に遷移する' do
        visit new_user_registration_path
        fill_in '名前', with: 'たかはし'
        fill_in 'ユーザー名', with: 'takahashi'
        fill_in 'メールアドレス', with: 'aaa@gmail.com'
        fill_in 'パスワード', with: '123456'
        fill_in 'パスワード(確認用)', with: '123456'
        click_on 'アカウント登録'
        expect(page).to have_content 'アカウント登録が完了しました。'
        expect(User.where(email: 'aaa@gmail.com').count).to eq 1
      end
    end
  end

  describe 'ログイン機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:user_second) { FactoryBot.create(:user_second) }
    context 'ログインに成功した場合' do
      it 'トップ画面に遷移する' do
        visit new_user_session_path
        fill_in 'メールアドレス', with: 'aaa@gmail.com'
        fill_in 'パスワード', with: '123456'
        click_button 'ログイン'
        expect(page).to have_content 'ログインしました。'
      end
    end
    context '登録されてないアカウントでログインした場合' do
      it 'エラーが表示され、ログインできない' do
        visit new_user_session_path
        fill_in 'メールアドレス', with: 'bbb@gmail.com'
        fill_in 'パスワード', with: '654321'
        click_button 'ログイン'
        expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
        expect(page).to have_content 'ログイン'
      end
    end
  end

  describe '管理ユーザー機能' do
    let!(:user) { FactoryBot.create(:user, admin: true) }
    let!(:user_second) { FactoryBot.create(:user_second) }
    context '管理ユーザーの場合' do
      before do
        sign_in user
      end
      it '管理画面に遷移できる' do
        visit rails_admin_path
        expect(current_path).to eq rails_admin_path
      end
    end
    context '一般ユーザーの場合' do
      before do
        sign_in user_second
      end
      it '管理画面にアクセスできない' do
        expect(current_path).not_to eq rails_admin_path
      end
    end
  end
end
