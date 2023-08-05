class AddPublicToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :public, :boolean, default: true
  end
end
