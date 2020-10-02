class UsersController < ApplicationController
   before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
   before_action :correct_user, only: [:edit, :update]
   before_action :admin_user, only: :destroy

    def index
        @users = User.paginate(page: params[:page])
        # @users = User.all
        
    end

    def show
        @user = User.find(params[:id])
        @posts=@user.posts.paginate(page: params[:page ])
    end

    def new
        @user = User.new
    end

    def edit
        @user = User.find(params[:id])
    end

    def create
        @user = User.new(user_params)
        if @user.save
            # UserMailer.account_acivation(@user).deliver_now
            # flash[:info] = "Please Check Your Email to Activate Your Account."
            # redirect_to root_url
            log_in @user
            flash[:success] = "Welcome To The Posting App!"
            redirect_to user_path(@user)
        else 
            render 'new'
        end
                
    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_params) 
            flash[:success] = "Profile Updates!"
            redirect_to user_path(@user)
        else  
            render 'edit'  
        end
        
    end

    def destroy
        if  User.find(params[:id]).destroy
            flash[:success] = "User Deleted"
            redirect_to users_path 
        end    
    end

    def following
        @title = "Following"
        @user = User.find(params[:id])
        @users = @user.following.paginate(page: params[:page])
        render 'show_follow' 
    end

    def followers
        @title = "Followers"
        @user = User.find(params[:id])
        @users = @user.followers.paginate(page: params[:page])
        render 'show_follow' 
    end

    private

        def user_params
            params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
        end

        def logged_in_user
            unless logged_in?
            store_location
            flash[:danger] = "Please Log in To Have Access"
            redirect_to login_url
            end 
        end

        def correct_user
            @user = User.find(params[:id])
            redirect_to(root_url) unless current_user?(@user)
        end

        def admin_user
            redirect_to (root_url) unless current_user.admin?
        end
end
