class UsersController < ApplicationController
  before_action :authenticate_user!, except:[:show]
  before_action :ensure_correct_user, only:[:edit, :update]

  def show
  	@user = User.find(params[:id])
  end

  def index
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)

    if @user.update(user_params)
      flash[:notice] = "プロフィールを更新しました"

      redirect_to user_path(current_user.id)
    else
      render "users/edit"
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :user_image_name, :introduction)
  end

end
