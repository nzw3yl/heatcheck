class IndexCustomersCurrentHeatmap < ActiveRecord::Migration
  def up
    execute "CREATE INDEX customers_current_heatmap ON customers USING GIN(current_heatmap)"
  end

  def down
    execute "DROP INDEX customers_current_heatmap"
  end
end
