class ChatGroupsController < ApplicationController
  def index
    @group = ChatGroup.find(1)
  end

  def new
    @group = ChatGroup.new
  end

  def create
    @group = ChatGroup.create(chat_group_params)
    # add_user_id_to_relation_table(chat_group)
    redirect_to chat_group_messages_path(@group.id)
  end

  def edit
    @group = ChatGroup.find(params[:id])
  end

  def update
    current_group = ChatGroup.find(params[:id])
    current_group.update(chat_group_params)
    redirect_to chat_group_messages_path(current_group.id)
  end

  private
    def chat_group_params
      params.require(:chat_group).permit(:name , user_ids: [])
    end

  def add_user_id_to_relation_table(chat_group)
     x = 1
    next_while = true
    while next_while do
        if x <= chat_group_params[:user_ids].count-1
          users = User.find(chat_group_params[:user_ids][x])
          chat_group.users << users
          x = x + 1
        else
          next_while = false
        end
    end
  end
end
