class BaseApiControllerController < ApplicationController
  before_filter :parse_request, :authenticate_user_from_token!

  private
    def authenticate_user_from_token!
      if !@json['escambo_token']
        render nothing: true, status: unauthorized
      else
        @member = nil
        Member.find_each do |m|
          if Devise.secure_compare(m.api_token, @json['escambo_token'])
            @member = m
        end
      end
    end

    def parse_quest
      @json = JSON.parse(request.body.read)
    end
end
