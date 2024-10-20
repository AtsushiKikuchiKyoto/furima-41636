class OrderDelivery
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :prefecture_id, :city, :street_address, :building, :tel

  with_options presence: true do
    validates :city, :street_address
    validates :user_id, :item_id
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Input like (111-1111)"}
    validates :tel, format: { with: /\A\d{10,11}\z/, message: "is invalid. Enter 10 or 11 numbers without hyphen(-)" }
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Delivery.create(post_code: post_code, prefecture_id: prefecture_id, city: city, street_address: street_address, building: building, tel: tel, order_id: order.id)
  end
end