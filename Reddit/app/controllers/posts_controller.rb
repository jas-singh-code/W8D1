class PostsController < ApplicationController
    # def index
    #     @posts = Posts.all
    #     render :index
    # end

    def show
        @post = Post.find_by(id: params[:id])
        render :show
    end

    def new
        @post = Post.new
        render :new
    end

    def create
        @post = Post.new(post_params)
        @post.user_id = params[:user_id]
        # @post.sub_id = post_params[:sub_id] get it from POSTSUBS
        if @post.save
            redirect_to user_url(@user)
        else
            flash.now[:errors] = @post.errors.full_messages
            render :new
        end
    end

    def edit
        @post = Post.find_by(id: params[:id])
        render :edit
    end

    def update
        @post = current_user.posts.find_by(id: params[:id])
        if @post.update(post_params)
            redirect_to post_url(@post)
        else
            flash.now[:errors]= @post.errors.full_messages
            render :edit
        end
    end

    private
    def post_params
        params.require(:post).permit(:title)
    end
end
