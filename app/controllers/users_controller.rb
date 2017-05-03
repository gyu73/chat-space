class UsersController < ApplicationController
  def index
    users = User.where('nickname LIKE(?)', "#{user_name_params[:keyword]}%").where.not("nickname = '#{current_user.nickname}'")
      respond_to do |format|
        format.html
        format.json{ render json: users }
      end
    end
  end

private

def user_name_params
  params.require(:user_name).permit(:keyword)
end
