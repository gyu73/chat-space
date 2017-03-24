class MessagesController < ApplicationController
  def index
    @current_group = ChatGroup.find(params[:chat_group_id])
    @current_group_members = @current_group.users
    @current_user_groups = current_user.chat_groups.order('created_at DESC').includes(:user_chat_groups).includes(:users)
    @messages = @current_group.messages.includes(:user)
    @new_message = Message.new
  end

  def create
    binding.pry
    message = Message.new(message_params)
    if message.save
      redirect_to chat_group_messages_url(chat_group_params[:chat_group_id]), notice: 'メッセージを送信しました(あなたの思いが伝わりますように。)'
    else
      redirect_to chat_group_messages_url(chat_group_params[:chat_group_id]), alert: 'メッセージの送信に失敗しました。(メッセージは225文字以下でお願いします。)'
    end
  end
end

private

def message_params
  params.require(:message).permit(:content).merge(user_id: current_user.id, chat_group_id: chat_group_params[:chat_group_id])
end

def chat_group_params
  params.permit(:chat_group_id)
end
