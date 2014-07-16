module ApplicationHelper
  include GeojsonHelper
  include TopojsonHelper
  
  # this method unzips a .zip file
  def unzip_file (file_name, destination_path)
    Zip::File.open(file_name) do |zip_file|
     zip_file.each do |f|
       f_path = File.join(destination_path, f.name)
       FileUtils.mkdir_p(File.dirname(f_path))
       zip_file.extract(f, f_path) unless File.exist?(f_path)
     end
    end
  end
end
