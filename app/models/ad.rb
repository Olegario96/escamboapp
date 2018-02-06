class Ad < ActiveRecord::Base
  AMOUNT_PER_PAGE = 6

  before_save :md_to_html

  belongs_to :member
  belongs_to :category, counter_cache: true
  has_many :comments

  validates :title, :description_md, :description_short, :category, :price, :picture, :finish_date, presence: true
  validates :price, numericality: { greater_than: 0 }

  scope :descending_order, ->(page=1) { order(created_at: :desc).page(page).per(AMOUNT_PER_PAGE) }
  scope :ads_for_current_member, ->(current_member) { where(member: current_member) }
  scope :by_category, ->(id, page=1) { where(category: id).page(page).per(AMOUNT_PER_PAGE) }
  scope :search, ->(q, page) { where("lower(title) LIKE ?", "%#{q.downcase}%").page(page).per(AMOUNT_PER_PAGE) }

  monetize :price_cents

  has_attached_file :picture, styles: { medium: '320x150#', thumb: '100x100>', large: '800x300#' }, default: '/images/:styles/missing.png'
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

  private
    def md_to_html
      options = {
        filter_html: true,
        link_attributes: {
          rel: 'nofollow',
          target: '_blank'
        }
      }

      extensions = {
        space_after_headers: true,
        autolink: true
      }

      renderer = Redcarpet::Render::HTML.new(options)
      markdown = Redcarpet::Markdown.new(renderer, extensions)

      self.description = markdown.render(self.description_md)
    end
end
