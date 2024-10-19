class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    if user_signed_in? 
      unless current_user.id == @item.user_id
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    redirect_to item_path(item.id)
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :content, :category_id, :condition_id, :postage_id, :prefecture_id,
                                 :lead_time_id, :price).merge(user_id: current_user.id)
  end
end
