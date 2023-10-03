require_relative 'decorator_class'

class CapitalizeDecorator < Decorator
  # Implement and Override Decorator correct_name method
  def correct_name
    @nameable.correct_name.capitalize
  end
end
