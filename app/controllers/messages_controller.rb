class MessagesController < ApplicationController

before_action :authenticate_user!

  def index
    @current_group = ChatGroup.find(params[:chat_group_id])
    @current_group_members = @current_group.users
    @current_user_groups = current_user.chat_groups.order('created_at DESC').includes(:user_chat_groups).includes(:users)
    @messages = @current_group.messages.includes(:user)
    @new_message = Message.new
  end

  def create
    message = current_user.messages.new(message_params)
    if message.save
      redirect_to chat_group_messages_url(message.chat_group_id), notice: 'メッセージを送信しました(あなたの思いが伝わりますように。)'
    else
      redirect_to chat_group_messages_url(message.chat_group_id), alert: 'メッセージの送信に失敗しました。(メッセージは225文字以下でお願いします。)'
    end
  end
end

private

def message_params
  params.require(:message).permit(:content, :chat_group_id)
end
