require_relative '../nameable_class'

class Decorator < Nameable
  def initialize
    @nameable = Nameable.new
  end

  # Implement and Override Nameable correct_name method
  def correct_name
    @nameable.correct_name
  end  
end