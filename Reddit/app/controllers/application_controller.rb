class ApplicationController < ActionController::Base
    helper_method :signed_in?, :current_user
    
    def signin!(user) # OR login
        @current_user = user
        session[:session_token] = current_user.reset_sesssion_token!
    end

    def signed_in?
        !!@current_user
    end

    def signout!
        @current_user.reset_sesssion_token!
        @current_user = nil #just changing pointer not actual info
        session[:session_token] = nil
    end

    def require_signed_in 
        redirect_to new_session_url unless signed_in?
    end

    def require_signed_out
        redirect_to users_url if signed_in?
    end
    
    def current_user #setter & getter for currentuser
        @current_user ||= User.find_by_session_token(session[:session_token])
    end

end
