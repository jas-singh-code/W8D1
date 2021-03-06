class SubsController < ApplicationController
    before_action :require_signed_in, only:[:edit, :update, :new, :create]
    def new
        @sub = Sub.new
        render :new
    end

    def create
        @sub = Sub.new(sub_params)
        @subs.user_id = params[:user_id]
        if @sub.save
            redirect_to users_url
        else 
            flash.now[:errors]= @subs.errors.full_messages
            render :new
        end
    end

    def edit
        @sub = Sub.find_by(id: params[:id])
        render :edit
    end

    def update
        @sub = current_user.subs.find_by(id: params[:id])
        if @sub.update_attributes(sub_params)
            redirect_to sub_url(@sub)
        else
            flash.now[:errors]= @sub.errors.full_messages
            render :edit
        end
    end

    def show
        @sub = Sub.find_by(id: params[:id])
        render :show
    end

    def index
        @subs = Sub.all
        render :index
    end

    def sub_params
        params.require(:sub).permit(:title, :description)
    end
end
