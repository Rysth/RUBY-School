require_relative '../classes/person/person_class'
require_relative '../associations/rental_class'
require_relative '../classes/book/book_class'

describe Person do
  context 'When valid input' do
    describe 'using the initialize() method' do
      it 'create a new Person with name John' do
        person = Person.new(nil, 20, 'John', parent_permission: true)
        expect(person.id).not_to be_nil
        expect(person.name).to eql 'John'
        expect(person.age).to be >= 18
        expect(person.parent_permission).to be true
      end
    end
    describe 'using the can_use_services?() method' do
      it 'create a new Person with age 16' do
        person = Person.new(nil, 16, 'John', parent_permission: true)
        expect(person.id).not_to be_nil
        expect(person.name).to eql 'John'
        expect(person.age).not_to be >= 18
        expect(person.parent_permission).to be true
        expect(person.can_use_services?).to be true
      end
    end
    describe 'using the correct_name() method' do
      it 'create a new Person with name John' do
        person = Person.new(nil, 18, 'John', parent_permission: false)
        expect(person.correct_name).to eql 'John'
      end
    end
    describe 'using the add_rental() method' do
      it 'creates a new Rental for a Person' do
        date = Date.new(2023, 10, 12)
        book = Book.new('B001', 'Test Book', 'John')
        person = Person.new(nil, 20, 'John', parent_permission: true)
        rental = Rental.new(date, book, person)
        person.add_rental(rental)
        expect(person.rentals).not_to be_nil
      end
    end
    describe 'using the to_json() method' do
      it 'returns a JSON representation of the Person' do
        person = Person.new('0a6c', 23, 'John Palacios', parent_permission: true)
        expected_json = { ID: '0a6c', Type: person.class, Name: 'John Palacios', Age: 23 }
        expect(person.to_json).to eql(expected_json)
      end
    end
  end
  context 'When wrong input' do
    describe 'using the initialize() method' do
      it 'create a new Person with name John' do
        person = Person.new('0a6c', 20, 'Jean', parent_permission: true)
        expect(person.id).to eql '0a6c'
        expect(person.name).not_to eql 'John'
        expect(person.age).to be_between(18, 120).inclusive
        expect(person.parent_permission).to be true
      end
    end
    describe 'using the can_use_services?() method' do
      it 'create a new Person with age 16' do
        person = Person.new(nil, 16, 'John', parent_permission: false)
        expect(person.id).not_to be_nil
        expect(person.name).to eql 'John'
        expect(person.age).not_to be >= 18
        expect(person.parent_permission).to be false
        expect(person.can_use_services?).not_to be true
      end
    end
    describe 'using the correct_name() method' do
      it 'create a new Person with name John' do
        person = Person.new(nil, 18, nil, parent_permission: false)
        expect(person.correct_name).to be nil
      end
    end
    describe 'using the add_rental() method' do
      it 'creates a new Rental for a Person' do
        date = Date.new(2023, 10, 12)
        book = Book.new('B001', 'Test Book', 'John')
        person = Person.new(nil, 50, 'John', parent_permission: true)
        rental = Rental.new(date, book, person)
        person.add_rental(rental)
        book_two = Book.new('B002', 'Test Book', 'John')
        rental_expect = Rental.new(date, book_two, person)
        expect(person.rentals[0]).not_to eql(rental_expect)
      end
    end
    describe 'using the to_json() method' do
      it 'returns a JSON representation of the Person' do
        person = Person.new('0a6c', 20, 'John', parent_permission: true)
        expected_json = { ID: '0a6c', Type: person.class, Name: 'John Palacios', Age: 23 }
        expect(person.to_json).not_to eql(expected_json)
      end
    end
  end
end
