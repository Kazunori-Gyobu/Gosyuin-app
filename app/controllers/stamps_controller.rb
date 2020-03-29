class StampsController < ApplicationController

  def index
    @stamps = Stamp.page(params[:page]).per(15)

  end
  
  def show
    @stamp = Stamp.find(params[:id])
  end

  def new
    @stampbooks = Stampbook.all
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
    @stampbooks = Stampbook.all
    @stamp = Stamp.find(params[:id])
  end

  def update
    
  end

  def destroy
    
  end

  private

  def stamp_params
    params.require(:stamp).permit(:name, :given_date, :photo, :remove_photo, :remarks, :distinction, :stampbook_id)
  end
end
