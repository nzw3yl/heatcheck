class AddCounterCultureColumnsToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :customers_count, :integer, :null => false, :default => 0
    add_column :providers, :partners_count, :integer, :null => false, :default => 0
    add_column :providers, :issues_count, :integer, :null => false, :default => 0
    add_column :providers, :plans_count, :integer, :null => false, :default => 0
  end
end
