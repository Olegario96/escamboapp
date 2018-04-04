class Api::LoginController < ApplicationController
  before_action :authenticate, only: [:index]

  def index
    if @member
      render json: @member.tokens.last
    else
      render json: "Can't find member with email: #{params_login[:email]}", status: 400
    end
  end

  def authenticate
    @member = Member.find_by_email(params_login[:email])
    if @member
      if @member.valid_password?(params_login[:password])
        @member.add_token(:activate, expires_at: 1.hour.from_now)
      end
    end
  end

  private
    def params_login
      params.require(:login).permit(:email, :password)
    end
end
