require 'rails_helper'

RSpec.describe 'アイコン画像', type: :system do
  before do
    IconUploader.enable_processing = true
  end
  after do
    IconUploader.enable_processing = false
  end

  describe 'アイコン新規登録機能' do
    it '新規登録で画像をアップできる' do
      visit new_user_registration_path
      fill_in '名前', with: 'たかはし'
      fill_in 'ユーザー名', with: 'takahashi'
      fill_in 'メールアドレス', with: 'aaa@gmail.com'
      fill_in 'パスワード', with: '123456'
      fill_in 'パスワード(確認用)', with: '123456'
      attach_file 'アイコン画像(jpg,jpeg,gif,png)', "#{Rails.root}/spec/factories/images/qujila-flower.png"
      click_on 'アカウント登録'
      expect(page).to have_content 'アカウント登録が完了しました'
      expect(User.where(email: 'aaa@gmail.com').count).to eq 1
      expect(User.where(image: 'qujila-flower.png').count).to eq 1
    end
  end

  describe 'アイコン表示機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:user_third) { FactoryBot.create(:user_third) }
    context '新規登録時に画像をアップしている場合' do
      before do
        sign_in user
      end
      it 'マイページにサムネイル画像が表示される' do
        visit user_path(user.id)
        expect(page).to have_content 'たかはし'
        expect(page).to have_content 'takahashi'
        expect(page).to have_selector("img[src$='qujila-flower.png']")
      end
    end
    context '新規登録時に画像をアップしていない場合' do
      before do
        sign_in user_third
      end
      it 'マイページにデフォルト画像が表示される' do
        visit user_path(user_third.id)
        expect(page).to have_content 'みやうち'
        expect(page).to have_content 'miyauchi'
        expect(page).to have_selector("img[src$='default-1e215dac65db0fa532531ae55a6a85e90729a2a4356099e4a024c0639a3eecf4.png']")
      end
    end
  end

  describe 'アイコン編集機能' do
    let!(:user) { FactoryBot.create(:user) }
    it 'アイコン画像を編集できる' do
      sign_in user
      visit user_path(user.id)
      click_on '編集'
      attach_file 'アイコン画像(jpg,jpeg,gif,png)', "#{Rails.root}/spec/factories/images/ushibeaf.png"
      click_on '更新'
      expect(page).to have_content 'たかはし'
      expect(page).to have_content 'takahashi'
      expect(page).to have_selector("img[src$='ushibeaf.png']")
      expect(page).not_to have_selector("img[src$='qujila-flower.png']")
    end
  end
end
