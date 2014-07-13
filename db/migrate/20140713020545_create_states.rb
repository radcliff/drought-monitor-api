class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :name
      t.references :region, index: true
      t.multi_polygon :boundary, :srid => 4326

      t.timestamps
    end
  end
end
