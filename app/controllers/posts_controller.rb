class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
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
      render 'users/sessions/new'
    end
  end

  def destroy
    @post = current_user.posts.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "記事を削除しました"
    redirect_to request.referrer || current_user
  end

  private

  def post_params
    params.require(:post).permit(:content, :picture)
  end
end
