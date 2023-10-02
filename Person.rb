class Person
  def initialize(id, name = 'Unknown', age, parent_permission = true)
    @id = id
    @name = name
    @age = age
  end

  def id
    @id
  end

  def name?(name)
    @name = name
  end

  def name
    @name
  end

  def age?(age)
    @age = age
  end

  def age
    @age
  end
end