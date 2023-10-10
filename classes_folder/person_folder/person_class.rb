require 'securerandom'
require_relative '../nameable_class'

class Person < Nameable
  attr_accessor :name, :age, :parent_permission
  attr_reader :id, :rentals

  def initialize(age, name = 'Unknown', parent_permission: true)
    super()
    @id = SecureRandom.hex(2)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  # Implement and Override Nameable correct_name method
  def correct_name
    @name
  end

  def add_rental(rental)
    @rentals << rental
    rental.assign_person(self)
  end

  private

  def of_age?
    @age >= 18
  end
end