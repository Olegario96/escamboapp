class Api::BaseApiController< ApplicationController
  before_action :parse_request, :authenticate_member_from_token!

  def index
  end

  private
    def authenticate_member_from_token!
      if !request.headers[:escambo_token]
        render nothing: true, status: :unauthorized
      else
        @member = Member.find_by_valid_token(:activate, request.headers['escambo_token'])
        render nothing: true, status: 200
      end
    end

    def parse_request
      if request.post? or request.delete?
        @json = JSON.parse(request.body.read)
      end
    end

    def validate_json(condition)
      unless condition
        render nothing: true, status: :bad_request
      end
    end
end
