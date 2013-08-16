class AddMeasuresCountToProvider < ActiveRecord::Migration
  def change
    add_column :providers, :measures_count, :integer, :null => false, :default => 0
  end
end
