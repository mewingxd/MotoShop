class Client < ApplicationRecord
  has_many :sales

  validates :name, presence: true
end
