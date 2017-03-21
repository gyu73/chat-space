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
      redirect_to chat_group_messages_url(group), notice: '新しいグループが作成されました'
    else
      redirect_to new_chat_group_url, alert: 'グループ作成に失敗しました。'
    end
  end

  def edit
    @group = get_params_id
  end

  def update
    current_group = get_params_id
    if current_group.update(chat_group_params)
      redirect_to chat_group_messages_url(current_group), notice: 'グループを編集しました。'
    else
      redirect_go edit_chat_group_url(current_group), alert: 'グループ編集に失敗しました。'
    end
  end

  private
    def chat_group_params
      params.require(:chat_group).permit(:name , user_ids: [])
    end

    def get_params_id
    ChatGroup.find(params[:id])
    end
end
