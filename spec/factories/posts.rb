FactoryBot.define do
  factory :post do
    title { "タイトル" }
    content { "詳細" }
    priority { '中' }
    category { '生活' }
    public { true }
  end
end
