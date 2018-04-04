class Api::BaseApiController< ApplicationController
  before_action :authenticate_member_from_token!

  def index
    render nothing: true, status: 200
  end

  protected
    def authenticate_member_from_token!
      if request.headers[:escambo_token]
        @member = Member.find_by_valid_token(:activate, request.headers['escambo_token'])
        if !@member
          render nothing: true, status: 401
        end
      else
        render nothing: true, status: 400
      end
    end
end
