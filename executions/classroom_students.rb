require_relative '../student_class'
require_relative '../associations/classroom_class'

# Create a Classroom
classroom_a = Classroom.new("Class A")

# Create some Students
student1 = Student.new(16, classroom_a, "Alice", parent_permission: true)
student2 = Student.new(18, classroom_a, "Bob", parent_permission: false)
student3 = Student.new(17, classroom_a, "Charlie", parent_permission: true)

# Add students to the classroom
classroom_a.add_student(student1)
classroom_a.add_student(student2)
classroom_a.add_student(student3)

# Check the students in the classroom
puts "Classroom #{classroom_a.label} has the following students:"
classroom_a.students.each do |student|
  puts "--> #{student.name} (Age: #{student.age})"
end

# Create some more Classrooms
classroom_b = Classroom.new("Class B")
classroom_c = Classroom.new("Class C")

# Create additional students and associate them with different classrooms
student4 = Student.new(15, classroom_b, "David", parent_permission: true)
student5 = Student.new(17, classroom_c, "Eve", parent_permission: true)

# Check the students in each classroom
puts "Classroom #{classroom_b.label} has the following students:"
classroom_b.students.each do |student|
  puts "#{student.name} (Age: #{student.age})"
end

puts "Classroom #{classroom_c.label} has the following students:"
classroom_c.students.each do |student|
  puts "#{student.name} (Age: #{student.age})"
end
