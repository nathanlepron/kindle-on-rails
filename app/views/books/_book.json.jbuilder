json.extract! book, :id, :title, :author, :publish_year, :number_borrow, :created_at, :updated_at
json.url book_url(book, format: :json)
