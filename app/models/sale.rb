class Sale < ApplicationRecord
  belongs_to :client, optional: true
  has_many :sale_items, dependent: :destroy

  validates :total, numericality: { greater_than_or_equal_to: 0 }
end
