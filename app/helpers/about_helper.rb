module AboutHelper
  def about
    about = {
      :title => "the unofficial US Drought Monitor API",
      :about => "JSON API for the USDM dataset, updated weekly",
      :updated => "July 8, 2014",
      :note => "The U.S. Drought Monitor is jointly produced by the National Drought Mitigation Center at the University of Nebraska-Lincoln, the United States Department of Agriculture, and the National Oceanic and Atmospheric Administration. Map data courtesy of NDMC-UNL.",
      :source => "http://droughtmonitor.unl.edu/AboutUSDM/",
      :parameters => [
        {
          :paramter => "s",
          :value => "string",
          :description => "state name",
          :note => "currently, only states in western region are valid"
        },
        {
          :paramter => "geo",
          :value => "true",
          :description => "responds with geojson",
          :note => "required (topojson coming soon)"
        }
      ],
      :usage => "/?s=new%20mexico&geo=true"
    }
  end
end