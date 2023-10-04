class Rental
  attr_accessor :date
  attr_reader :person, :book

  def initialize(date)
    @date = date
    @book = nil
    @person = nil
  end

  def add_book(book)
    return if @book == book

    @book = book
    book.add_rental(self)
  end

  def assign_person(person)
    return if @person == person

    @person = person
    person.add_rental(self)
  end
end
