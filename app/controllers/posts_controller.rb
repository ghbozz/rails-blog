class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, :except => [:show, :index]

  def index
    if params[:query]
      search_posts(params[:query])
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

  def search_posts(query)
    if query[:title].present? && query[:user].present?
      sql_query = "title ILIKE :query OR content ILIKE :query"
      posts_tmp = Post.where(sql_query, query: "%#{query[:title]}%")
      @posts = posts_tmp.select { |post| post.user.email == query[:user] }
    elsif query[:title].present?
      sql_query = "title ILIKE :query OR content ILIKE :query"
      @posts = Post.where(sql_query, query: "%#{query[:title]}%")
    elsif query[:user].present?
      posts_tmp = Post.all.order('created_at DESC')
      @posts = posts_tmp.select { |post| post.user.email == query[:user] }
    else
      @posts = Post.all.order('created_at DESC')
    end
  end

  def post_params
    params.require(:post).permit(:title, :content, :photo)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
