require 'rails_helper'

RSpec.describe Api::CategoryController, type: :controller do
  before(:each) do
    @email = 'member@member.com'
    @token = Member.find_by_email(@email).tokens.last
    request.headers['escambo_token'] = "#{@token.token}"
  end

  describe 'GET #index' do
    it 'returns all categories' do
      get :index
      expect(response).to have_http_status(200)
    end

    # it 'returns all categories' do
    #   get :show
    #   expect(response).to have_http_status(200)
    # end
  end
end
