class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    def not_found_method
      render template: 'shared/404', status: :not_found, layout: 'layouts/application'
    end
    def content_not_found
      render template: 'shared/204', status: 204, layout: 'layouts/application'
    end
    private
  
    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
  
    def logged_in?
      !!current_user
    end
    
    def get_best_borrows
      Book.where.not(number_borrow:nil).order(number_borrow: :desc).limit(8)
    end
    def get_current_borrows
      Borrow.where(user_id:current_user.id,ended_at:nil) if current_user
    end

    helper_method :current_user, :logged_in?, :get_best_borrows, :get_current_borrows
  end