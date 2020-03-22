class HomeController < ApplicationController
  def index
    if user_signed_in?
      @post = current_user.posts.build
      @feed_items = current_user.feed.page(params[:page])
      @stampbooks = current_user.stampbooks.page(params[:page])
    end
  end
end
