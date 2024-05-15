class UsersController < ApplicationController
    def show
        @user = User.find(params[:id])
    end
    def edit
      @user = User.find(params[:id])
    end
  
    def update
      @user = User.find(params[:id])
  
      if @user.update(user_params)
        redirect_to @user, notice: 'Utilisateur mis à jour avec succès.'
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation)
    end
  end