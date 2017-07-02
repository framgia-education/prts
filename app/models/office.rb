class Office < ApplicationRecord
  paginates_per Settings.admin.office.per_page

  has_many :users

  validates :name, presence: true
  validates :address, presence: true

  ATTR_PARAMS = [:name, :address, :description].freeze
end
