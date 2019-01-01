class CommentsController < ApplicationController
  before_action :ensure_logged_in

  def create
    @post = Post.find_by(slug: params[:post_id])
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
    @comment = Comment.find(params[:id])

    @vote = Vote.new(vote: params[:vote], voteable: @comment, creator: current_user)

    if @vote.save
      respond_to do |format|
        format.html do
          flash[:notice] = "Your vote was counted"
          redirect_to :back
        end
        format.js
      end
    else
      respond_to do |format|
        flash[:error] = "You may only vote on that once"
        format.html { redirect_to :back }
        format.js
      end
    end
  end
end