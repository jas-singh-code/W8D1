class SessionsController < ApplicationController
    before_action :require_signed_in, only:[:destroy]
    before_action :require_signed_out, only:[:new, :create]

    def new
        render :new
    end

    def create #creating session = loggin in
        @user = User.find_by_credentials(
            params[:user][:username],
            params[:user][:password]
        )
        if @user
            signin!(@user)
            redirect_to users_url
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    def destroy
        signout!
        redirect_to new_session_url
    end
end
