class Category < ApplicationRecord
  enum name: {
    life: '生活',
    work: '仕事',
    health: '健康',
    other: 'その他'
}
end
