Rails.application.routes.draw do
  root 'site/home#index'
  post '/rate' => 'rater#create', :as => 'rate'
  get 'backoffice', to: 'backoffice/dashboard#index'

  namespace :backoffice do
    resources :send_mail, only: [:edit, :create]
    resources :categories, except: [:show, :destroy]
    resources :admins, except: [:show]
    resources :diagrams, only: [:index]
    get 'dashboard', to: 'dashboard#index'
  end

  namespace :site do
    get 'home', to: 'home#index'
    get 'search', to: 'search#ads'
    namespace :profile do
      resources :dashboard, only: [:index]
      resources :ads, only: [:index, :edit, :update, :new, :create]
      resources :my_data, only: [:edit, :update]
    end

    resources :ad_detail, only: [:index, :show]
    resources :categories, only: [:show]
    resources :comments, only: [:create]
  end

  namespace :checkout do
    resources :payments, only: [:create]
    resources :notifications, only: [:create]
  end

  devise_for :admins, :skip => [:registrations]
  devise_for :members, controllers: {
    sessions: 'members/sessions',
    registrations: 'members/registrations'
  }

  namespace :api do
    scope '/v1' do
      get '/' => 'base_api#index'
      scope '/login' do
        post '/' => 'login#index'
      end
      scope '/category' do
        get '/get-all' => 'category#index'
        post '/get' => 'category#show'
        post '/create' => 'category#create'
        post '/update' => 'category#update'
        post '/delete' => 'category#destroy'
      end
      scope '/member' do
        get '/get-all' => 'member#index'
        post '/get' => 'member#show'
        post '/create' => 'member#create'
        post '/update' => 'member#update'
        post '/delete' => 'member#destroy'
      end
      scope '/comment' do
        get '/get-all' => 'comment#index'
        post '/get' => 'comment#show'
        post '/create' => 'comment#create'
        post '/update' => 'comment#update'
        post '/delete' => 'comment#destroy'
      end
      scope '/ad' do
        get '/get-all' => 'ad#index'
        post '/get' => 'ad#show'
        post '/create' => 'ad#create'
        post '/update' => 'ad#update'
        post '/delete' => 'ad#destroy'
      end
    end
  end
end
