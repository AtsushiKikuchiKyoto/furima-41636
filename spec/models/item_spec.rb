require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  context 'アイテム新規登録できる場合' do
    it 'アイテム登録ができる' do
      expect(@item).to be_valid
    end
  end
  context 'アイテム新規登録できない場合' do
    it '画像なしでは登録できない' do
      @item.image.purge
      @item.valid?
      expect(@item.errors.full_messages).to include "Image can't be blank"
    end
    it '商品名なしでは登録できない' do
      @item.name = ''
      @item.valid?
      expect(@item.errors.full_messages).to include "Name can't be blank"
    end
    it '説明なしでは登録できない' do
      @item.content = ''
      @item.valid?
      expect(@item.errors.full_messages).to include "Content can't be blank"
    end
    it 'カテゴリーの選択なしでは登録できない' do
      @item.category_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include "Category can't be blank"
    end
    it '商品の状態の選択なしでは登録できない' do
      @item.condition_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include "Condition can't be blank"
    end
    it '送料負担の選択なしでは登録できない' do
      @item.postage_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include "Postage can't be blank"
    end
    it '発送元地域の選択なしでは登録できない' do
      @item.prefecture_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include "Prefecture can't be blank"
    end
    it '発送までの日数の選択なしでは登録できない' do
      @item.lead_time_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include "Lead time can't be blank"
    end
    it '販売価格なしでは登録できない' do
      @item.price = ''
      @item.valid?
      expect(@item.errors.full_messages).to include 'Price is not a number'
    end
    it '販売価格300円未満では登録できない' do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include 'Price must be in 300..9999999'
    end
    it '販売価格9999999円より大きいでは登録できない' do
      @item.price = 99999999 + 1
      @item.valid?
      expect(@item.errors.full_messages).to include 'Price must be in 300..9999999'
    end
    it '販売価格全角では登録できない' do
      @item.price = '５００'
      @item.valid?
      expect(@item.errors.full_messages).to include 'Price is not a number'
    end
    it '販売価格小数点では登録できない' do
      @item.price = 500.5
      @item.valid?
      expect(@item.errors.full_messages).to include 'Price must be an integer'
    end
    it 'ユーザーが紐づいてなければ登録できない' do
      @item.user = nil
      @item.valid?
      expect(@item.errors.full_messages).to include('User must exist')
    end
  end
end
