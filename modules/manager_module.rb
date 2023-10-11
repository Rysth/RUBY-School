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
end
