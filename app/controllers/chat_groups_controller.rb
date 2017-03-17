class ChatGroupsController < ApplicationController
  def index
  end

  def new
    @group = ChatGroup.new
    binding.pry
  end

  def create
    chat_group = ChatGroup.create(create_params)
    binding.pry
    redirect_to action: :index
  end

  def edit
  end

  private
    def create_params
      params.require(:chat_group).permit(:name,:user_ids)
    end
  end
