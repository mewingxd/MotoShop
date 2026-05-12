class Mechanic < ApplicationRecord
  has_many :services

  validates :full_name, presence: true
  before_validation :set_active_default

  private

  def set_active_default
    self.active = true if active.nil?
  end
end
