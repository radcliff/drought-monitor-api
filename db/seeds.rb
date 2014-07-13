def unzip_file (file_name, destination_path)
  Zip::File.open(file_name) do |zip_file|
   zip_file.each do |f|
     f_path = File.join(destination_path, f.name)
     FileUtils.mkdir_p(File.dirname(f_path))
     zip_file.extract(f, f_path) unless File.exist?(f_path)
   end
  end
end

response = Typhoeus.get("http://data.biogeo.ucdavis.edu/data/gadm2/shp/USA_adm.zip")

open("USA_adm.zip", "wb") do |file|
  file.write(response.body)
end

unzip_file("USA_adm.zip", "./data")

