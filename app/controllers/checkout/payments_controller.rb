class Checkout::PaymentsController < ApplicationController
  def create
    ad = Ad.find(params[:ad])
    ad.processing!
    order = Order.create(ad: ad, buyer_id: current_member.id)
    order.waiting!
    render text: "Processing... Pedido: #{order.status_i18n} - Anúncio: #{ad.status_i18n}"
  end
end
