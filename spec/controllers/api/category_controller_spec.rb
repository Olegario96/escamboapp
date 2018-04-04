require 'rails_helper'

RSpec.describe Api::CategoryController, type: :controller do
  before(:each) do
    @email = 'member@member.com'
    @category = Category.offset(rand(Category.count)).first
    @token = Member.find_by_email(@email).tokens.last
    request.headers['escambo_token'] =  "#{@token.token}"
  end

  describe 'GET #index' do
    it 'returns all categories' do
      get :index
      expect(response.body).to include(@category.to_json)
    end

    it 'returns a single category' do
      post :show, category: { :id => @category.id }
      expect(response.body).to include(@category.to_json)
    end

    it 'returns a category created' do
      description = Faker::Commerce.department
      post :create, category: { :description => description }
      expect(response.body).to include(description)
    end

    it 'returns a category updated' do
      description = Faker::Commerce.department
      post :create, category: { :id => @category.id, :description => description }
      expect(response.body).to include(description)
    end

    it 'returns a id with category destroyed' do
      id = @category.id
      post :destroy, category: { :id => @category.id }
      expect(response.body).to include(id.to_s)
    end
  end
end
