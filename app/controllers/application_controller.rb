class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    def not_found_method
      render template: 'shared/404', status: :not_found, layout: 'layouts/application'
    end
    private
  
    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
  
    def logged_in?
      !!current_user
    end

    helper_method :current_user, :logged_in?
  end