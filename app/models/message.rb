class Message < ApplicationRecord
    belongs_to :user
    belongs_to :chat_group

    validates :content, presence: true, length: { maximum: 225 }

  def json
    { user_nickname: user.nickname, created_at: created_at.strftime('%Y年%m月%d日 %H:%M:%S'), content: content }
  end
end
