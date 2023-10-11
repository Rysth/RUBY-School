module List
  def self.display_people_list(collection)
    puts 'People:'
    puts '----------------------------------'
    collection.each_with_index do |person, idx|
      display_person_info(person, idx)
    end
    puts '----------------------------------'
  end

  def self.display_person_info(person, idx)
    info = if person.class == Student
             "#{idx + 1}) ID: #{person.id}, " \
               "Type: #{person.class}, " \
               "Name: #{person.name}, " \
               "Age: #{person.age}, " \
               "Parent Permission: #{person.parent_permission}"
           else
             "#{idx + 1}) ID: #{person.id}, " \
               "Type: #{person.class}, " \
               "Name: #{person.name}, " \
               "Age: #{person.age}, " \
               "Specialization: #{person.specialization}, " \
               "Parent Permission: #{person.parent_permission}"
           end
    puts info
  end

  def self.display_book_list(collection)
    puts 'Books:'
    puts '----------------------------------'
    collection.each_with_index do |book, idx|
      puts "#{idx + 1}) ID: #{book.id}, Title: #{book.title}, Author: #{book.author}"
    end
    puts '----------------------------------'
  end

  def self.display_rentals_for_person(id, app)
    Commands.clear_screen
    rentals_found = false

    puts '----------------------------------'
    app.rentals.each do |rental|
      next unless rental.person.id == id

      app.books.each do |book|
        next if rental.book.id != book.id

        puts "Person: #{rental.person.name} --> Book: #{book.title}"
        rentals_found = true
      end
    end

    puts "This PERSON doesn't have any rentals." unless rentals_found
    puts '----------------------------------'
    puts '[Press ENTER to continue]'
    gets.chomp
  end
end
