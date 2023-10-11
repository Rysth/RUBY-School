require 'json'

module Manager
  DATA_FOLDER = './data'

  def self.load(data)
    file_path = File.join(DATA_FOLDER, "#{data}.json")
    if File.exist?(file_path)
      loaded_data = JSON.parse(File.read(file_path))
    else
      loaded_data = []
    end
    loaded_data
  end

  def self.write_file(filename, collection)
    file = File.new("./data/#{filename}", 'w+') 
    json_array = collection.map { |item| item.to_json }
    file.syswrite(JSON.pretty_generate(json_array))
    file.close
  end
end
