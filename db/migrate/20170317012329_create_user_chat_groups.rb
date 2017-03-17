class CreateUserChatGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :user_chat_groups do |t|
      t.references :user, foreign_key: true
      t.references :chat_group, foreign_key: true

      t.timestamps
    end
  end
end
