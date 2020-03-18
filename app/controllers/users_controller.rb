class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  def index
    @users = User.page(params[:page]).per(15)
  end

  def show
    @user = User.find(params[:id])
  end
end
