class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]
  before_action :set_categories, only: [:show, :edit, :new, :update]

  def index
    @posts = Post.all
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
    @post.creator = User.first #TODO: change once we have authentication

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
