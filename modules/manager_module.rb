require 'json'
require_relative '../classes/book/book_class'
require_relative '../classes/person/student_class'
require_relative '../classes/person/teacher_class'
require_relative '../associations/rental_class'

module Manager
  DATA_FOLDER = './data'.freeze

  def self.charge_data(app)
    app.books = load('books').map do |book_data|
      Book.new(book_data['ID'], book_data['Title'], book_data['Author'])
    end

    app.people = load('people').map do |people_data|
      if people_data['Type'] == 'Student'
        Student.new(people_data['ID'], people_data['Age'], people_data['Classroom'], people_data['Name'],
                    people_data['Parent_Permission'])
      else
        Teacher.new(people_data['ID'], people_data['Age'], people_data['Specialization'], people_data['Name'],
                    people_data['Parent_Permission'])
      end
    end

    return unless !app.books.empty? && !app.people.empty?

    app.rentals = load('rentals').map do |rental_data|
      Rental.new(rental_data['Date'],
      app.books.find { |book| book.id == rental_data['Book']['id'] },
      app.people.find { |person| person.id == rental_data['Person']['id'] })
    end
  end

  def self.load(data)
    file_path = File.join(DATA_FOLDER, "#{data}.json")
    if File.exist?(file_path)
      JSON.parse(File.read(file_path))
    else
      []
    end
  end

  def self.write_file(filename, collection)
    file = File.new("./data/#{filename}", 'w+')
    json_array = collection.map(&:to_json)
    file.syswrite(JSON.pretty_generate(json_array))
    file.close
  end
end
