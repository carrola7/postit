class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :set_categories, only: [:show, :edit, :new, :update]
  before_action :ensure_logged_in, only: [:new, :create, :edit, :update, :vote]
  before_action :ensure_edit_permissions, only: [:edit, :update]

  def index
    @posts = Post.all.sort_by{|x| x.total_votes}.reverse
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user

    if @post.save
      flash[:notice] = "Your post was created"
      redirect_to posts_path
    else
      render 'posts/new'
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Your post was edited"
      redirect_to posts_path(@post)
    else
      render 'posts/edit'
    end
  end

  def vote
    @vote = Vote.new(creator: current_user, voteable: @post, vote: params[:vote])
  
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

  private

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def set_post
    @post = Post.find_by(slug: params[:id])    
  end

  def set_categories
    @categories = Category.all
  end

  def allowed_to_edit
    admin? || current_user == @post.creator
  end

  def ensure_edit_permissions
    access_denied unless allowed_to_edit
  end
end
