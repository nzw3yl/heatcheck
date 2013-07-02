class AddCurrentHeatmapToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :current_heatmap, :hstore
  end
end
