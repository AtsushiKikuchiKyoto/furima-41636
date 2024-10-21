require 'rails_helper'

RSpec.describe OrderDelivery, type: :model do
  before do
    @order_delivery = FactoryBot.build(:order_delivery, user_id: 1, item_id: 1)
  end
  describe '購入機能の確認' do
    context '購入情報が正しい場合' do
      it 'すべて正しい情報が入力された場合(token含む)' do
        expect(@order_delivery).to be_valid
      end
      it '建物名が空白でも購入できる' do
        @order_delivery.building = ""
        expect(@order_delivery).to be_valid
      end
    end
    context '購入情報がまちがっている場合' do
      it '郵便番号がない' do
        @order_delivery.post_code = ""
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Post code can't be blank")
      end
      it '郵便番号にハイフンがない' do
        @order_delivery.post_code = "1231234"
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Post code is invalid. Input like (111-1111)")
      end
      it '郵便番号のハイフンの場所が間違い' do
        @order_delivery.post_code = "12-31234"
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Post code is invalid. Input like (111-1111)")
      end
      it '都道府県が選択されていない' do
        @order_delivery.prefecture_id = 1
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村が入力されていない' do
        @order_delivery.city = ""
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("City can't be blank")
      end
      it '番地が入力されていない' do
        @order_delivery.street_address = ""
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Street address can't be blank")
      end
      it '電話番号が入力されていない' do
        @order_delivery.tel = ""
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Tel can't be blank")
      end
      it '電話番号にハイフンが含まれる' do
        @order_delivery.tel = "090-1111-1111"
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Tel is invalid. Enter 10 or 11 numbers without hyphen(-)")
      end
      it '電話番号の桁数が10~11でない' do
        @order_delivery.tel = "0751111"
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Tel is invalid. Enter 10 or 11 numbers without hyphen(-)")
      end
      it '電話番号が全角数値' do
        @order_delivery.tel = "５５５５５５５５５５"
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Tel is invalid. Enter 10 or 11 numbers without hyphen(-)")
      end
      it 'トークンが空では登録できない' do
        @order_delivery.token = ""
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
