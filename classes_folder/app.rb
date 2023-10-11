require 'date'
require_relative '../modules/input_module'
require_relative '../modules/commands_module'
require_relative '../modules/list_module'
require_relative '../modules/menu_module'
require_relative '../modules/manager_module'
require_relative 'person_folder/student_class'
require_relative 'person_folder/teacher_class'
require_relative 'book_folder/book_class'
require_relative '../associations/rental_class'

class App
  attr_reader :books, :people, :rentals

  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def run
    Menu.main(self)
  end

  def list_books
    Commands.clear_screen
    @books = Manager.load('books').map { |book_data| Book.new(book_data['Title'], book_data['Author']) }

    if @books.empty?
      puts "There're no books yet. [Press ENTER to continue]"
      gets.chomp
    else
      List.display_book_list(@books)
    end
  end

  def list_people
    Commands.clear_screen

    @people = Manager.load('people').map do |people_data|
      if people_data['Type'] == 'Student'
        Student.new(people_data['Age'], people_data['Classroom'], people_data['Name'],
                    people_data['Parent Permission'])
      else
        Teacher.new(people_data['Age'], people_data['Specialization'], people_data['Name'],
                    people_data['Parent Permission'])
      end
    end

    if @people.empty?
      puts "There're no people yet. [Press ENTER to continue]"
      gets.chomp
    else
      List.display_people_list(@people)
    end
  end

  def create_person
    person_type = Input.choose_person_type
    age = Input.input_age
    name = Input.input_name

    case person_type
    when 1
      parent_acceptance = Input.input_parent_acceptance
      permission = parent_acceptance == 'Y'
      @people << Student.new(age, '', name, permission)
    when 2
      specialization = Input.input_specialization
      @people << Teacher.new(age, specialization, name, true)
    end

    Commands.clear_screen
    puts 'Person created successfully! [Press ENTER to continue]'
    gets.chomp
  end

  def create_book
    title = Input.input_valid_string('Title')
    author = Input.input_valid_string('Author')

    @books << Book.new(title, author)

    Commands.clear_screen
    puts 'Book created successfully! [Press ENTER to continue]'
    gets.chomp
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
      List.display_rentals_for_person(person_id, self)
    end
  end
end
