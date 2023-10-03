require_relative '../person_class'
require_relative '../associations/rental_class'
require_relative '../associations/book_class'

# Create some books
book1 = Book.new("Book 1", "Author 1")
book2 = Book.new("Book 2", "Author 2")
book3 = Book.new("Book 3", "Author 3")

# Create some persons
person1 = Person.new(25, "Alice", parent_permission: true)
person2 = Person.new(19, "Bob", parent_permission: false)
person3 = Person.new(17, "Charlie", parent_permission: true)

# Create rentals and associate them with books and persons
rental1 = Rental.new("2023-10-01")
rental1.assign_person(person1)
rental1.add_book(book1)

rental2 = Rental.new("2023-10-02")
rental2.assign_person(person2)
rental2.add_book(book2)

rental3 = Rental.new("2023-10-03")
rental3.assign_person(person3)
rental3.add_book(book3)

# Check the rentals for each person
puts "#{person1.name}'s rentals:"
person1.rentals.each do |rental|
  puts "#{rental.book.title} (Date: #{rental.date})"
end

puts "#{person2.name}'s rentals:"
person2.rentals.each do |rental|
  puts "#{rental.book.title} (Date: #{rental.date})"
end

puts "#{person3.name}'s rentals:"
person3.rentals.each do |rental|
  puts "#{rental.book.title} (Date: #{rental.date})"
end