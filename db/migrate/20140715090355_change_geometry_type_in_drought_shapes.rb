class ChangeGeometryTypeInDroughtShapes < ActiveRecord::Migration
  def change
    change_column :drought_shapes, :shape, :geometry
  end
end
