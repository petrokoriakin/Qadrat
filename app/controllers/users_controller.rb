class UsersController < ApplicationController
  # load_and_authorize_resource
  def show
    if (User.find(params[:id]))
      @user = User.find(params[:id])
      if request.path != user_path(@user)
        redirect_to @user, status: :moved_permanently
      end
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
    params.require(:user).permit(:information, :username, :avatar, :slug)
  end
end
