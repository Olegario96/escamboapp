class Checkout::PaymentsController < ApplicationController
  def create
    render text: "Processing..."
  end
end
