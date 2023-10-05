require_relative 'student_class'
require_relative 'teacher_class'
require_relative 'associations/book_class'

class App
  LETTER_REGEX = /^[a-z]+$/i

  def initialize
    @books = []
    @people = []
    @classrooms = []
  end

  def list_books
    puts "Books:"
    puts "-----------------------"
    @books.each_with_index do |book, idx|
      puts "#{idx + 1}) Title: #{book.title}, Author: #{book.author}"
      puts "-----------------------"
    end
  end

  def list_people
    puts "People:"
    puts "----------------------------------"
    @people.each_with_index do |person, idx|
      puts "#{idx + 1}) Type: #{person.class}, Name: #{person.name}, Age: #{person.age}, Parent Permission: #{person.parent_permission}"
      puts "----------------------------------"
    end
  end

  def create_person
    if @classrooms.empty?
      person_type = age = 0
      name = ''
      until [1, 2].include?(person_type)
        clear_screen
        print "Do you want to create a STUDENT (1) or a TEACHER (2)? [Input the number]: "
        person_type = gets.chomp.to_i
        if person_type != 1 && person_type != 2
          puts "Warning [INSERT 1 or 2]. [Press ENTER to continue]"
          gets.chomp
        end
      end
      until (1..119).cover?(age)
        clear_screen
        print "Age: "
        age = gets.chomp.to_i
        if age <= 0
          puts "Insert a valid AGE. [Press ENTER to continue]"
        end
      end
      until !name.empty? && name.match(LETTER_REGEX)
        clear_screen
        print "Name: "
        name = gets.chomp.capitalize
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
            parent_acceptance = gets.chomp.to_s.capitalize
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
            print "Specialization: "
            specialization = gets.chomp.capitalize
            if !specialization.match(LETTER_REGEX)
              puts "Insert a valid SPECIALIZATION. [Press ENTER to continue]"
              gets.chomp
            end
          end
          @people << Teacher.new(age, specialization, name, true)
      end
      clear_screen
      puts "Person created successfully!"
    else
      puts "You have to create at least 1 CLASSROOM before continue!"
    end
  end

  def clear_screen
    system("clear") || system("cls")
  end

  def create_book
    title = author = ''
    until !title.empty? && title.match(LETTER_REGEX)
      clear_screen
      print 'Title: '
      title = gets.chomp.capitalize
      if title.match(LETTER_REGEX)
        puts "Insert a valid TITLE. [Press ENTER to continue]"
        gets.chomp
      end
    end
    until !author.empty? && author.match(LETTER_REGEX)
      clear_screen
      print 'Author: '
      author = gets.chomp.capitalize
      if author.match(LETTER_REGEX)
        puts "Insert a valid AUTHOR. [Press ENTER to continue]"
        gets.chomp
      end
    end
    @books << Book.new(title, author)
    puts "Book created successfully!"
  end
end

app = App.new
app.create_person
app.list_people