class AddProviderIdToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :provider_id, :integer
    add_index :contacts, :provider_id
  end
end
