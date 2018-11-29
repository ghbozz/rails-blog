class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.post = Post.find(params[:post_id])
    if @comment.save
      redirect_to post_path(Post.find(params[:post_id]))
    else
      render :new
    end
  end

  def destroy
    @comment.destroy
    redirect_to post_path(@comment.post)
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:title, :content)
  end
end
