class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_url
    else
      render :new
    end
  end

  private

  def logged_in_user
    unless logged_in?
      flash[:error] = "Please sign in."
      redirect_to login_path
    end
  end

  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end
end
