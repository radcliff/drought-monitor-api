include ApplicationHelper

response = Typhoeus.get("http://data.biogeo.ucdavis.edu/data/gadm2/shp/USA_adm.zip")

open("USA_adm.zip", "wb") do |file|
  file.write(response.body)
end

unzip_file("USA_adm.zip", "./data")

Region.create!([
  {name: "West"},
  # {name: "South"},
  # {name: "High Plains"},
  # {name: "Midwest"},
  # {name: "South"},
  # {name: "Northeast"},
  # {name: "Southeast"}
])

west = Region.find_by(name: "West")
# south = Region.find_by(name: "South")
# high_plains = Region.find_by(name: "High Plains")

RGeo::Shapefile::Reader.open("./data/USA_adm1.shp") do |file|
  index = 0
  while index <= 38
    case index
    when 1, 3, 6, 12, 19, 22, 25, 28, 30, 31, 38
      record = file[index]
      puts "#{record.index}: #{record.attributes}"
      
      state = west.states.new
      state.name = record.attributes["NAME_1"]
      state.boundary = record.geometry
      state.save!
    end
    index+=1  
  end 
end

western_states = west.states.map { |state| state }

RGeo::Shapefile::Reader.open("./data/USA_adm2.shp") do |file|
  index = 119
  while index <= 3144
    case index
    when 119..133, 209..330, 548..591, 1676..1730, 1824..1840, 1872..1904, 2287..2322, 2805..2833, 2978..3016, 3122..3144
      record = file[index]
      puts "#{record.index}: #{record.attributes}"
      state_name = record.attributes["NAME_1"]

      western_states.each_with_index do |el, i|
        @state = western_states[i] if state_name == el.name
      end

      county = @state.counties.new
      county.name = record.attributes["NAME_2"]
      county.boundary = record.geometry
      county.save!
    end
    index+=1
  end
end

`rm USA_adm.zip`

