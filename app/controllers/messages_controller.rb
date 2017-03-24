class MessagesController < ApplicationController
  def index
    @current_group = ChatGroup.find(params[:chat_group_id])
    @current_group_members = @current_group.users
    @current_user_groups = current_user.chat_groups.order('created_at DESC')
    @messages = @current_group.messages.includes(:user)
    @new_message = Message.new
  end

  def create
    message = Message.new(content: message_params[:content], user_id: current_user.id, chat_group_id: chat_group_params[:chat_group_id])
    group = ChatGroup.new(id: chat_group_params[:chat_group_id])
    if message.save
      redirect_to chat_group_messages_url(group), notice: 'メッセージを送信しました'
    else
      redirect_to chat_group_messages_url(group), alert: 'メッセージの送信に失敗しました。'
    end
  end
end

private

def message_params
  params.require(:message).permit(:content)
end

def chat_group_params
  params.permit(:chat_group_id)
end
