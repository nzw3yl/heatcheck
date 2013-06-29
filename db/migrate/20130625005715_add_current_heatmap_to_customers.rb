class AddCurrentHeatmapToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :current_heatmap, :hstore
  end
end
