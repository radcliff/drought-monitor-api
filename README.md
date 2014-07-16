#the unofficial US Drought Monitor API

![image](http://cbssanfran.files.wordpress.com/2014/01/drought.jpg?w=620&h=349&crop=1)

>The U.S. Drought Monitor, established in 1999, is a weekly map of drought conditions that is produced jointly by the National Oceanic and Atmospheric Administration, the U.S. Department of Agriculture, and the National Drought Mitigation Center (NDMC) at the University of Nebraska-Lincoln.

##About
This Rails app exposes a public API for the US Drought Monitor dataset. It grabs USDM shapefiles, clips the geometries, and allows queries for specfic subsets of the data which will be returned as a JSON document.


##Usage
`http://secret-falls-4489.herokuapp.com/?s=new%20mexico&geo=true`

| Parameter | Value  | Description                                             |
|-----------|--------|---------------------------------------------------------|
| s         | string | state name, replaces spaces with "%20"                  |
| geo       | true   | required, responds with GeoJSON (topojson coming soon) |

###Working with GeoJSON
**When specifying** `geo=true` **in the query string:**

* responses will be in the form of GeoJSON "feature collections" 
* each feature has a `properties` object with a `DM` key
* `DM` refers to the [USDM drought severity classification](http://droughtmonitor.unl.edu/AboutUs/ClassificationScheme.aspx) associated with this feature

###Working with TopoJSON
**coming soon**


####Note:
The U.S. Drought Monitor is jointly produced by the National Drought Mitigation Center at the University of Nebraska-Lincoln, the United States Department of Agriculture, and the National Oceanic and Atmospheric Administration. Map data courtesy of NDMC-UNL.

More information on the USDM [here](http://droughtmonitor.unl.edu/AboutUSDM/Background.aspx).
