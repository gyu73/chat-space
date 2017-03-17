class ChatGroup < ApplicationRecord
  has_many :messages
  has_many :user_chat_groups
  has_many :users , through: :user_chat_groups
end
