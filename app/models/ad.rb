class Ad < ActiveRecord::Base
  belongs_to :member
  belongs_to :category

  scope :descending_order, ->(amount=9) { limit(amount).order(created_at: :desc) }
  scope :ads_for_current_member, ->(current_member) { where(member: current_member) }

  monetize :price_cents

  has_attached_file :picture, styles: { medium: '320x150>', thumb: '100x100>' }, default: '/images/:styles/missing.png'
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/
end
