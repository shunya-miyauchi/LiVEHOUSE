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
        fill_in "名前",with: "たかはし"
        fill_in "ユーザー名",with: "takahashi"
        fill_in "メールアドレス",with: "aaa@gmail.com"
        fill_in "パスワード",with: "123456"
        fill_in "パスワード(確認用)",with: "123456"
        click_on "アカウント登録"
        expect(page).to have_content "下北沢BASEMENT BAR"
        expect(User.where(email: "aaa@gmail.com").count).to eq 1
      end
    end
    context '会員登録時、アドレスを入力しなかった場合' do
      it 'エラーメッセージが表示され、登録できない' do
        visit new_user_registration_path
        fill_in "名前",with: "たかはし"
        fill_in "ユーザー名",with: "takahashi"
        fill_in "メールアドレス",with: ""
        fill_in "パスワード",with: "123456"
        fill_in "パスワード(確認用)",with: "123456"
        click_on "アカウント登録"
        expect(page).to have_content "メールアドレスを入力してください"
        expect(page).to have_content "新規登録"
      end
    end
    context '会員登録時、パスワードを入力しなかった場合' do
      it 'エラーメッセージが表示され、登録できない' do
        visit new_user_registration_path
        fill_in "名前",with: "たかはし"
        fill_in "ユーザー名",with: "takahashi"
        fill_in "メールアドレス",with: "aaa@gmail.com"
        fill_in "パスワード",with: ""
        fill_in "パスワード(確認用)",with: ""
        click_on "アカウント登録"
        expect(page).to have_content "パスワードを入力してください"
        expect(page).to have_content "新規登録"
      end
    end
  end

  describe 'ログイン機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:user_second) { FactoryBot.create(:user_second) }
    context 'ログインに成功した場合' do
      it 'トップ画面に遷移する' do
        visit new_user_session_path
        fill_in "メールアドレス",with: "aaa@gmail.com"
        fill_in "パスワード",with: "123456"
        click_button "ログイン"
        expect(page).to have_content "下北沢BASEMENT BAR"
      end
    end
    context '登録されてないアカウントでログインした場合' do
      it 'エラーメッセージが表示され、ログインできない' do
        visit new_user_session_path
        fill_in "メールアドレス",with: "bbb@gmail.com"
        fill_in "パスワード",with: "654321"
        click_button "ログイン"
        expect(page).to have_content "メールアドレスまたはパスワードが違います。"
        expect(page).to have_content "ログイン"
      end
    end
    
  end
end
