class RegistrationsController < ApplicationController
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
  
      if @user.save
        redirect_to root_path, notice: "Inscription réussie !"
        session[:user_id] = @user.id
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:email, :lastname, :firstname, :password, :password_confirmation)
    end
  end