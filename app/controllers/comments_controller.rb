class CommentsController < ApplicationController
  before_action :ensure_logged_in

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.creator = current_user

    if @comment.save
      flash[:notice] = "Your comment was added"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    comment = Comment.find(params[:id])

    vote = Vote.new(vote: params[:vote], voteable: comment, creator: current_user)

    if vote.save
      flash[:notice] = "Your vote was counted"
    else
      flash[:error] = "You may only vote on that once"
    end

    redirect_to :back
  end
end