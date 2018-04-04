require 'rails_helper'

RSpec.describe Api::BaseApiController, type: :controller do
  before(:all) do
    @email = 'member@member.com'
    @member = Member.find_by_email(@email)
    @fake_token = 'oiJEUGHn3084nsq'
  end

  describe 'GET #index' do
    it 'returns code 200 for valid token' do
      request.headers['escambo_token'] = "#{@member.tokens.last.token}"
      get :index
      expect(response).to have_http_status(200)
    end

    it 'returns code 400 for bad formatted request' do
      get :index
      expect(response).to have_http_status(400)
    end

    it 'returns code 401 for invalid token' do
      request.headers['escambo_token'] = @fake_token
      get :index
      expect(response).to have_http_status(401)
    end
  end
end
