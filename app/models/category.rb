class Category < ActiveRecord::Base
  validates_presence_of :description

  has_many :ads

  scope :order_by_description, -> { order(:description) }
end
