class Order < ActiveRecord::Base
  belongs_to :ad
  belongs_to :buyer, class_name: 'Member', :foreign_key => 'buyer_id'

  enum status: [:requested, :waiting, :analysing, :paid, :available, :dispute, :returned, :canceled, :debited, :temporary_retention]
end
