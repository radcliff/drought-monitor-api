class AddIndexToCounties < ActiveRecord::Migration
  def change
    change_table :counties do |t|
      t.index :boundary, :spatial => true
    end
  end
end
