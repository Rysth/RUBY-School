require_relative 'person_class'

class Student < Person
  attr_accessor :classroom

  def initialize(id = nil, age, classroom, name, parent_permission)
    super(id, age, name, parent_permission: parent_permission)
    @classroom = classroom
  end

  def play_hooky
    '¯(ツ)/¯'
  end

  def add_classroom(classroom)
    @classroom = classroom
    classroom.add_student(self)
  end

  def to_json(*_args)
    { ID: @id, Type: self.class, Name: @name, Age: @age, Classroom: @classroom, Parent_Permission: @parent_permission }
  end
end
