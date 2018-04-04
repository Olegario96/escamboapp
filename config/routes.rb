Rails.application.routes.draw do
  mount_devise_token_auth_for 'Member', at: 'auth'
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
  scope '/api' do
    scope '/v1' do
      scope '/category' do
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
