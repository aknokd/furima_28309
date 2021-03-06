require 'rails_helper'

RSpec.describe ItemBuyer, type: :model do
  before do
    @item_buyer = FactoryBot.build(:item_buyer)
  end

  describe '商品購入機能' do
    context '商品の購入が成功する場合' do
      it '全て正しく入力されていれば購入できる' do
        expect(@item_buyer).to be_valid
      end
      it 'building_nameは空でも購入できる' do
        @item_buyer.building_name = nil
        expect(@item_buyer).to be_valid
      end
    end

    context '商品の購入が失敗する場合' do
      it 'クレジットカードの情報がないと購入できない' do
        @item_buyer.token = ''
        @item_buyer.valid?
        expect(@item_buyer.errors.full_messages).to include('カード情報を入力してください')
      end
      it 'postal_codeが空だと購入できない' do
        @item_buyer.postal_code = nil
        @item_buyer.valid?
        expect(@item_buyer.errors.full_messages).to include('郵便番号を入力してください')
      end
      it 'postal_codeにハイフンが入っていないと購入できない' do
        @item_buyer.postal_code = '1234567'
        @item_buyer.valid?
        expect(@item_buyer.errors.full_messages).to include('郵便番号にハイフンを含めてください')
      end
      it 'prefectureが空だと購入できない' do
        @item_buyer.prefecture = nil
        @item_buyer.valid?
        expect(@item_buyer.errors.full_messages).to include('都道府県を入力してください')
      end
      it 'cityが空だと購入できない' do
        @item_buyer.city = nil
        @item_buyer.valid?
        expect(@item_buyer.errors.full_messages).to include('市区町村を入力してください')
      end
      it 'house_numberが空だと購入できない' do
        @item_buyer.house_number = nil
        @item_buyer.valid?
        expect(@item_buyer.errors.full_messages).to include('番地を入力してください')
      end
      it 'phone_numberが空だと購入できない' do
        @item_buyer.phone_number = nil
        @item_buyer.valid?
        expect(@item_buyer.errors.full_messages).to include('電話番号を入力してください')
      end
      it 'phone_numberにハイフンが入っていると購入できない' do
        @item_buyer.phone_number = '090-123-456'
        @item_buyer.valid?
        expect(@item_buyer.errors.full_messages).to include('電話番号は不正な値です')
      end
    end
  end
end
