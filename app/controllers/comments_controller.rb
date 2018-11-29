class CommentsController < ApplicationController
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

  private

  def comment_params
    params.require(:comment).permit(:title, :content)
  end
end
