require 'rails_helper'

RSpec.describe "ユーザー機能", type: :system do
  describe 'ユーザー新規作成機能' do
    context 'ユーザーの新規登録した場合' do
      it 'ユーザーの新規登録ができる' do
        visit new_user_registration_path
        fill_in '名前', with: 'test'
        fill_in 'メールアドレス', with: 'test@test.com'
        fill_in 'パスワード', with: 'password'
        fill_in '確認用パスワード', with: 'password'
        click_on 'アカウント登録'
        expect(page).to have_content 'アカウント登録が完了しました'
      end
    end
    context 'ログインせずに一覧ページにアクセスした場合' do
      it 'ログイン画面に遷移' do
        visit posts_path
        expect(page).to have_content 'ログイン'
        expect(page).to have_content 'パスワード'
      end
    end
  end
    describe '一般ユーザーのログイン機能' do
      let!(:user) { FactoryBot.create(:user) }
        before do
          sign_in user
          visit posts_path
        end
      context 'ログインをした場合' do
        it 'ログインできる' do
          expect(page).to have_content '一般'
        end
      end
      context 'ログアウトした場合' do
        it 'ログアウトできる' do
          click_on 'ログアウト'
          expect(page).to have_content 'ログイン'
        end
      end
    end
  describe '管理者権限の機能' do
    let!(:user) { FactoryBot.create(:user, admin: true) }
    before do
      sign_in(user)
      visit root_path
    end
    context '管理者ページにアクセスした場合' do
      it 'アクセスできる' do
        visit rails_admin_path
        expect(page).to have_content 'サイト管理'
        expect(page).to have_content 'ナビゲーション'
      end
    end
  end
end