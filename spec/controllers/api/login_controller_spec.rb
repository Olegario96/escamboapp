require 'rails_helper'

RSpec.describe Api::LoginController, type: :controller do
  before(:all) do
    @email = 'member@member.com'
    @passsword = '123456'
  end

  describe 'POST #index' do
    it 'returns token' do
      post :index, login: { :email => @email, :password => @passsword }
      expect(response.body).to include('token')
    end

    it 'return error message for invalid member' do
      post :index, login: { :email => Faker::Internet.email, :password => @passsword }
      expect(response.body).to include("Can't find member")
    end

    it 'return code 400 for invalid member' do
      post :index, login: { :email => Faker::Internet.email, :password => @passsword }
      expect(response).to have_http_status(400)
    end
  end
end
