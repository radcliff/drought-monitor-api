class DroughtshapesController < ApplicationController
  include ApplicationHelper

  def index
    if params[:s]
      state_name = params[:s].split.map {|i| i.capitalize}.join(" ")
      state = State.find_by(name: state_name)
      if state
        shapes = state.drought_shapes
        geojson_shapes = to_geojson(shapes)

        render json: convert_to_topojson(geojson_shapes)
      else
        render json: "not found"
      end
    else
      render json: about
    end
  end
end
