class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :sender_id
      t.integer :recipient_id
      t.integer :message_id
      t.boolean :read, default: false

      t.timestamps
    end
  
    add_index :notifications, :recipient_id  
  end
end
