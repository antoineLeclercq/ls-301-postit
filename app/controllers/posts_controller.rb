class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:show, :index, :vote]
  before_action :require_creator_or_admin, only: [:edit, :update]

  def index
    @posts = Post.all.sort_by(&:net_votes_count).reverse
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
      flash[:notice] = 'Your post was successfully created.'
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:notice] = 'Your post was successfully edited.'
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  def vote
    @vote = Vote.create(vote: params[:vote], creator: current_user, voteable: @post)

    respond_to do |format|
      format.html do
        if @vote.valid?
          flash[:notice] = 'Your vote was counted.'
        else
          flash[:error] = 'You can only vote once on this post.'
        end

        redirect_to :back
      end

      format.js
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def set_post
    @post = Post.find_by(slug: params[:id])
  end

  def require_creator_or_admin
    access_denied unless creator? || current_user.admin?
  end
end
