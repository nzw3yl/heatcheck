class AddProviderIdToIssueHistories < ActiveRecord::Migration
  def change
    add_column :issue_histories, :provider_id, :integer
    add_index  :issue_histories, :provider_id
  end
end
