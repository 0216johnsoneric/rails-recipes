class ApplicationController < ActionController::Base
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

 
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end
    helper_method :current_user
    private

    def record_not_found
      redirect_to root_path
    end
end
