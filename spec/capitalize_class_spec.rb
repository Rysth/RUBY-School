require_relative '../decorators/capitalize_class'

describe CapitalizeDecorator do
  # Create a dummy class for testing
  class DummyNameable
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def correct_name
      name
    end
  end

  context 'when decorating an object' do
    it 'capitalizes the name using correct_name method' do
      dummy_nameable = DummyNameable.new('john')
      decorated_nameable = CapitalizeDecorator.new(dummy_nameable)
      expect(decorated_nameable.correct_name).to eq('John')
    end

    it 'capitalizes the name with a different input' do
      dummy_nameable = DummyNameable.new('jane')
      decorated_nameable = CapitalizeDecorator.new(dummy_nameable)
      expect(decorated_nameable.correct_name).to eq('Jane')
    end
  end
end
