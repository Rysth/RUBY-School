require 'securerandom'

class Person
  def initialize(age, name = 'Unknown', parent_permission: true)
    @id = SecureRandom.uuid
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  def id?
    @id
  end

  def name!(name)
    @name = name
  end

  def name?
    @name
  end

  def age!(age)
    @age = age
  end

  def age?
    @age
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  private

  def of_age?
    @age >= 18
  end
end
