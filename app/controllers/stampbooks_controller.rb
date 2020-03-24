class StampbooksController < ApplicationController
  before_action :authenticate_user!

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
      
    else
      render 'edit'
    end
  end

  def destroy
    
  end

  private

  def stampbook_params
    params.require(:stampbook).permit(:name, :given_date, :cover, :remarks, :type)
  end
end
