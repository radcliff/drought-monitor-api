namespace :drought do

  desc "make HTTP request for drought data from US Drought Monitor"
  task :grab_zip => :environment do
    include ApplicationHelper
    puts "requesting shapefile..."
    @response = Typhoeus.get("http://droughtmonitor.unl.edu/data/shapefiles_m/USDM_20140708_M.zip")
    puts "#{@response.code}: #{@response.effective_url}"
  end

  desc "save zip file in application memory"
  task :save_zip do |task, argument|
    argument.with_defaults(:response => @response)
    open("USDM_20140708_M.zip", "wb") do |file|
      file.write(@response.body)
    end
  end

  desc "unzip zip file contents to disk"
  task :unzip do
    unzip_file("USDM_20140708_M.zip", "./data/")
  end

  desc "read shapefile, clip layers by county, save to database"
  task :shovel => [:grab_zip, :save_zip, :unzip] do
    num_counties = County.count

    RGeo::Shapefile::Reader.open("./data/USDM_20140708.shp") do |file|
      file.each do |record|
        index = 1
        
        while index <= num_counties
          county = County.where(id: index).first
          puts "#{county.id} of #{num_counties}: #{county.name} DM: #{record.attributes["DM"]}"
          
          shape = (record.geometry).intersection(county.boundary)
          
          if shape.to_s == "GEOMETRYCOLLECTION EMPTY"
            print "  GEOMETRYCOLLECTION EMPTY\n"
          else
            county_drought_shape = county.drought_shapes.new
            county_drought_shape.date = 20140708
            county_drought_shape.dm = record.attributes["DM"]
            county_drought_shape.shape = shape
            county_drought_shape.save!
            print "COMMIT\n"
          end

          index+=1
        end
      end
    end

    num_states = State.count
    RGeo::Shapefile::Reader.open("./data/USDM_20140708.shp") do |file|
      file.each do |record|
        index = 1
        
        while index <= num_states
          state = State.where(id: index).first
          puts "#{state.id} of #{num_states}: #{state.name} DM: #{record.attributes["DM"]}"
          
          shape = (record.geometry).intersection(state.boundary)
          
          if shape.to_s == "GEOMETRYCOLLECTION EMPTY"
            print "  GEOMETRYCOLLECTION EMPTY\n"
          else
            state_drought_shape = state.drought_shapes.new
            state_drought_shape.date = 20140708
            state_drought_shape.dm = record.attributes["DM"]
            state_drought_shape.shape = shape
            state_drought_shape.save!
            print "COMMIT\n"
          end

          index+=1
        end
      end
    end
  end
end
