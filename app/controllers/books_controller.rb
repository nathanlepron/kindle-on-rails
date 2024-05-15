class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]
  before_action :require_login, only: %i[ create edit destroy update create_borrow ]
  # GET /books or /books.json
  def index
    if params[:search]
      @books = Book.where("#{params[:filter]} LIKE ?", "%#{params[:search].downcase}%")
    else
      @books = Book.all
    end
  end

  # GET /books/1 or /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books or /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to book_url(@book), notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

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
      @borrow = Borrow.find_by(book_id:@book.id)
      @borrow.ended_at = Time.current
        if @borrow.save
          redirect_to books_path, notice: "Livre rendu avec succès."
        else
          Rails.logger.debug("Emprunts errors: #{@borrow.errors.inspect}")
          redirect_to books_path, alert: "Erreur lors du retour de ce livre."
        end
    else
      redirect_to new_session_path
    end
  end
  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to book_url(@book), notice: "Book was successfully updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy!

    respond_to do |format|
      format.html { redirect_to books_url, notice: "Book was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :author, :publish_year, :number_borrow)
    end
    def require_login
      unless logged_in?
        redirect_to new_session_path, alert: "Vous devez être connecté pour emprunter un livre."
      end
    end
end
