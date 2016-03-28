class UsersController < ApplicationController

  def show
    if (User.find_by_id(params[:id]))
      @user = User.find(params[:id])
    else
      redirect_to root_path, notice: "User not found!"
    end

  end

  def update
    @user = User.find(params[:id])

    if @user.update(params[:user].permit(:information))
      redirect_to @user
    else
      render 'edit'
    end
  end

  def edit
    @user = User.find(params[:id])
  end
end
