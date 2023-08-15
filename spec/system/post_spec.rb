# spec/system/post_spec.rb
require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  let(:user_a) { FactoryBot.create(:user) }
  let(:user_b) { FactoryBot.create(:user) }
  
  before do
    sign_in user_b
  end

  describe 'CRUD機能' do
    it '新規投稿' do
      visit new_post_path
      fill_in 'Title', with: 'New Post'
      fill_in 'Content', with: 'This is a new post content.'
      select '生活', from: 'カテゴリー'
      select '高', from: '優先度'
      click_button '作成'
      expect(page).to have_content('Post was successfully created.')
      expect(page).to have_content('New Post')
    end

    it '詳細' do
      post = FactoryBot.create(:post, user: user_b)
      visit post_path(post)
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.content)
    end

    it '編集' do
      post = FactoryBot.create(:post, user: user_b)
      visit edit_post_path(post)
      fill_in 'Title', with: 'Updated Post'
      fill_in 'Content', with: 'This is an updated post content.'
      click_button '作成'
      expect(page).to have_content('Post was successfully updated.')
      expect(page).to have_content('Updated Post')
    end

    it '削除' do
      post = FactoryBot.create(:post, user: user_b)
      visit posts_path(post)
      click_link 'Destroy'
      accept_alert
      expect(page).to have_content('Post was successfully destroyed.')
      expect(page).not_to have_content(post.title)
    end
  end
  describe "一覧表示" do
    it "自分の投稿のみ表示される" do
      # Aユーザーが投稿
      post_by_user_a = FactoryBot.create(:post, user: user_a, content: "Aです")
      # Bユーザーが投稿
      post_by_user_b = FactoryBot.create(:post, user: user_b, content: "Bです")

      visit posts_path

      expect(page).not_to have_content("Aです")
      expect(page).to have_content("Bです")
    end
  end
  describe "コンテンツ検索" do
    it "CRUD機能は表示されない" do
      visit root_path

      expect(page).not_to have_link('新規作成')
      expect(page).not_to have_link('詳細')
      expect(page).not_to have_link('編集')
      expect(page).not_to have_link('削除')
    end
  end
end
