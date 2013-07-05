class AddProviderIdToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :provider_id, :integer
    add_index  :contracts, :provider_id
  end
end
