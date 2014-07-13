class AddIndexToStates < ActiveRecord::Migration
  def change
    change_table :states do |t|
      t.index :boundary, :spatial => true
    end
  end
end
