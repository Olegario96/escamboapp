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
        get '/' => 'api_category#index'
        post '/' => 'api_category#create'
        scope '/' do
          get '/' => 'api_category#show'
          post '/' => 'api_category#update'
          delete '/' => 'api_category#destroy'
        end
      end
      scope '/comment' do
      end
      scope '/member' do
      end
      scope '/profile_member' do
      end
      scope '/rate' do
      end
    end
  end
end
