class StampbooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: :destroy

  def index
    @stampbooks = Stampbook.page(params[:page]).per(15)

  end

  def show
    @stampbook = Stampbook.find(params[:id])
  end

  def new
    @stampbook = Stampbook.new
  end

  def create
    @stampbook = current_user.stampbooks.build(stampbook_params)
    if @stampbook.save
      flash[:success] = "御朱印帳が登録されました！"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @stampbook = current_user.stampbooks.find_by(id: params[:id])
  end

  def update
    @stampbook = current_user.stampbooks.find_by(id: params[:id])
    if @stampbook.update_attributes(stampbook_params)
      flash[:notice] = "御朱印帳の編集に成功しました"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    @stampbook.destroy
    flash[:notice] = "御朱印帳を削除しました"
    redirect_to request.referrer || root_url
  end

  private

  def stampbook_params
    params.require(:stampbook).permit(:name, :given_date, :cover, :remove_cover, :remarks, :distinction)
  end

  def correct_user
    @stampbook = current_user.stampbooks.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end
end
