require_relative '../associations/classroom_class'

RSpec.describe Classroom do
  let(:classroom) { Classroom.new('Green') }
  let(:student) { instance_double('Student') }

  describe '#initialize' do
    it 'creates a new Classroom object with a label and no students' do
      expect(classroom).to be_a(Classroom)
      expect(classroom.label).to eq('Green')
      expect(classroom.students).to be_empty
    end
  end

  describe '#add_student' do
    it 'adds a student to the classroom' do
      expect(student).to receive(:add_classroom).with(classroom)
      classroom.add_student(student)
      expect(classroom.students).to include(student)
    end
  end
end
