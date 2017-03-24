class ChatGroup < ApplicationRecord
  has_many :messages
  has_many :user_chat_groups
  has_many :users , through: :user_chat_groups
  accepts_nested_attributes_for :user_chat_groups

  validates :name, presence: true
end
