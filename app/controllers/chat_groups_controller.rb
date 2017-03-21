class ChatGroupsController < ApplicationController
  def index
    @group = ChatGroup.find(1)
  end

  def new
    @group = ChatGroup.new
  end

  def create
    group = ChatGroup.new(chat_group_params)
    group.save
    # add_user_id_to_relation_table(chat_group)
    redirect_to chat_group_messages_path(group)
    binding.pry
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

  # def add_user_id_to_relation_table(chat_group)
  #    x = 1
  #   next_while = true
  #   while next_while do
  #       if x <= chat_group_params[:user_ids].count-1
  #         users = User.find(chat_group_params[:user_ids][x])
  #         chat_group.users << users
  #         x = x + 1
  #       else
  #         next_while = false
  #       end
  #   end
  # end

end
