require_relative '../decorators/trimmer_class'

RSpec.describe TrimmerDecorator do
  let(:nameable) { double('Nameable') }
  let(:decorator) { TrimmerDecorator.new(nameable) }

  describe '#correct_name' do
    it 'when the name is longer than 10 characters, it trims the name' do
      allow(nameable).to receive(:correct_name).and_return('Maximilianus')
      expect(decorator.correct_name).to eq('Maximilian')
    end

    it 'return original name when shorter than 10 characters' do
      allow(nameable).to receive(:correct_name).and_return('John Smith')
      expect(decorator.correct_name).to eq('John Smith')
    end
  end
end
