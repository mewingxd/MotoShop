class Service < ApplicationRecord
  belongs_to :mechanic
  has_many :service_products, dependent: :destroy
  has_many :products, through: :service_products

  validates :client_name, presence: true
  validates :status, inclusion: { in: %w[pending finished] }

  before_validation :set_default_status

  private

  def set_default_status
    self.status ||= "pending"
  end
end
