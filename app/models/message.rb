class Message < ApplicationRecord
    belongs_to :user
    belongs_to :chat_group
    mount_uploader :image, ImageUploader

    validates :content, presence: true, length: { maximum: 225 }, if: 'image.blank?'

  def create_json
    { user_nickname: user.nickname, created_at: created_at.strftime('%Y年%m月%d日 %H:%M:%S'), content: content }
  end
end
