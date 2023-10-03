class Nameable
  def correct_name
    raise NotImplementedError.new "No implemented yet."
  end
end

name = Nameable.new
puts name.correct_name