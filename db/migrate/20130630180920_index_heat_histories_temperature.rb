class IndexHeatHistoriesTemperature < ActiveRecord::Migration
  def up
    execute "CREATE INDEX heat_histories_temperature ON heat_histories USING GIN(temperature)"
  end

  def down
    execute "DROP INDEX heat_histories_temperature"
  end
end
