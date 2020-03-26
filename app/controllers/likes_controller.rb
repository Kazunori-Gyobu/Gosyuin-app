class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    return if @post.like?(current_user)

    @post.like(current_user)
    @post.reload
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end

  def destroy
    @post = Like.find(params[:id]).post
    return unless @post.like?(current_user)

    @post.unlike(current_user)
    @post.reload
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url}
      format.js
    end
  end
end
