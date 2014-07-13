class CreateDroughtShapes < ActiveRecord::Migration
  def change
    create_table :drought_shapes do |t|
      t.integer :date
      t.integer :dm
      t.references :county, index: true
      t.multi_polygon :shape, :srid => 4326

      t.timestamps
    end
  end
end
