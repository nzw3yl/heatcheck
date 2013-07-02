class IndexPartnersCurrentHeatmap < ActiveRecord::Migration
  def up
    execute "CREATE INDEX partners_current_heatmap ON partners USING GIN(current_heatmap)"
  end

  def down
    execute "DROP INDEX partners_current_heatmap"
  end
end
