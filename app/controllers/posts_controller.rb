class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :userposts, :withtag]
  load_and_authorize_resource except: [:userposts, :withtag, :userfeed]

  def index
    @posts = Post.order('created_at DESC').page(params[:page]).per(12)
  end

  def show
    @post = Post.find(params[:id])
    if request.path != post_path(@post)
      redirect_to @post, status: :moved_permanently
    end
    @postCreator = User.find(@post.user_id)
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to @post
    else
      render 'new'
    end
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

  def withtag
    if params[:tag]
      @posts = Post.tagged_with(params[:tag]).order('created_at DESC').page(params[:page]).per(12)
      @tagname = params[:tag]
      @tag = Tag.find_by_name(params[:tag])
    end
  end

  def userfeed
    idArr = Array.new
    allPosts = Post.order('created_at DESC')
    userTags = current_user.subscribed_tags.map(&:id)
    allPosts.each do |post|
      post.tags.map(&:id).any? do |t|
        idArr.push(post.id) if userTags.include?(t)
      end
    end
    @posts = Post.where(id: idArr).order('created_at DESC').page(params[:page]).per(12)
  end

  def userposts
    @user = User.find(params[:id])
    @posts = Post.where(user_id: @user.id).order('created_at DESC').page(params[:page]).per(12)
  end

  private
    def post_params
      params.require(:post).permit(:title, :body, :image, :tag_list, :slug)
    end
end
