class Rental
  attr_accessor :date

  def initialize(date)
    @date = date
    @book = nil
    @person = nil
  end

  def add_book(book)
    @book = book
    book.add_rental(self)
  end

  def assign_person(person)
    @person = person
    person.add_rental(self)
  end
end