require_relative '../decorator_class'

class CapitalizeDecorator < Decorator
  # Implement and Override Decorator correct_name method
  def correct_name
    @person.correct_name.capitalize
  end
end