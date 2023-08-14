require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        post = Post.new(title: '', content: '失敗テスト')
        expect(post).not_to be_valid
      end
    end
    
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        post = Post.new(title: 'タイトル', content: '')
        expect(post).not_to be_valid
      end
    end
    
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        user = User.create(name: 'テストユーザー')  # Userデータを作成
        post = Post.new(title: 'タイトル', content: '詳細', user: user)
        expect(post).to be_valid
      end
    end
  end

  describe 'スコープのテスト' do
    before do
      user = User.create(name: 'test', email: 'sample@.com', password: 'aaaaaaaa', sign_in_count: 0 )
      
      Post.create(title: 'タスク1', content: '詳細1', priority: '中', category: '生活', public: true, user_id: user.id)
      Post.create(title: 'タスク2', content: '詳細2', priority: '低', category: '仕事', public: true, user_id: user.id)
      Post.create(title: 'タスク3', content: '詳細3', priority: '高', category: '健康', public: true, user_id: user.id)
    end

    context '優先度で並び替えられる場合' do
      it '優先度の昇順で取得されること' do
        posts = Post.sorted_by_priority
        expect(posts.count).to eq(3)
        expect(posts.first.title).to eq('タスク3')
        expect(posts.second.title).to eq('タスク1')
        expect(posts.third.title).to eq('タスク2')
      end
    end
  
    context 'コンテンツのキーワードを検索する場合' do
      it 'キーワードに一致する投稿が取得されること' do
        search_result = Post.search('詳細1')
        expect(search_result.count).to eq(1)
        expect(search_result.first.title).to eq('タスク1')
      end

      it 'キーワードに一致しない場合は投稿が取得されないこと' do
        search_result = Post.search('存在しないキーワード')
        expect(search_result.count).to eq(0)
      end
    end
  end
end