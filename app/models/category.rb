class Category < ActiveRecord::Base
  include FriendlyId
  friendly_id :description, use: :slugged

  validates_presence_of :description

  has_many :ads

  scope :order_by_description, -> { order(:description) }
end
