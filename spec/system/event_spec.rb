require 'rails_helper'

RSpec.describe '参照機能(非ユーザー)', type: :system do
  let!(:livehouse){ FactoryBot.create(:livehouse) }
  let!(:livehouse_second){ FactoryBot.create(:livehouse_second) }
  let!(:livehouse_third){ FactoryBot.create(:livehouse_third) }
  let!(:event){ FactoryBot.create(:event,livehouse: livehouse)}
  let!(:event_second){ FactoryBot.create(:event_second,livehouse: livehouse)}
  let!(:event_third){ FactoryBot.create(:event_third,livehouse: livehouse_second)}
  let!(:event_fourth){ FactoryBot.create(:event_fourth,livehouse: livehouse_third)}

  describe "スケジュール参照機能" do
    context "ライブハウス名を押した場合" do
      it "スケジュール一覧が表示される" do
        visit livehouses_path
        click_on "下北沢BASEMENT BAR"
        expect(page).to have_content "タイトル１"
        expect(page).to have_content "タイトル２"
      end
    end
  end
  describe "ライブハウス情報参照機能" do
    context "ライハウス情報を押した場合" do
      it "ライブハウス情報が表示される" do
        visit livehouses_path
        click_on "下北沢BASEMENT BAR"
        click_on "ライブハウス情報"
        expect(page).to have_content "東京都世田谷区代沢5-18-1"
      end
    end
  end
  describe "イベント詳細参照機能" do
    context "イベント部分の詳細を押した場合" do
      it "イベント詳細情報が表示される" do
        visit livehouses_path
        click_on "下北沢BASEMENT BAR"
        all(".card .detail")[0].click_on "詳細"
        expect(page).to have_content "タイトル１"
        expect(page).to have_content "2022年06月01日"
        expect(page).to have_content "18:00／18:30"
        expect(page).to have_content "3000円"
        expect(page).to have_content "あああ"
      end
    end
  end
end