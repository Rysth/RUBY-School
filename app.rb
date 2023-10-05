require_relative 'student_class'
require_relative 'teacher_class'

class App
  def initialize
    @books = []
    @people = []
    @classrooms = []
  end

  def list_books
    puts "Books:"
    puts "-----------------------"
    @books.each do |book|
      puts "Title: #{book.title}, Author: #{book.author}"
      puts "-----------------------"
    end
  end

  def list_people
    puts "People:"
    puts "----------------------------------"
    @people.each do |person|
      puts "Type: #{person.class}, Name: #{person.name}, Age: #{person.age}, Parent Permission: #{person.parent_permission}"
      puts "----------------------------------"
    end
  end

  def create_person
    if @classrooms.empty?
      person_type = 0
      until person_type == 1 || person_type == 2
        system("clear") || system("cls")
        print "Do you want to create a STUDENT (1) or a TEACHER (2)? [Input the number]: "
        person_type = gets.chomp.to_i
        if person_type != 1 && person_type != 2
          puts "Warning [INSERT 1 or 2]. [Press ENTER to continue]"
          
        end
      end
      age = 0
      until age > 0
        system("clear") || system("cls")
        print "Age: "
        age = gets.chomp.to_i
        if age <= 0
          puts "Insert a valid AGE. [Press ENTER to continue]"
          gets.chomp
        end
      end
      name = ''
      until name != '' && name.match(/^[a-z]+$/i)
        system("clear") || system("cls")
        print "Name: "
        name = gets.chomp.capitalize
        if !name.match(/^[a-z]+$/i)
          puts "Insert a valid NAME. [Press ENTER to continue]"
          gets.chomp
        end
      end
      case person_type
        when 1
          parent_acceptance = ''
          until parent_acceptance == 'Y' || parent_acceptance == 'N'
            system("clear") || system("cls")
            print "Has parent permission? [Y/N]: "
            parent_acceptance = gets.chomp.to_s.capitalize
            if !parent_acceptance.match(/^[a-z]+$/i)
              puts "Insert a valid ACCEPTANCE. [Press ENTER to continue]"
              gets.chomp
            end
          end
          permision = parent_acceptance == 'Y'
          @people << Student.new(age, '', name, permision)
        when 2
          specialization = ""
          until specialization != '' && specialization.match(/^[a-z]+$/i)
            system("clear") || system("cls")
            print "Specialization: "
            specialization = gets.chomp.capitalize
            if !specialization.match(/^[a-z]+$/i)
              puts "Insert a valid SPECIALIZATION. [Press ENTER to continue]"
              gets.chomp
            end
          end
          @people << Teacher.new(age, specialization, name, true)
      end
      system("clear") || system("cls")
      puts "Person created successfully!"
    else
      puts "You have to create at least 1 CLASSROOM before continue!"
    end
  end
end

app = App.new
app.create_person
app.list_people