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
    info = "#{idx + 1}) ID: #{person.id}, " \
           "Type: #{person.class}, " \
           "Name: #{person.name}, " \
           "Age: #{person.age}, " \
           "Parent Permission: #{person.parent_permission}"
    puts info
  end

  def self.display_book_list(collection)
    puts 'Books:'
    puts '----------------------------------'
    collection.each_with_index do |book, idx|
      puts "#{idx + 1}) Title: #{book.title}, Author: #{book.author}"
    end
    puts '----------------------------------'
  end
end