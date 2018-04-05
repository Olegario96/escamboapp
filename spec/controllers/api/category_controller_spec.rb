require 'rails_helper'

RSpec.describe Api::CategoryController, type: :controller do
  before(:each) do
    @category = Category.offset(rand(Category.count)).first
    @token = Member.find_by_email('member@member.com').tokens.last
    request.headers['escambo_token'] = "#{@token.token}"
  end

  describe 'GET #index' do
    it 'returns all categories' do
      get :index
      expect(response.body).to include(@category.to_json)
    end
  end

  describe 'POST #show' do
    it 'returns a single category' do
      post :show, category: { :id => @category.id }
      expect(response.body).to include(@category.to_json)
    end
  end

  describe 'POST #create' do
    it 'returns a category created' do
      description = Faker::Commerce.department
      post :create, category: { :description => description }
      expect(response.body).to include(description)
    end
  end

  describe 'POST #update' do
    it 'returns a category updated' do
      description = Faker::Commerce.department
      post :update, category: { :id => @category.id, :description => description }
      expect(response.body).to include(description)
    end
  end

  describe 'POST #destroy' do
    it 'returns a id with category destroyed' do
      post :create, category: { :description => Faker::Commerce.department }
      id = Category.last.id
      post :destroy, category: { :id => Category.last.id }
      expect(response.body).to include(id.to_s)
    end
  end
end
