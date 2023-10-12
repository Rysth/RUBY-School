require_relative '../associations/classroom_class'
require_relative '../classes/person/student_class'

describe Student do
  context 'when valid input' do
    describe 'using the initialize() method' do
      it 'creates a new Student with name Palacios' do
        student = Student.new('30KL', 16, 'MICRO-CLASS', 'Palacios', parent_permission: false)
        expect(student.id).to eql '30KL'
        expect(student.name).not_to eql 'John'
        expect(student.age).to be <= 18
        expect(student.parent_permission[:parent_permission]).to be false
      end
    end
    describe 'using the play_hooky() method' do
      it 'creates a new Student with a random name' do
        student = Student.new(nil, 35, 'MICRO-CLASS', 'Random', parent_permission: true)
        expect(student.play_hooky).to eql '¯(ツ)/¯'
      end
    end
  end
  context 'when wrong input' do
    describe 'using the initialize() method' do
      it 'creates a new Student with the wrong ID' do
        student = Student.new('60KL', 16, 'MICRO-CLASS', 'Palacios', parent_permission: false)
        expect(student.id).not_to eql '30KL'
        expect(student.name).not_to be_nil
        expect(student.age).not_to be_between(18, 180)
        expect(student.parent_permission[:parent_permission]).to be false
      end
    end
    describe 'using the play_hooky() method' do
      it 'creates a new Student with a random name' do
        student = Student.new(nil, 35, 'MICRO-CLASS', 'Random', parent_permission: true)
        expect(student.play_hooky).not_to eql '¯\(ツ)/¯'
      end
    end
  end
end
