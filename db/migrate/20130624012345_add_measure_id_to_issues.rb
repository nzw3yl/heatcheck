class AddMeasureIdToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :measure_id, :integer
    add_index :issues, :measure_id
  end
end
