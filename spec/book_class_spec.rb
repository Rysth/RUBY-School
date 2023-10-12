require_relative '../classes/book/book_class'

describe Book do
  let(:book) { Book.new(nil, 'Pride and Prejudice', 'Jane Austen') }

  describe 'when initialized' do
    it 'creates a new book with a unique ID, title, and author' do
      expect(book).to be_a(Book)
      expect(book.id).not_to be_nil
      expect(book.title).to eq('Pride and Prejudice')
      expect(book.author).to eq('Jane Austen')
    end
  end

  describe '#add_rental' do
    let(:rental) { instance_double('Rental') }

    it 'adds a rental to the book and adds the book to the rental' do
      expect(rental).to receive(:add_book).with(book)
      book.add_rental(rental)
      expect(book.instance_variable_get(:@rentals)).to include(rental)
    end
  end

  describe '#to_json' do
    it 'returns a JSON representation of the book' do
      expected_json = { ID: book.id, Title: 'Pride and Prejudice', Author: 'Jane Austen' }
      expect(book.to_json).to eq(expected_json)
    end
  end
end
