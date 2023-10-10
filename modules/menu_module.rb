require_relative 'commands_module'

module Menu
  def self.main(app)
    Commands.clear_screen
    loop do
      display_menu_options
      choice = get_user_choice(1..7)

      case choice
      when 1 then app.list_books
      when 2 then app.list_people
      when 3 then app.create_person
      when 4 then app.create_book
      when 5 then app.create_rental
      when 6 then app.list_rentals_by_person
      when 7
        quit
        break
      end
    end
  end

  def self.display_menu_options
    puts 'Welcome to the Application Menu:'
    puts '1. List all books'
    puts '2. List all people'
    puts '3. Create a person'
    puts '4. Create a book'
    puts '5. Create a rental'
    puts '6. List all rentals for a given person ID'
    puts '7. Quit'
  end

  def self.get_user_choice(range)
    choice = nil
    until range.include?(choice)
      print 'Enter your choice: '
      choice = gets.chomp.to_i
      puts 'Invalid choice. Please enter a valid option.' unless range.include?(choice)
    end
    choice
  end

  def self.quit
    Commands.clear_screen
    puts 'Thanks!'
    puts 'Made By RysthCraft'
  end
end
