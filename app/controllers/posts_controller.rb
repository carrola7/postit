class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :set_categories, only: [:show, :edit, :new, :update]
  before_action :ensure_logged_in, only: [:new, :create, :edit, :update]

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
    binding.pry
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
    vote = Vote.new(creator: current_user, voteable: @post, vote: params[:vote])

    if vote.save
      flash[:notice] = "Your vote was counted"
    else
      flash[:error] = "Your vote was not counted"
    end

    redirect_to :back
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def set_post
    @post = Post.find(params[:id])    
  end

  def set_categories
    @categories = Category.all
  end
end
