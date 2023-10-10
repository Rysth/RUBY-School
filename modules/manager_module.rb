require 'json'

module Manager
  DATA_FOLDER = './data'

  def self.load
    file_path = File.join(DATA_FOLDER, 'books.json')

    if File.exist?(file_path)
      json_data = File.read(file_path)
      books = JSON.parse(json_data)
      books.each { |book| puts book }
    else
      puts "The file #{file_path} does not exist."
    end
  end
end

Manager.load