class SessionsController < ApplicationController
    def new
    end

    def create
        @user = User.find_by(email: params[:user][:email])
        if @user && @user.authenticate(params[:user][:password])
          session[:user_id] = @user.id 
          redirect_to user_path(@user)
        else
        flash[:notice] = 'EMAIL OR PASSWORD INCORRECT'
          render :new
        end
      end

    def destroy
        reset_session
        redirect_to root_path
    end

    def omniauth
        if params[:provider] == "google_oauth2"
        @user = User.from_omniauth(auth)
        @user.save
        session[:user_id] = @user.id
        redirect_to user_path(@user)
        elsif params[:provider] == "facebook"
            @user = User.from_omniauth(auth)
        @user.save
        session[:user_id] = @user.id
        redirect_to user_path(@user)
        end
    end


    private 
    def auth
       request.env['omniauth.auth'] 
    end
end
