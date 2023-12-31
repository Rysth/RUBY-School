require_relative '../classes/nameable_class'

class Decorator < Nameable
  def initialize(nameable)
    super()
    @nameable = nameable
  end

  # Implement and Override Nameable correct_name method
  def correct_name
    @nameable.correct_name
  end
end
