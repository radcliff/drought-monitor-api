class AddColumnToDroughtShapes < ActiveRecord::Migration
  def change
    add_reference :drought_shapes, :state, index: true
  end
end
