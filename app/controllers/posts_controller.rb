class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    if params[:tag]
      @posts = Post.tagged_with(params[:tag]).order('created_at DESC')
    else
      @posts = Post.all.order('created_at DESC')
    end
  end

  def userposts
    @user = User.find(params[:id])
    @posts = Post.where(user_id: @user.id).order('created_at DESC')
  end

  def new
    @post = Post.new
  end

  def create  # method to save data
    @post = current_user.posts.build(post_params)
    @post.user_id = current_user.id

    if @post.save
     redirect_to @post
    else
      render 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to root_path
  end

  private
    def post_params
      params.require(:post).permit(:title, :body, :image, :tag_list)
    end
end
