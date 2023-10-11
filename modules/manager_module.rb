require 'json'

module Manager
  DATA_FOLDER = './data'

  def self.load_app(app)
    file_path = File.join(DATA_FOLDER, 'books.json')

    if File.exist?(file_path)
      json_data = File.read(file_path)
      app.books = JSON.parse(json_data)
      gets.chomp
    else
      puts "The file #{file_path} does not exist."
    end
  end
end