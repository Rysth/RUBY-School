module Input
  LETTER_REGEX = /^[a-z ]+$/i.freeze

  def self.choose_person_type
    person_type = 0
    until [1, 2].include?(person_type)
      Commands.clear_screen
      puts 'Welcome to the CREATE_PERSON method.'
      print 'Do you want to create a STUDENT (1) or a TEACHER (2)? [Input the number]: '
      person_type = gets.chomp.to_i
    end
    person_type
  end

  def self.input_age
    age = 0
    until (1..120).cover?(age)
      Commands.clear_screen
      print "What's your age?: "
      age = gets.chomp.to_i
    end
    age
  end

  def self.input_name
    name = ''
    until !name.empty? && name.match(LETTER_REGEX)
      Commands.clear_screen
      print "What's your name?: "
      name = gets.chomp.capitalize.strip
    end
    name
  end

  def self.input_parent_acceptance
    parent_acceptance = ''
    until %w[Y N].include?(parent_acceptance)
      Commands.clear_screen
      print 'Has parent permission? [Y/N]: '
      parent_acceptance = gets.chomp.to_s.capitalize.strip
    end
    parent_acceptance
  end

  def self.input_specialization
    specialization = ''
    until !specialization.empty? && specialization.match(LETTER_REGEX)
      Commands.clear_screen
      print "What's your specialization?: "
      specialization = gets.chomp.capitalize.strip
    end
    specialization
  end

  def self.input_valid_string(prompt)
    input = ''
    until !input.empty? && input.match(LETTER_REGEX)
      Commands.clear_screen
      print "What's the #{prompt}: "
      input = gets.chomp.strip.capitalize
    end
    input
  end
end
