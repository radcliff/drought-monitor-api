module GeojsonHelper

  # this method takes in a RGeo geometry object and returns a GeoJSON object
  def to_geojson(geometry_collection)
    
    geojson_object = {}
    geojson_object["type"] = "FeatureCollection"
    geojson_object["features"] = []

    geometry_collection.each_with_index do |record, index|
    feature = RGeo::GeoJSON::Feature.new(record.shape, index, { :DM => record.dm } )
      geojson_object["features"].push(RGeo::GeoJSON.encode(feature))
    end

    return geojson_object
  end  

  # this method takes in a GeoJSON object and saves it to disk
  def json_to_file(object, file_path_and_name)
    open("#{file_path_and_name}.json", "wb") do |file|  
      file.write(object.to_json)
      true
    end
  end

end
