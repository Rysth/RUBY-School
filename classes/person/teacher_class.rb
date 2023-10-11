require_relative 'person_class'

class Teacher < Person
  attr_accessor :specialization

  def initialize(id = nil, age, specialization, name, parent_permission)
    super(id, age, name, parent_permission: parent_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end

  def to_json(*_args)
    { ID: @id, Type: self.class, Name: @name, Age: @age, Specialization: @specialization,
      Parent_Permission: @parent_permission }
  end
end
