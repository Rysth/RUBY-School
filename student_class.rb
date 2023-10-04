require_relative 'person_class'

class Student < Person
  attr_accessor :classroom

  def initialize(age, classroom, name, parent_permission)
    super(age, name, parent_permission: parent_permission)
    @classroom = classroom
    classroom.add_student(self)
  end

  def play_hooky
    '¯(ツ)/¯'
  end

  def add_classroom(classroom)
    @classroom = classroom
    classroom.add_student(self)
  end
end
