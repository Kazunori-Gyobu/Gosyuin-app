class StampsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: :destroy
  before_action :set_select_collections, only: [:new, :create, :edit, :update]

  def index
    @stamps = Stamp.page(params[:page]).per(15)

  end
  
  def show
    @stamp = Stamp.find(params[:id])
    @user = @stamp.user
    @stamps = @stamp.user.stamps.page(params[:page])
    @stampbooks = @user.stampbooks.page(params[:page])
  end

  def new
    @stamp = Stamp.new
  end

  def create
    @stamp = Stamp.new(stamp_params)
    if @stamp.save
      flash[:success] = "御朱印が登録されました！"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @stamp = Stamp.find(params[:id])
  end

  def update
    @stamp = current_user.stamps.find_by(id: params[:id])
    if @stamp.update_attributes(stamp_params)
      flash[:notice] = "御朱印の編集に成功しました"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    @stamp.destroy
    flash[:notice] = "御朱印を削除しました"
    redirect_to request.referrer || root_url
  end

  def owners
    @user = User.find(params[:id])
    @stamp = @user.stamps.first
    @stamps = @user.stamps.page(params[:page])
    @stampbooks = @user.stampbooks
    render 'show'
  end

  def search
    @search_params = stamp_search_params
    @stamps = Stamp.search(@search_params).includes(:stampbook)
  end

  private

  def stamp_params
    params.require(:stamp).permit(:name, :given_date, :photo, :remove_photo, :photo_cache, :remarks, :distinction, :stampbook_id)
  end

  def stamp_search_params
    params.fetch(:search, {}).permit(:name, :distinction, :given_date_from, :given_date_to, :stampbook_id)
  end

  def correct_user
    @stamp = current_user.stamps.find_by(id: params[:id])
    redirect_to root_url if @pstamp.nil?
  end

  def set_select_collections
    @stampbooks = current_user.stampbooks
  end
end
