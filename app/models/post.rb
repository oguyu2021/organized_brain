class Post < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :content, presence: true
  
  enum priority: { 高: 0, 中: 1, 低: 2 }
  enum category: { 生活: 0, 仕事: 1, 健康: 2 }

  scope :sorted_by_priority, -> { order(priority: :asc) }
  scope :search, ->(query) { ransack(content_cont: query, public_eq: true).result } 

  def self.ransackable_attributes(auth_object = nil)
    [ "content" ]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end
end
