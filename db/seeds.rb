# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# db/seeds.rb

#Users
5.times do |i|
  User.create!(
    email: "user#{i + 1}@example.com",
    password: "password",
    name: "User #{i + 1}"
  )
end

#Conversations and Messages
users = User.all
users.each do |user|
  recipient = users.sample
  next if user == recipient

  conversation = Conversation.create!(
    sender_id: user.id,
    recipient_id: recipient.id
  )

  5.times do
    Message.create!(
      body: "Hello, this is a message.",
      conversation_id: conversation.id,
      user_id: [user.id, recipient.id].sample,
      read: [true, false].sample
    )
  end
end

#Posts
5.times do |i|
  Post.create!(
    title: "Post Title #{i + 1}",
    content: "This is the content for post #{i + 1}.",
    priority: Post.priorities.keys.sample, # ランダムな優先度を選択
    category: Post.categories.keys.sample, # ランダムなカテゴリを選択
    user_id: User.pluck(:id).sample, # 適切なユーザーIDを選択
    public: [true, false].sample
  )
end

