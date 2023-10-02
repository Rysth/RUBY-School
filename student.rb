require_relative 'person'

class Student < Person

  def initialize(id, age, classroom, name, parent_permission)
    super(id, age, name, parent_permission)
    @classroom = classroom
  end

  def play_hooky
    "¯\(ツ)/¯"
  end
end

student = Student.new(1, 20, 'ABC', 'John', false)