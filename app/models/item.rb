class Item < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_one :buyer
  has_one :address

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :delivery_fee
  belongs_to_active_hash :shipping_region
  belongs_to_active_hash :days_until_shipping

  with_options presence: true do
    validates :images
    validates :name
    validates :content
    validates :price, numericality: { only_integer: true,
                                      greater_than: 300, less_than: 9_999_999,
                                      message: 'は規定の範囲外です' }
    validates :category
    validates :status
    validates :delivery_fee
    validates :shipping_region
    validates :days_until_shipping
  end

  # 選択が「---」の場合は保存できないようにする
  with_options numericality: { other_than: 1, message: 'を選択してください' } do
    validates :category_id
    validates :status_id
    validates :delivery_fee_id
    validates :shipping_region_id
    validates :days_until_shipping_id
  end
end
