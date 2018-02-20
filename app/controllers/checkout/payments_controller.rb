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

    payment = PagSeguro::PaymentRequest.new
    payment.reference = order.id
    payment.notification_url = root_url
    payment.redirect_url = site_ad_detail_url(ad)

    payment.items << {
      id: ad.id,
      description: ad.title,
      amount: ad.price.to_s.gsub(',', '.')
    }

    response = payment.register
    if response.errors.any?
      redirect_to site_ad_detail_path(ad), alert: 'Erro ao processar compra... Entre em contato com SAC'
    else
      redirect_to response.url
    end
  end
end
