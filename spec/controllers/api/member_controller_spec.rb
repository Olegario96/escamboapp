require 'rails_helper'

RSpec.describe Api::MemberController, type: :controller do
  before(:each) do
    @email = Faker::Internet.email
    @member = Member.offset(rand(Member.count)).first
    @token = Member.find_by_email('member@member.com').tokens.last
    request.headers['escambo_token'] = "#{@token.token}"
  end

  describe 'GET #index' do
    it 'returns all members' do
      get :index
      expect(response.body).to include(@member.to_json)
    end
  end

  describe 'POST #show' do
    it 'returns a single members' do
      post :show, member: { :id => @member.id }
      expect(response.body).to include(@member.to_json)
    end
  end

  describe 'POST #create' do
    it 'returns a member created' do
      post :create, member: { :email => @email }
      expect(response.body).to include(@email)
    end
  end

  describe 'POST #update' do
    it 'returns a member updated' do
      post :update, member: { :id => @member.id, :email => @email }
      expect(response.body).to include(@email)
    end
  end

  # describe 'POST #destroy' do
  #   it 'returns id for member destroyed' do
  #     id = @member.id
  #     post :destroy, member: { :id => @member.id }
  #     expect(response.body).to include(id.to_s)
  #   end
  # end
end
