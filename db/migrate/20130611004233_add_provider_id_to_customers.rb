class AddProviderIdToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :provider_id, :integer
    add_index  :customers, :provider_id
  end
end
