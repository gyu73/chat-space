class ChatGroupsController < ApplicationController
  def index
    @current_user_groups = current_user.chat_groups.order('created_at DESC')
  end

  def new
    @group = ChatGroup.new
  end

  def create
    group = ChatGroup.new(name: chat_group_params[:name], user_ids: chat_group_params[:new_user_ids])
    if group.save
      redirect_to chat_group_messages_url(group), notice: '新しいグループが作成されました'
    else
      redirect_to new_chat_group_url, alert: 'グループ作成に失敗しました。'
    end
  end

  def edit
    @group = get_params_id
    @group_members = @group.users.where.not("nickname = '#{current_user.nickname}'")
  end

  def update
    current_group = get_params_id
    if current_group.update(name: chat_group_params[:name], user_ids: chat_group_params[:new_user_ids])
      redirect_to chat_group_messages_url(current_group), notice: 'グループを編集しました。'
    else
      redirect_to edit_chat_group_url(current_group), alert: 'グループ編集に失敗しました。'
    end
  end

  private
    def chat_group_params
      new_user_ids = params[:chat_group][:user_ids].uniq
      params.require(:chat_group).merge(new_user_ids: new_user_ids).permit(:name , new_user_ids: [])
    end

    def get_params_id
    ChatGroup.find(params[:id])
    end
end
