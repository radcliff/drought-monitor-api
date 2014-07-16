class DroughtshapesController < ApplicationController
  include ApplicationHelper

  def index
    if params[:s]
      state_name = params[:s].split.map {|i| i.capitalize}.join(" ")
      state = State.find_by(name: state_name)
      if state
        shapes = state.drought_shapes
        geojson_shapes = to_geojson(shapes)
        if params[:geo] == "true"
          render json: geojson_shapes
        else
          render json: convert_to_topojson(geojson_shapes)
        end
      else
        render json: "not found - check query string and try again"
      end
    else
      render json: about
    end
  end
end
