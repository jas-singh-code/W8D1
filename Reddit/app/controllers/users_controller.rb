class UsersController < ApplicationController

    def index
        @users = User.all
        render :index
    end

    def show
        @user = User.find_by(username: username)
        render :show
    end

    def new
        @user = User.new
        render :new
    end

    def create #signup
        @user = User.new(user_params)
        if @user.save
            signin!(@user)
            redirect_to users_url
        else 
            flash.now[:errors] = @user.errors.full_messages #render coud be seen as return so 
            #need to save this flash var first before rendering
            render :new
        end
    end

    def user_params
        params.require(:user).permit(:username, :password)
    end
end
