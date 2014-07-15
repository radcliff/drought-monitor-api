class AddIndexToStatesOnName < ActiveRecord::Migration
  def change
    change_table :states do |t|
      t.index :name
    end
  end
end