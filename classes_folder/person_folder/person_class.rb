require 'securerandom'
require_relative '../nameable_class'

class Person < Nameable
  attr_accessor :name, :age, :parent_permission
  attr_reader :id, :rentals

  def initialize(id, age, name = 'Unknown', parent_permission: true)
    super()
    @id = id == nil ? SecureRandom.hex(2) : id
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

  def to_json
    { ID: @id, Type: self.class, Name: @name, Age: @age }
  end

  private

  def of_age?
    @age >= 18
  end
end
