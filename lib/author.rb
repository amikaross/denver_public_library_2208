require "./book"

class Author 
  attr_reader :name,
              :books
  
  def initialize(author_hash)
    @name = author_hash[:first_name] + " " + author_hash[:last_name]
    @first_name = author_hash[:first_name]
    @last_name = author_hash[:last_name]
    @books = []
  end

  def write(title, publication_date)
    book_hash = {
                  title: title,
                  author_first_name: @first_name,
                  author_last_name: @last_name,
                  publication_date: publication_date
                }
    book = Book.new(book_hash)
    @books << book
    book
  end
end