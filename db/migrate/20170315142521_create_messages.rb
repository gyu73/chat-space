class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.string :content
      t.text :image
      t.integer :user_id
      t.integer :chat_group_id

      t.timestamps
    end
  end
end
