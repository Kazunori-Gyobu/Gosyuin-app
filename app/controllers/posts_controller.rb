class PostsController < ApplicationController
  def index
  end

  def new
    @post = current_user.posts.build 
  end

  def create
    @posts = current_user.posts.build(post_params)
    if @posts.save
      flash[:success] = "記事が投稿されました"
      redirect_to user_path
    else
      render 'users/sessions/new'
    end
  end

  def destroy
    
  end

  private

  def post_params
    params.require(:post).permit(:content, :picture)
  end
end
