class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]
  before_action :require_login, only: %i[ create edit destroy update ]
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
    redirect_to books_path, alert: 'Vous ne possédez pas les autorisations pour créer un livre.'
  end

  # GET /books/1/edit
  def edit
    redirect_to books_path, alert: 'Vous ne possédez pas les autorisations pour éditer un livre.'
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
      @book = Book.find_by(id: params[:id])
    
      if @book.present?
        # do your stuff
      else
        content_not_found
      end
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :author, :publish_year, :number_borrow)
    end
    def require_login
      unless logged_in?
        redirect_to new_session_path, alert: "Vous devez être connecté pour effectuer une action sur un livre."
      end
    end
end
