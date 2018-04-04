require 'rails_helper'

RSpec.describe Api::BaseApiController, type: :controller do
  before(:all) do
    @email = 'member@member.com'
    @member = Member.find_by_email(@email)
  end

  describe 'GET #index' do
    it 'returns code 200 for valid token' do
      request.headers['escambo_token'] = "#{@member.tokens.last.token}"
      get :index
      expect(response).to have_http_status(200)
    end
  end
end
