class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :userposts, :withtag]
  load_and_authorize_resource except: [:userposts, :withtag, :usernews]

  def index
    # @posts = Post.order('created_at DESC').page(params[:page]).per(3)
    if params[:query]
      @posts = Post.text_search(params[:query]).order('created_at DESC').page(params[:page]).per(12)
    else
      @posts = Post.order('created_at DESC').page(params[:page]).per(12)
    end
  end

  def show
    @post = Post.find(params[:id])
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
      @posts = Post.tagged_with(params[:tag]).order('created_at DESC')
      @tagname = params[:tag]
      @tag = Tag.find_by_name(params[:tag])
    end
  end

  def userfeed
    @posts = []
    allPosts = Post.order('created_at DESC')
    userTags = current_user.subscribed_tags.map(&:name)
    allPosts.each do |post|
      postTags = post.tag_list.split(',')
      userTags.each do |tag|
        if postTags.include?(tag)
          @posts.push(post)
          break
        end
      end
    end
  end

  def userposts
    @user = User.find(params[:id])
    @posts = Post.where(user_id: @user.id).order('created_at DESC')
  end

  private
    def post_params
      params.require(:post).permit(:title, :body, :image, :tag_list)
    end
end
