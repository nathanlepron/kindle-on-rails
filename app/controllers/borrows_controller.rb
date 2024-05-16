class BorrowsController < ApplicationController
    def index
        content_not_found
    end
    before_action :require_login, only: %i[ create_borrow close_borrow ]
    def create_borrow
        if current_user
          @book = Book.find(params[:id])
            @borrow = Borrow.new(
              user: current_user,
              book_id: @book.id,
              started_at: Time.current
            )
        
            if @borrow.save
              # Mettre à jour le stock du produit
              @book.increment!(:number_borrow)
        
              redirect_to books_path, notice: "Emprunt réalisé avec succès."
            else
              Rails.logger.debug("Emprunts errors: #{@borrow.errors.inspect}")
              redirect_to books_path, alert: "Erreur lors de l'emprunt."
            end
        else
          redirect_to new_session_path
        end
      end
      def close_borrow
        if current_user
          @book = Book.find(params[:id])
          @borrow = Borrow.find_by(book_id:@book.id, ended_at:nil)
          @borrow.ended_at = Time.current
            if @borrow.save
                return_to = params[:return_to]
                case return_to
                when book_path(params[:id])
                  redirect_to books_path, notice: "Livre rendu avec succès."
                when user_path(current_user.id)
                  redirect_to user_path(current_user.id), notice: "Livre rendu avec succès."
                when root_path
                    redirect_to root_path, notice: "Livre rendu avec succès."
                else
                  redirect_to books_path, notice: "Livre rendu avec succès."
                end
            else
              Rails.logger.debug("Emprunts errors: #{@borrow.errors.inspect}")
              redirect_to books_path, alert: "Erreur lors du retour de ce livre."
            end
        else
          redirect_to new_session_path
        end
      end
      private

      def require_login
        unless logged_in?
          redirect_to new_session_path, alert: "Vous devez être connecté pour emprunter un livre."
        end
      end
end
