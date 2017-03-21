class ChatGroupsController < ApplicationController
  def index
    @group = ChatGroup.find(1)
  end

  def new
    @group = ChatGroup.new
  end

  def create
    group = ChatGroup.new(chat_group_params)
    if group.save
      group.save
      redirect_to chat_group_messages_path(group)
    else
      redirect_to new_chat_group
    end
  end

  def edit
    @group = get_params_id
  end

  def update
    current_group = get_params_id
    current_group.update(chat_group_params)
    redirect_to chat_group_messages_path(current_group.id)
  end

  private
    def chat_group_params
      params.require(:chat_group).permit(:name , user_ids: [])
    end

    def get_params_id
    ChatGroup.find(params[:id])
    end
end
