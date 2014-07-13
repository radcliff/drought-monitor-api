class CreateCounties < ActiveRecord::Migration
  def change
    create_table :counties do |t|
      t.string :name
      t.references :state, index: true
      t.multi_polygon :boundary, :srid => 4326

      t.timestamps
    end
  end
end
