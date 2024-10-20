class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @item = Item.find(params[:item_id])
    @order_delivery = OrderDelivery.new
  end

  def create
    @order_delivery = OrderDelivery.new(order_params)
    if @order_delivery.valid?
      @order_delivery.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end
  
  private

  def order_params
    params.require(:order_delivery).permit(:post_code, :prefecture_id, :city, :street_address, :building, :tel).merge(user_id: current_user.id, item_id:params[:item_id])
  end

end