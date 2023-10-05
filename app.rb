require 'date'
require_relative 'student_class'
require_relative 'teacher_class'
require_relative 'associations/book_class'
require_relative 'associations/rental_class'

class App
  LETTER_REGEX = /^[a-z ]+$/i.freeze

  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def run
    clear_screen
    loop do
      display_menu_options
      choice = get_user_choice(1..7)

      case choice
      when 1 then list_books
      when 2 then list_people
      when 3 then create_person
      when 4 then create_book
      when 5 then create_rental
      when 6
        clear_screen
        if @rentals.empty?
          puts "There're no rentals yet. [Press ENTER to continue]"
          gets.chomp
        else
          person_id = ''
          while person_id.empty?
            list_people
            print 'Please, type the ID of the person: '
            person_id = gets.chomp
          end
          list_rentals_by_person(person_id)
        end
      when 7
        clear_screen
        puts 'Thanks!'
        puts 'Made By RysthCraft'
        break
      end
    end
  end

  def list_books
    clear_screen
    if @books.empty?
      puts "There're no books yet. [Press ENTER to continue]"
      gets.chomp
    else
      puts 'Books:'
      puts '----------------------------------'
      @books.each_with_index do |book, idx|
        puts "#{idx + 1}) Title: #{book.title}, Author: #{book.author}"
      end
      puts '----------------------------------'
    end
  end

  def list_people
    clear_screen
    if @people.empty?
      puts "There're no people yet. [Press ENTER to continue]"
      gets.chomp
    else
      puts 'People:'
      puts '----------------------------------'
      @people.each_with_index do |person, idx|
        puts "#{idx + 1}) ID: #{person.id}, Type: #{person.class}, Name: #{person.name}, Age: #{person.age}, Parent Permission: #{person.parent_permission}"
      end
      puts '----------------------------------'
    end
  end

  def create_person
    person_type = choose_person_type
    age = input_age
    name = input_name

    case person_type
    when 1
      parent_acceptance = input_parent_acceptance
      permission = parent_acceptance == 'Y'
      @people << Student.new(age, '', name, permission)
    when 2
      specialization = input_specialization
      @people << Teacher.new(age, specialization, name, true)
    end

    clear_screen
    puts 'Person created successfully! [Press ENTER to continue]'
    gets.chomp
  end

  # Helper methods for input validation
  def choose_person_type
    person_type = 0
    until [1, 2].include?(person_type)
      clear_screen
      puts 'Welcome to the CREATE_PERSON method.'
      print 'Do you want to create a STUDENT (1) or a TEACHER (2)? [Input the number]: '
      person_type = gets.chomp.to_i
    end
    person_type
  end

  def input_age
    age = 0
    until (1..120).cover?(age)
      clear_screen
      print "What's your age?: "
      age = gets.chomp.to_i
    end
    age
  end

  def input_name
    name = ''
    until !name.empty? && name.match(LETTER_REGEX)
      clear_screen
      print "What's your name?: "
      name = gets.chomp.capitalize.strip
    end
    name
  end

  def input_parent_acceptance
    parent_acceptance = ''
    until %w[Y N].include?(parent_acceptance)
      clear_screen
      print 'Has parent permission? [Y/N]: '
      parent_acceptance = gets.chomp.to_s.capitalize.strip
    end
    parent_acceptance
  end

  def input_specialization
    specialization = ''
    until !specialization.empty? && specialization.match(LETTER_REGEX)
      clear_screen
      print "What's your specialization?: "
      specialization = gets.chomp.capitalize.strip
    end
    specialization
  end

  def create_book
    title = input_valid_string('Title')
    author = input_valid_string('Author')

    @books << Book.new(title, author)

    clear_screen
    puts 'Book created successfully! [Press ENTER to continue]'
    gets.chomp
  end

  def input_valid_string(prompt)
    input = ''
    until !input.empty? && input.match(LETTER_REGEX)
      clear_screen
      print "What's the #{prompt}: "
      input = gets.chomp.strip.capitalize
    end
    input
  end

  def create_rental
    if !@books.empty? && !@people.empty?
      person_number = book_number = 0
      until person_number != 0 && person_number.positive? && person_number <= @people.size
        clear_screen
        puts 'Welcome to the CREATE_RENTAL method.'
        list_people
        print 'Who are you? [Write the NUMBER] : '
        person_number = gets.chomp.to_i
      end
      puts '----------------------------------'
      until book_number != 0 && book_number.positive? && book_number <= @books.size
        list_books
        print 'What book do you want? [Write the NUMBER]: '
        book_number = gets.chomp.to_i
      end
      person_selected = @people[person_number - 1]
      book_selected = @books[book_number - 1]
      clear_screen
      puts "Rental --> Person: #{person_selected.name} Book: #{book_selected.title} [Press ENTER to continue]"
      rental = Rental.new(Date.today.strftime('%Y-%m-%d'))
      rental.add_book(book_selected)
      rental.assign_person(person_selected)
      @rentals << rental
    else
      clear_screen
      puts 'Please, add one BOOK and one PERSON. [Press ENTER to continue]'
    end
    gets.chomp
  end

  # TODO
  def list_rentals_by_person(id)
    clear_screen
    rentals_found = false

    puts '----------------------------------'
    @rentals.each do |rental|
      next unless rental.person.id == id

      @books.each do |book|
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

  private

  def display_menu_options
    puts 'Welcome to the Application Menu:'
    puts '1. List all books'
    puts '2. List all people'
    puts '3. Create a person'
    puts '4. Create a book'
    puts '5. Create a rental'
    puts '6. List all rentals for a given person ID'
    puts '7. Quit'
  end

  def clear_screen
    system('clear') || system('cls')
  end

  def get_user_choice(range)
    choice = nil
    until range.include?(choice)
      print 'Enter your choice: '
      choice = gets.chomp.to_i
      puts 'Invalid choice. Please enter a valid option.' unless range.include?(choice)
    end
    choice
  end
end
