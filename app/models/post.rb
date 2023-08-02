class Post < ApplicationRecord
  belongs_to :user
  enum priority: { 高: 0, 中: 1, 低: 2 }
  enum category: { 生活: 0, 仕事: 1, 健康: 2 }

  scope :sorted_by_priority, -> { order(priority: :asc) }
  scope :search, ->(query) { ransack(title_or_content_cont: query).result } 

  def self.ransackable_attributes(auth_object = nil)
    ["title", "content"]
  end
end
