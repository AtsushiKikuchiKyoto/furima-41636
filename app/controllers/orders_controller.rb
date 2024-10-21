class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    set_params_and_key 
    sold_out = Order.find_by(item_id: @item.id).present?
    item_owner = current_user.id == @item.user_id
  
    unless sold_out || item_owner
      @order_delivery = OrderDelivery.new
    else
      redirect_to root_path
    end
  end

  def create
    @order_delivery = OrderDelivery.new(order_params)
    if @order_delivery.valid?
      pay_item
      @order_delivery.save
      redirect_to root_path
    else
      set_params_and_key
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_delivery).permit(:post_code, :prefecture_id, :city, :street_address, :building, :tel).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    @item = Item.find(order_params[:item_id])
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def set_params_and_key
    @item = Item.find(params[:item_id])
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
  end

end
