class App
  def initialize
    @books = []
    @people = []
  end

  def list_books
    @books.each do |book|
      puts "Book[Title: #{title}, Author: #{author}]"
    end
  end
end