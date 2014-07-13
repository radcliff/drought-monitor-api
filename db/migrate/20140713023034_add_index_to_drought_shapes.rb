class AddIndexToDroughtShapes < ActiveRecord::Migration
  def change
    change_table :drought_shapes do |t|
      t.index :shape, :spatial => true
    end
  end
end
