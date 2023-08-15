# spec/system/post_spec.rb
require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  let(:user) { FactoryBot.create(:user) }
  
  before do
    sign_in user
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
      post = FactoryBot.create(:post, user: user)
      visit post_path(post)
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.content)
    end

    it '編集' do
      post = FactoryBot.create(:post, user: user)
      visit edit_post_path(post)
      fill_in 'Title', with: 'Updated Post'
      fill_in 'Content', with: 'This is an updated post content.'
      click_button '作成'
      expect(page).to have_content('Post was successfully updated.')
      expect(page).to have_content('Updated Post')
    end

    it '削除' do
      post = FactoryBot.create(:post, user: user)
      visit posts_path(post)
      click_link 'Destroy'
      accept_alert
      expect(page).to have_content('Post was successfully destroyed.')
      expect(page).not_to have_content(post.title)
    end
  end
end
