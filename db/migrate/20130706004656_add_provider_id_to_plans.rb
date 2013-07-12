class AddProviderIdToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :provider_id, :integer
    add_index  :plans, :provider_id
  end
end
