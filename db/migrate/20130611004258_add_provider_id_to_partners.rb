class AddProviderIdToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :provider_id, :integer
    add_index  :partners, :provider_id
  end
end
