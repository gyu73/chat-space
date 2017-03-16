class ChatGroupsController < ApplicationController
  def index
  end

  def new
    @group = ChatGroup.new
  end

  def create
    ChatGroup.create(create_params)
    redirect_to action: :index
  end

  def edit
  end

  private
    def create_params
      params.require(:chat_group).permit(:name)
    end
  end
