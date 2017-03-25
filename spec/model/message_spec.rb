require 'rails_helper'

describe Message do
  describe '#create' do
    it "is valid with a content, image, user_id, chat_group_id" do
      message = build(:message)
      expect(message).to be_valid
    end

    it "is invalid without a content" do
      user = build(:message, content: nil)
      user.valid?
      expect(user.errors[:content]).to include("を入力してください。")
    end
  end
end
