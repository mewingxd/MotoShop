class Product < ApplicationRecord
  belongs_to :category
  has_many :sale_items
  has_many :service_products
  has_many :purchases

  validates :name, presence: true
  validates :price_buy, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
end
