require 'securerandom'

class Book
  attr_accessor :title, :author
  attr_reader :id, :rentals

  def initialize(id, title, author)
    @id = id.nil? ? SecureRandom.hex(2) : id
    @title = title
    @author = author
    @rentals = []
  end

  def add_rental(rental)
    @rentals << rental
    rental.add_book(self)
  end

  def to_json(*_args)
    { ID: @id, Title: @title, Author: @author }
  end
end
