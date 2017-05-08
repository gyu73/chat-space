class Message < ApplicationRecord

  def create_message_json
    { user_nickname: user.nickname, created_at: created_at.strftime('%Y年%m月%d日 %H:%M:%S'), content: content }
  end

  belongs_to :user
  belongs_to :chat_group
  mount_uploader :image, ImageUploader

  validates :content, presence: true, length: { maximum: 225 }, if: 'image.blank?'
end
