module TopojsonHelper
  
  def convert_to_topojson(geojson)
    collection = geojson.to_json

    source = open('./lib/assets/topojson.js').read
    context = ExecJS.compile(source)

    topojson = context.eval("topojson.topology({collection: #{collection}})")

    return topojson
  end
  
end
