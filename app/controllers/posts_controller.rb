class PostsController < ApplicationController

   before_action :logged_in_user, only: [:create, :destroy]
   before_action :correct_user, only: :destroy

    def index
        @posts = Post.all
        
    end

    def show
        @post = Post.find(params[:id])
    end

    def new
        @post = Post.new
    end

    def edit
        @post = Post.find(params[:id])
    end

    def create
        @post = current_user.posts.build(post_params)
        @post.image.attach(params[:post][:image])
        if @post.save
            flash[:success] =  "Micropost Created!"
            redirect_to root_url
        else 
            @feed_items = current_user.feed.paginate(page: params[:page])
            render 'static_pages/home'
        end
                
    end

    def update
        @post = Post.find(params[:id])
        if @post.update(params) 
            redirect_to post_path(@post)
            
        end
        
    end

    def destroy
        # if  Post.find(params[:id]).destroy
        #     redirect_to posts_path 
        # end
        @post.destroy 
        flash[:success] = "Micropost Deleted"
        redirect_to request.referrer || root_url   
    end


    private
    def post_params
        # params.require(:post).permit(:title, :description, :user_id)
        params.require(:post).permit(:title, :description, :image)
        
    end

    def logged_in_user
        unless logged_in?
        store_location
        flash[:danger] = "Please Log in To Have Access"
        redirect_to login_url
        end 
    end

    def correct_user
        @post = current_user.posts.find_by(id: params[:id])
        redirect_to root_url if @post.nil?
    end

end

