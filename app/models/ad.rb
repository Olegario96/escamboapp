class Ad < ActiveRecord::Base
  belongs_to :member
  belongs_to :category

  monetize :price_cents

  has_attached_file :picture, styles: { medium: '320x150#', thumb: '100x100>' }, default: '/images/:styles/missing.png'
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/
end
