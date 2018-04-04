class ApplicationController < ActionController::Base
  before_filter :store_current_location, :unless => :devise_controller?
  before_filter :configure_permitted_parameters, if: :devise_controller?


  # Pundit import
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized


  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :layout_by_resource

  protected

    def layout_by_resource
      if devise_controller?
        if resource_name == :member
          'site_devise'
        else
          'backoffice_devise'
        end
      else
        'application'
      end
    end

    def user_not_authorized
      flash[:alert] = 'Você não está autorizado a executar esta ação.'
      redirect_to(request.referrer || root_path)
    end

  private
    def store_current_location
      store_location_for(:member, request.url)
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:account_update) << [:name]
    end
end
