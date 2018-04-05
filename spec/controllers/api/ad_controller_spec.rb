require 'rails_helper'

RSpec.describe Api::AdController, type: :controller do
  before(:each) do
    @ad = Ad.offset(rand(Ad.count)).first
    @token = Member.find_by_email('member@member.com').tokens.last
    request.headers['escambo_token'] = "#{@token.token}"
  end

  describe 'GET #index' do
    it 'returns all categories' do
      get :index
      expect(response.body).to include(@ad.to_json)
    end
  end

  describe 'POST #show' do
    it 'returns an ad' do
      post :show, ad: { :id => @ad.id }
      expect(response.body).to include(@ad.to_json)
    end
  end

  describe 'POST #create' do
    it 'returns an ad created' do
      title = Faker::Lorem.sentence([2,3,4,5].sample)
      description_md = Faker::Lorem.sentence([2,3].sample)
      description_short = Faker::Lorem.sentence([2,3].sample)
      category = Category.all.sample.id
      finish_date = Date.today + Random.rand(90)
      price = "#{Random.rand(500)},#{Random.rand(99)}"
      post :create, ad: { title: title,
                          description_md: description_md,
                          description_short: description_md,
                          category_id: category,
                          finish_date: finish_date,
                          price: price }
      expect(response.body).to include(title)
    end
  end

  describe 'POST #update' do
    it 'returns a category updated' do
      title = Faker::Lorem.sentence([2,3,4,5].sample)
      description_md = Faker::Lorem.sentence([2,3].sample)
      description_short = Faker::Lorem.sentence([2,3].sample)
      category = Category.all.sample.id
      finish_date = Date.today + Random.rand(90)
      price = "#{Random.rand(500)},#{Random.rand(99)}"
      post :update, ad: { id: @ad.id,
                          title: title,
                          description_md: description_md,
                          description_short: description_md,
                          category_id: category,
                          finish_date: finish_date,
                          price: price }
      expect(response.body).to include(title)
    end
  end

  # describe 'POST #destroy' do
  #   it 'return id for ad destroyed' do
  #     id = @ad.id
  #     post :destroy, ad: { :id => id }
  #     expect(response.body).to include(@ad.to_json)
  #   end
  # end
end
