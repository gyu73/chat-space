class MessagesController < ApplicationController
  def index
    @current_group = ChatGroup.find(params[:chat_group_id])
    @current_group_members = @current_group.users
    @current_user_groups = current_user.chat_groups.order('created_at DESC')
  end
end
