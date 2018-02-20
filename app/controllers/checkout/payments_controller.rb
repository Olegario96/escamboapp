class Checkout::PaymentsController < ApplicationController
  # email: c72450168074779934827@sandbox.pagseguro.com.br
  # senha: 8G9Wxm4UCt0F00VM
  # número CC: 4111111111111111
  # Bandeira: VISA Válido até: 12/2030 CVV: 123
  def create
    ad = Ad.find(params[:ad])
    ad.processing!
    order = Order.create(ad: ad, buyer_id: current_member.id)
    order.waiting!
    render text: "Processing... Pedido: #{order.status_i18n} - Anúncio: #{ad.status_i18n}"
  end
end
