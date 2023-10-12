require_relative '../classes/person/person_class'

describe Person do
  context 'When valid input' do
    describe 'using the initialize() method' do
      it 'create a new Person with name John' do
        person = Person.new(nil, 20, 'John', parent_permission: true)
        expect(person.id).not_to be_nil
        expect(person.name).to eql 'John'
        expect(person.age).to be >= 18
        expect(person.parent_permission).to be true
      end
    end
    describe 'using the correct_name() method' do
      it 'create a new Person with name John' do
        person = Person.new(nil, 18, 'John', parent_permission: false)
        expect(person.correct_name).to eql 'John'
      end
    end
    describe 'using the to_json() method' do
      it 'returns a JSON representation of the Person' do
        person = Person.new('0a6c', 23, 'John Palacios', parent_permission: true)
        expected_json = { ID: '0a6c', Type: person.class, Name: 'John Palacios', Age: 23 }
        expect(person.to_json).to eql(expected_json)
      end
    end
  end
  context 'When wrong input' do
    describe 'using the initialize() method' do
      it 'create a new Person with name John' do
        person = Person.new('0a6c', 20, 'Jean', parent_permission: true)
        expect(person.id).to eql '0a6c'
        expect(person.name).not_to eql 'John'
        expect(person.age).to be_between(18, 120).inclusive
        expect(person.parent_permission).to be true
      end
    end
    describe 'using the correct_name() method' do
      it 'create a new Person with name John' do
        person = Person.new(nil, 18, nil, parent_permission: false)
        expect(person.correct_name).to be nil
      end
    end
    describe 'using the to_json() method' do
      it 'returns a JSON representation of the Person' do
        person = Person.new('0a6c', 20, 'John', parent_permission: true)
        expected_json = { ID: '0a6c', Type: person.class, Name: 'John Palacios', Age: 23 }
        expect(person.to_json).not_to eql(expected_json)
      end
    end
  end
end
