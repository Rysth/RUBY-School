require_relative '../decorators/decorator_class'
require_relative '../classes/nameable_class'

class DummyNameable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def correct_name
    name
  end
end

describe Decorator do
  context 'when decorating an object' do
    it 'delegates the correct_name method to the decorated object' do
      dummy_nameable = DummyNameable.new('John Doe')
      decorator = Decorator.new(dummy_nameable)
      expect(decorator.correct_name).to eq('John Doe')
    end

    it 'delegates with a different input' do
      dummy_nameable = DummyNameable.new('Jane Smith')
      decorator = Decorator.new(dummy_nameable)
      expect(decorator.correct_name).to eq('Jane Smith')
    end
  end
end
