class Classroom
  attr_accessor :label
  def initialize
    @label = ""
    @students = []
  end

  def add_student(student)
    @students << student
    student.classroom = self
  end
end