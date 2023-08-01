class Post < ApplicationRecord
  has_and_belongs_to_many :categories
  enum priority: { 高: 0, 中: 1, 低: 2 }
end
