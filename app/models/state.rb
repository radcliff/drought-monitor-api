class State < ActiveRecord::Base
  belongs_to :region
  has_many :counties
  has_many :drought_shapes, through: :counties
  has_many :drought_shapes

  wgs84_proj4 = '+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs'
  wgs84_wkt = <<WKT
    GEOGCS["WGS 84",
      DATUM["WGS_1984",
        SPHEROID["WGS 84",6378137,298.257223563,
          AUTHORITY["EPSG","7030"]],
        AUTHORITY["EPSG","6326"]],
      PRIMEM["Greenwich",0,
        AUTHORITY["EPSG","8901"]],
      UNIT["degree",0.01745329251994328,
        AUTHORITY["EPSG","9122"]],
      AUTHORITY["EPSG","4326"]]
WKT

  wgs84_factory = RGeo::Geographic.simple_mercator_factory(:srid => 4326,
    :proj4 => wgs84_proj4, :coord_sys => wgs84_wkt)

  set_rgeo_factory_for_column(:boundary, wgs84_factory)
end
