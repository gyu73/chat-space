class Message < ApplicationRecord
    belongs_to :user
    belongs_to :chat_group

    validates :content, presence: true, length: { maximum: 225 }
end
