class Library 
  attr_reader :name,
              :books,
              :authors,
              :checked_out_books

  def initialize(name)
    @name = name
    @books = []
    @authors = []
    @checked_out_books = []
  end

  def add_author(author)
    author.books.each { |book| @books << book }
    @authors << author 
  end

  def publication_time_frame_for(author)
    start_date = author.books.map { |book| book.publication_year.to_i}.min.to_s 
    end_date = author.books.map { |book| book.publication_year.to_i}.max.to_s
    {:start=>start_date, :end=>end_date}
  end

  def checkout(book)
    if @books.include?(book) && !@checked_out_books.include?(book) 
      @checked_out_books << book 
      true 
    else 
      false 
    end
  end
end