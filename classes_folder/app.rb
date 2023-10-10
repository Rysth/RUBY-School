require 'date'
require_relative '../modules/commands_module'
require_relative '../modules/list_module'
require_relative '../modules/menu_module'
require_relative 'person_folder/student_class'
require_relative 'person_folder/teacher_class'
require_relative 'book_folder/book_class'
require_relative '../associations/rental_class'

class App
  LETTER_REGEX = /^[a-z ]+$/i.freeze

  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def run
    Menu.main(self)
  end

  def list_rentals_by_person
    Commands.clear_screen
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
      display_rentals_for_person(person_id)
    end
  end

  def list_books
    Commands.clear_screen
    if @books.empty?
      puts "There're no books yet. [Press ENTER to continue]"
      gets.chomp
    else
     List.display_book_list(@books)
    end
  end

  def list_people
    Commands.clear_screen
    if @people.empty?
      puts "There're no people yet. [Press ENTER to continue]"
      gets.chomp
    else
      List.display_people_list(@people)
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

    Commands.clear_screen
    puts 'Person created successfully! [Press ENTER to continue]'
    gets.chomp
  end

  # Helper methods for input validation
  def choose_person_type
    person_type = 0
    until [1, 2].include?(person_type)
      Commands.clear_screen
      puts 'Welcome to the CREATE_PERSON method.'
      print 'Do you want to create a STUDENT (1) or a TEACHER (2)? [Input the number]: '
      person_type = gets.chomp.to_i
    end
    person_type
  end

  def input_age
    age = 0
    until (1..120).cover?(age)
      Commands.clear_screen
      print "What's your age?: "
      age = gets.chomp.to_i
    end
    age
  end

  def input_name
    name = ''
    until !name.empty? && name.match(LETTER_REGEX)
      Commands.clear_screen
      print "What's your name?: "
      name = gets.chomp.capitalize.strip
    end
    name
  end

  def input_parent_acceptance
    parent_acceptance = ''
    until %w[Y N].include?(parent_acceptance)
      Commands.clear_screen
      print 'Has parent permission? [Y/N]: '
      parent_acceptance = gets.chomp.to_s.capitalize.strip
    end
    parent_acceptance
  end

  def input_specialization
    specialization = ''
    until !specialization.empty? && specialization.match(LETTER_REGEX)
      Commands.clear_screen
      print "What's your specialization?: "
      specialization = gets.chomp.capitalize.strip
    end
    specialization
  end

  def create_book
    title = input_valid_string('Title')
    author = input_valid_string('Author')

    @books << Book.new(title, author)

    Commands.clear_screen
    puts 'Book created successfully! [Press ENTER to continue]'
    gets.chomp
  end

  def input_valid_string(prompt)
    input = ''
    until !input.empty? && input.match(LETTER_REGEX)
      Commands.clear_screen
      print "What's the #{prompt}: "
      input = gets.chomp.strip.capitalize
    end
    input
  end

  def create_rental
    return unless valid_rental?

    person_selected = select_person
    book_selected = select_book

    Commands.clear_screen
    puts "Rental --> Person: #{person_selected.name} Book: #{book_selected.title} [Press ENTER to continue]"
    rental = Rental.new(Date.today.strftime('%Y-%m-%d'))
    rental.add_book(book_selected)
    rental.assign_person(person_selected)
    @rentals << rental

    gets.chomp
  end

  def valid_rental?
    if @books.empty? || @people.empty?
      Commands.clear_screen
      puts 'Please, add one BOOK and one PERSON. [Press ENTER to continue]'
      gets.chomp
      return false
    end
    true
  end

  def select_person
    person_number = 0
    until person_number != 0 && person_number.positive? && person_number <= @people.size
      Commands.clear_screen
      puts 'Welcome to the CREATE_RENTAL method.'
      list_people
      print 'Who are you? [Write the NUMBER] : '
      person_number = gets.chomp.to_i
    end
    @people[person_number - 1]
  end

  def select_book
    book_number = 0
    until book_number != 0 && book_number.positive? && book_number <= @books.size
      list_books
      print 'What book do you want? [Write the NUMBER]: '
      book_number = gets.chomp.to_i
    end
    @books[book_number - 1]
  end

  def display_rentals_for_person(id)
    Commands.clear_screen
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
 
end
