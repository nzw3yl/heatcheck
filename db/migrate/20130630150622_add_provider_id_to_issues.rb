class AddProviderIdToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :provider_id, :integer
    add_index  :issues, :provider_id
  end
end
