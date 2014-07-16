module TopojsonHelper

  def convert_to_topojson(geojson)
    json_to_file(geojson, "drought")
    `topojson -o drought-topo.json drought.json`
    topojson = File.read ('drought-topo.json')
    `rm drought.json`
    `rm drought-topo.json`
    return topojson
  end
  
end
