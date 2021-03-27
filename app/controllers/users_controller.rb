class UsersController < ApplicationController
    def index
        redirect_to user_path(current_user)
    end
    
    def new
        @user = User.new
    end

    def show
        if current_user
            @user = User.find(params[:id])
        else 
            redirect_to '/'
        end
    end

    def create
        @user = User.new(user_params)
        if @user.save 
        session[:user_id] = @user.id
        redirect_to user_path(@user)
        else 
        render :new
        end

    end

    private 
    
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation )
    end
end
