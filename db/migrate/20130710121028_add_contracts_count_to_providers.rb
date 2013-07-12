class AddContractsCountToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :contracts_count, :integer, :null => false, :default => 0
  end
end
