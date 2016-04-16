class UsersController < ApplicationController
  # load_and_authorize_resource
  def show
    if (User.find_by_id(params[:id]))
      @user = User.find(params[:id])
      @posts_counter = Post.where(user_id: @user.id).count
    else
      redirect_to root_path, notice: "User not found!"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end



 private
  def user_params
    params.require(:user).permit(:information, :username, :avatar)
  end
end
