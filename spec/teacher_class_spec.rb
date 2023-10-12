require_relative '../classes/person/teacher_class'

describe Teacher do
  let(:teacher) { Teacher.new(nil, 31, 'History', 'Hajnalka Oltyan', true) }

  describe 'when initialized' do
    it 'creates a new Teacher with a unique ID, age, specialization, name and parent_permission' do
      expect(teacher).to be_a(Teacher)
      expect(teacher.id).not_to be_nil
      expect(teacher.age).to eq(31)
      expect(teacher.specialization).to eq('History')
      expect(teacher.name).to eq('Hajnalka Oltyan')
      expect(teacher.parent_permission).to be true
    end
  end

  describe '#can_use_services?' do
    it 'returns true' do
      expect(teacher.can_use_services?).to be true
    end
  end

  describe '#to_json' do
    it 'returns a JSON representation of the teacher' do
      expected_json = { ID: teacher.id, Type: teacher.class, Age: 31, Specialization: 'History',
                        Name: 'Hajnalka Oltyan', Parent_Permission: true }
      expect(teacher.to_json).to eq(expected_json)
    end
  end
end
