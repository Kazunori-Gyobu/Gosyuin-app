class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: :destroy

  def index
    @posts = Post.page(params[:page]).per(15)
    @feed_items = current_user.feed.page(params[:page])
  end

  def new
    @post = current_user.posts.build 
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "記事が投稿されました"
      redirect_to current_user
    else
      @feed_items = []
      render 'users/sessions/new'
    end
  end

  def destroy
    @post.destroy
    flash[:alert] = "記事を削除しました"
    redirect_to request.referrer || current_user
  end

  private

  def post_params
    params.require(:post).permit(:content, :picture)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end
end
