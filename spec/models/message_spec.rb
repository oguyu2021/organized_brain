require 'rails_helper'


RSpec.describe Message, type: :model do
  describe 'バリデーションのテスト' do
    it 'body、conversation_id、user_idが存在すれば有効であること' do
      sender = User.create(name: 'hoge', email: 'sender@example.com', password: 'password', sign_in_count: 0)
      recipient = User.create(name: 'huga', email: 'recipient@example.com', password: 'password', sign_in_count: 0)
      conversation = Conversation.create(sender_id: sender.id, recipient_id: recipient.id)
      message = Message.new(body: 'テストメッセージ', conversation_id: conversation.id, user_id: sender.id)

      expect(message).to be_valid
    end

    it 'bodyが空であれば無効であること' do
      conversation = Conversation.create
      user = User.create
      message = Message.new(body: '', conversation_id: conversation.id, user_id: user.id)
      expect(message).to_not be_valid
      expect(message.errors[:body]).to include('を入力してください')
    end

    it 'conversation_idが空であれば無効であること' do
      user = User.create
      message = Message.new(body: 'テストメッセージ', conversation_id: nil, user_id: user.id)
      expect(message).to_not be_valid
      expect(message.errors[:conversation_id]).to include('を入力してください')
    end

    it 'user_idが空であれば無効であること' do
      conversation = Conversation.create
      message = Message.new(body: 'テストメッセージ', conversation_id: conversation.id, user_id: nil)
      expect(message).to_not be_valid
      expect(message.errors[:user_id]).to include('を入力してください')
    end
  end
end
