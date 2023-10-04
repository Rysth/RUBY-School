class App
  def initialize
    @books = []
    @people = []
    @classrooms = []
  end

  def list_books
    @books.each do |book|
      puts "Book[Title: #{book.title}, Author: #{book.author}]"
    end
  end

  def list_people
    @people.each do |person|
      puts "Person[ID: #{person.id}, Name: #{person.name}, Age: #{person.age}], ParentPermission: #{person.parent_permission}, Type: #{person.class}"
    end
  end

  def create_person
    if @classroom.size !== 0
      print "Do you want to create a STUDENT (1) or a TEACHER (2)? [Input the number]: "
      person_type = gets.chomp.to_int!
      print "Age: "
      age = gets.chomp.to_int!
      print "Name: "
      name = gets.chomp.to_s.capitalize!
      case person_type
        when 1
          print "Has parent permission? [Y/N]: "
          parent_acceptance = gets.chomp.to_s.capitalize!
          permision = return false if parent_acceptance == 'N' || return true if parent_acceptance == 'Y'
          @people << Student.new(age, '', name, permision)
        when 2
          print "Specialization: "
          specialization = gets.chomp.to_s.capitalize!
          @people << Teacher.new(age, specialization, name, true)
      end
      puts "Person created successfully!"
    else
      puts "You have to create at least 1 CLASSROOM before continue!"
    end
  end
end