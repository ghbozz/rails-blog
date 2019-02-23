class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    if params[:query]
      if params[:query][:title].present? && params[:query][:user].present?
        sql_query = "title ILIKE :query OR content ILIKE :query"
        posts_tmp = Post.where(sql_query, query: "%#{params[:query][:title]}%")
        @posts = posts_tmp.select { |post| post.user.email == params[:query][:user] }
      elsif params[:query][:title].present?
        sql_query = "title ILIKE :query OR content ILIKE :query"
        @posts = Post.where(sql_query, query: "%#{params[:query][:title]}%")
      elsif params[:query][:user].present?
        posts_tmp = Post.all.order('created_at DESC')
        @posts = posts_tmp.select { |post| post.user.email == params[:query][:user] }
      else
        @posts = Post.all.order('created_at DESC')
      end
    else
      @posts = Post.all.order('created_at DESC')
    end
  end

  def show
    @comment = Comment.new
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

  def edit

  end

  def update
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def destroy
    @post.destroy
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
