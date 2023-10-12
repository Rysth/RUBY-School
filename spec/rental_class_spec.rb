require 'date'
require_relative '../associations/rental_class'
require_relative '../classes/person/person_class'
require_relative '../classes/book/book_class'

describe Rental do
  context 'when valid input' do
    describe 'using the initialize() method' do
      it 'creates a new Rental' do
        date = Date.new(2023, 10, 12)
        book = Book.new('B001', 'Test Book', 'John')
        person = Person.new(nil, 20, 'John', parent_permission: true)
        rental = Rental.new(date, book, person)
        expect(rental.date).to eql date
        expect(rental.book).to eql book
        expect(rental.person).to eql person
      end
    end

    describe 'using the add_book() method' do
      it 'assigns a book to the rental' do
        date = Date.new(2023, 10, 12)
        rental = Rental.new(date)
        book = Book.new('B001', 'Test Book', 'John')
        rental.add_book(book)
        expect(rental.book).to eql book
        expect(book.rentals).to include(rental)
      end
    end

    describe 'using the assign_person() method' do
      it 'assigns a person to the rental' do
        date = Date.new(2023, 10, 12)
        book = Book.new('B001', 'Test Book', 'John')
        rental = Rental.new(date, book)
        person = Person.new('0ACB', 20, 'John', parent_permission: true)
        rental.assign_person(person)
        expect(rental.person).to eql person
        expect(person.rentals).to include(rental)
      end
    end

    describe 'using the to_json() method' do
      it 'converts the rental to a JSON representation' do
        date = Date.new(2023, 10, 12)
        book = Book.new('B001', 'Test Book', 'John')
        person = Person.new(nil, 20, 'John', parent_permission: true)
        rental = Rental.new(date, book, person)
        json_result = rental.to_json
        expect(json_result).to eq({
          Date: date,
          Person: { id: person.id, name: person.name },
          Book: { id: book.id, title: book.title }
        })
      end
    end
  end

  context 'when invalid input' do
    describe 'using the initialize() method' do
      it 'creates a new Rental with missing date' do
        rental = Rental.new(nil, nil, nil)
        expect(rental.date).to be_nil
        expect(rental.book).to be_nil
        expect(rental.person).to be_nil
      end
    end

    describe 'using the add_book() method' do
      it 'does not assign a book when one is already assigned' do
        date = Date.new(2023, 10, 12)
        book = Book.new('B001', 'Test Book', 'John')
        rental = Rental.new(date, book)
        another_book = Book.new('B002', 'Another Book', 'John')
        rental.add_book(another_book)
        expect(rental.book).not_to eql book
        expect(book.rentals).not_to include(another_book)
      end
    end

    describe 'using the assign_person() method' do
      it 'does not assign a person when one is already assigned' do
        date = Date.new(2023, 10, 12)
        book = Book.new('B001', 'Test Book', 'John')
        person = Person.new('0ACB', 20, 'John', parent_permission: true)
        rental = Rental.new(date, book, person)
        another_person =Person.new(nil, 20, 'Palacios', parent_permission: true)
        rental.assign_person(another_person)
        expect(rental.person).not_to eql person
        expect(person.rentals).not_to include(another_person)
      end
    end
  end
end
