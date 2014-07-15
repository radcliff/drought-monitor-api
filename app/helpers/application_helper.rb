module ApplicationHelper
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

  # this method takes in a RGeo geometry object and returns a GeoJSON object
  def to_geojson(geometry, index, attributes={})
    # `geometry` is an RGeo geometry object,
    # `index` is a value to be set on :id,
    # `attributes` is a hash of properties 
    
    @object = {}
    @object["type"] = "FeatureCollection"
    @object["features"] = []

    feature = RGeo::GeoJSON::Feature.new(geometry, index, attributes)
      @object["features"].push(RGeo::GeoJSON.encode(feature))

    return @object
  end  

  # this method takes in a GeoJSON object and saves it to disk
  def json_to_file(object, file_path_and_name)
    open("#{file_path_and_name}.json", "wb") do |file|  
      file.write(object.to_json)
      true
    end
  end
end