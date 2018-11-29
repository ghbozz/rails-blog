class PostsController < ApplicationController
  before_action :set_post, only: [:show]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.save
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :photo)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
