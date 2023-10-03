require_relative '../decorator_class'

class TrimmerDecorator < Decorator
  # Implement and Override Decorator correct_name method
  def correct_name
    return @person.correct_name[0..9] if @person.correct_name.length > 10
  end
end