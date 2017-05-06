class MessagesController < ApplicationController

before_action :authenticate_user!

  def index
    @current_group = ChatGroup.find(params[:chat_group_id])
    @current_group_members = @current_group.users
    @current_user_groups = current_user.chat_groups.order('created_at DESC').includes(:user_chat_groups).includes(:users)
    @messages = @current_group.messages.includes(:user)
    @new_message = Message.new
    respond_to do |format|
      format.html
      format.json {render json: get_create_json(get_update_messages, get_update_user_nicknames)}
    end
  end

  def create
    message = current_user.messages.new(message_params)
    if message.save
      respond_to do |format|
        format.html { redirect_to chat_group_messages_url(message.chat_group_id), notice: 'メッセージを送信しました(あなたの思いが伝わりますように。)' }
        format.json { render json: message.create_message_json.merge(image: message.image.url, message_id: message.id) }
      end
    else
      redirect_to chat_group_messages_url(message.chat_group_id), alert: 'メッセージの送信に失敗しました。(メッセージは225文字以下でお願いします。)'
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :image, :chat_group_id)
  end

  def get_update_messages
    ChatGroup.find(params[:chat_group_id]).messages.where("id > ?", params[:currentMessageId])
  end

  def get_update_user_nicknames
    update_users = []
    update_messages = ChatGroup.find(params[:chat_group_id]).messages.where("id > ?", params[:currentMessageId])
      update_messages.each do |message|
        update_users << User.find(message[:user_id]).nickname
      end
    return update_users
  end

  def get_create_json(get_update_messages, get_update_user_nicknames)
    messages_and_nicknames = []
    messages_and_nicknames = messages_and_nicknames.push(get_update_messages)
    messages_and_nicknames = messages_and_nicknames.push(get_update_user_nicknames)
end
end
