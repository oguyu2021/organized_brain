require 'rails_helper'

RSpec.describe 'Message Functionality', type: :system do
  let(:user1) { FactoryBot.create(:user, name: 'Alice') }
  let(:user2) { FactoryBot.create(:user, name: 'Bob') }

  before do
    sign_in user1
    @post = FactoryBot.create(:post, title: 'Alice\'s Post', content: 'こんにちは', user: user1)
    sign_out user1
  end

  it '他のユーザーの投稿を検索し、投稿者とメッセージを送る' do
    sign_in user2 # Bobがログイン

    visit posts_path
    fill_in '調べたいキーワードを入力してください。', with: 'こんにちは'
    click_button '検索'
    expect(page).to have_content('Alice\'s Post')

    click_link 'Alice' # Aliceのリンクをクリック
    expect(page).to have_content('トークルーム')

    fill_in 'メッセージを入力', with: 'Hello, Alice! I liked your post.'
    click_button '送信'
    expect(page).to have_content('Hello, Alice! I liked your post.')
  end
end
