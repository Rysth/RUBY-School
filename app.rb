class App
  def initialize
    @books = []
    @people = []
  end

  def list_books
    @books.each do |book|
      puts "Book[Title: #{book.title}, Author: #{book.author}]"
    end
  end

  def list_people
    @people.each do |person|
      puts "Person[ID: #{person.id}, Name: #{person.name}, Age: #{person.age}], ParentPermission: #{person.parent_permission}, Type: #{person.class}"
    end
  end
end