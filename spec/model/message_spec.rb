require 'rails_helper'

describe Message do
  describe '#create' do
    it "is valid with a content, image, user_id, chat_group_id" do
      message = build(:message)
      expect(message).to be_valid
    end

    it "is invalid without a content" do
      message = build(:message, content: nil)
      message.valid?
      expect(message.errors[:content]).to include("を入力してください。")
    end
  end
end
