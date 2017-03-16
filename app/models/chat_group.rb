class ChatGroup < ApplicationRecord

  has_many :messages
  has_many :users_chat_groups
  has_many :users , through: :users_chat_groups
end
