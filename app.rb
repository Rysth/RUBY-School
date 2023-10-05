require 'date'
require_relative 'student_class'
require_relative 'teacher_class'
require_relative 'associations/book_class'
require_relative 'associations/rental_class'

class App
  LETTER_REGEX = /^[a-z ]+$/i

  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def run
    clear_screen
    loop do
      puts "Welcome to the Application Menu:"
      puts "1. List all books"
      puts "2. List all people"
      puts "3. Create a person"
      puts "4. Create a book"
      puts "5. Create a rental"
      puts "6. List all rentals for a given person ID"
      puts "7. Quit"
  
      choice = get_user_choice(1..7)
  
      case choice
      when 1
        list_books
      when 2
        list_people
      when 3
        create_person
      when 4
        create_book
      when 5
        create_rental
      when 6
      clear_screen
      if !@rentals.empty?
        person_id = ''
        until !person_id.empty?
          list_people
          print "Please, type the ID of the person: "
          person_id = gets.chomp
        end
        list_rentals_by_person(person_id)
      else
        puts "There're no rentals yet. [Press ENTER to continue]"
        gets.chomp
      end
      when 7
        clear_screen
        puts "Thanks!"
        puts "Made By RysthCraft"
        puts "--------------------"
        puts "LinkedIn: @john-palacios-rysthcraft"
        puts "Github: @Rysth"
        break
      end
    end
  end

  def list_books
    clear_screen
    if !@books.empty?
      puts "Books:"
      puts "----------------------------------"
      @books.each_with_index do |book, idx|
        puts "#{idx + 1}) Title: #{book.title}, Author: #{book.author}"
      end
      puts "----------------------------------"
    else
      puts "There're no books yet. [Press ENTER to continue]"
      gets.chomp
    end
  end

  def list_people
    clear_screen
    if !@people.empty?
      puts "People:"
      puts "----------------------------------"
      @people.each_with_index do |person, idx|
        puts "#{idx + 1}) ID: #{person.id}, Type: #{person.class}, Name: #{person.name}, Age: #{person.age}, Parent Permission: #{person.parent_permission}"
      end
      puts "----------------------------------"
    else
      puts "There're no people yet. [Press ENTER to continue]"
      gets.chomp
    end
  end

  def create_person
    person_type = age = 0
    name = ''
    until [1, 2].include?(person_type)
      clear_screen
      puts "Welcome to the CREATE_PERSON method."
      print "Do you want to create a STUDENT (1) or a TEACHER (2)? [Input the number]: "
      person_type = gets.chomp.to_i
      if person_type != 1 && person_type != 2
        puts "Warning [INSERT 1 or 2]. [Press ENTER to continue]"
        gets.chomp
      end
    end
    until (1..119).cover?(age)
      clear_screen
      print "What's your age?: "
      age = gets.chomp.to_i
      if age <= 0
        puts "Insert a valid AGE. [Press ENTER to continue]"
        gets.chomp
      end
    end
    until !name.empty? && name.match(LETTER_REGEX)
      clear_screen
      print "What's your name?: "
      name = gets.chomp.capitalize.strip
      if !name.match(LETTER_REGEX)
        puts "Insert a valid NAME. [Press ENTER to continue]"
        gets.chomp
      end
    end
    case person_type
      when 1
        parent_acceptance = ''
        until parent_acceptance == 'Y' || parent_acceptance == 'N'
          clear_screen
          print "Has parent permission? [Y/N]: "
          parent_acceptance = gets.chomp.to_s.capitalize.strip
          if !parent_acceptance.match(LETTER_REGEX)
            puts "Insert a valid ACCEPTANCE. [Press ENTER to continue]"
            gets.chomp
          end
        end
        permision = parent_acceptance == 'Y'
        @people << Student.new(age, '', name, permision)
      when 2
        specialization = ''
        until !specialization.empty? && specialization.match(LETTER_REGEX)
          clear_screen
          print "What's your specialization?: "
          specialization = gets.chomp.capitalize.strip
          if !specialization.match(LETTER_REGEX)
            puts "Insert a valid SPECIALIZATION. [Press ENTER to continue]"
            gets.chomp
          end
        end
        @people << Teacher.new(age, specialization, name, true)
    end
    clear_screen
    puts "Person created successfully! [Press ENTER to continue]"
    gets.chomp
  end

 

  def create_book
    title = author = ''
    until !title.empty? && title.match(LETTER_REGEX)
      clear_screen
      puts "Welcome to the CREATE_BOOK method."
      print 'Title: '
      title = gets.chomp.capitalize.strip
      if !title.match(LETTER_REGEX)
        puts "Insert a valid TITLE. [Press ENTER to continue]"
        gets.chomp
      end
    end
    until !author.empty? && author.match(LETTER_REGEX)
      clear_screen
      print 'Author: '
      author = gets.chomp.capitalize.strip
      if !author.match(LETTER_REGEX)
        puts "Insert a valid AUTHOR. [Press ENTER to continue]"
        gets.chomp
      end
    end
    @books << Book.new(title, author)
    puts "Book created successfully! [Press ENTER to continue]"
    gets.chomp
  end

  def create_rental
    if !@books.empty? && !@people.empty?
      person_number = book_number = 0
      until person_number != 0 && person_number > 0
        clear_screen
        puts "Welcome to the CREATE_RENTAL method."
        list_people
        print "Who are you? [Write the NUMBER] : "
        person_number = gets.chomp.to_i
      end
      puts "----------------------------------"
      until book_number != 0 && book_number > 0
        list_books
        print "What book do you want? [Write the NUMBER]: "
        book_number = gets.chomp.to_i
      end
      person_selected = @people[person_number-1]
      book_selected = @books[book_number-1]
      clear_screen
      puts "Rental --> Person: #{person_selected.name} Book: #{book_selected.title} [Press ENTER to continue]"
      rental = Rental.new(Date.today.strftime('%Y-%m-%d'))
      rental.add_book(book_selected)
      rental.assign_person(person_selected)
      @rentals << rental
      gets.chomp
    else
      clear_screen
      puts "Please, add one BOOK and one PERSON. [Press ENTER to continue]"
      gets.chomp
    end
  end

  #TODO 
  def list_rentals_by_person(id)
    clear_screen
    rentals_found = false

    puts "----------------------------------"
    @rentals.each do |rental|
      if rental.person.id == id
        @books.each do |book|
          next if rental.book.id != book.id
          puts "Person: #{rental.person.name} --> Book: #{book.title}"
          rentals_found = true
        end
      end
    end 

    if !rentals_found
      puts "This PERSON doesn't have any rentals."
    end
    puts "----------------------------------"
    puts "[Press ENTER to continue]"
    gets.chomp
  end

  private

  def clear_screen
    system("clear") || system("cls")
  end

  def get_user_choice(range)
    choice = nil
    until range.include?(choice)
      print "Enter your choice: "
      choice = gets.chomp.to_i
      puts "Invalid choice. Please enter a valid option." unless range.include?(choice)
    end
    choice
  end
  
end
