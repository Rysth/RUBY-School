class Rental
  attr_accessor :date
  attr_reader :person, :book

  def initialize(date, book = nil, person = nil)
    @date = date
    @book = book.nil? ? nil : book
    @person = person.nil? ? nil : person
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

  def to_json(*_args)
    { Date: @date, Person: {
      id: @person.id,
      name: @person.name
    }, Book: {
      id: @book.id,
      title: @book.title
    } }
  end
end
