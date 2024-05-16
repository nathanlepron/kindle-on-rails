class SessionsController < ApplicationController
    def new
    end
  
    def create
      @user = User.find_by(email: params[:email])
  
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        puts "Connexion réussie pour l'utilisateur #{@user.email}"
        redirect_to root_path, notice: "Connexion réussie !"
      else
        flash.now[:alert] = "Email ou mot de passe incorrect"
        render :new, status: :unprocessable_entity
      end
    end
  
    def destroy
      email = current_user.email
      session[:user_id] = nil
      puts "Déconnexion réussie pour l'utilisateur #{email}"
      redirect_to root_path, notice: "Déconnexion réussie !"
    end
  
  end
  