require 'securerandom'

class Book
  attr_accessor :title, :author
  attr_reader :id

  def initialize(title, author)
    @id = SecureRandom.hex(2)
    @title = title
    @author = author
    @rentals = []
  end

  def add_rental(rental)
    @rentals << rental
    rental.add_book(self)
  end

  def to_json
    { title: @title, author: @author }
  end
end
