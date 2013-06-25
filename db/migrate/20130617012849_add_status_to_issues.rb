class AddStatusToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :temperature, :integer, :default => 0
    add_column :issues, :auto_temp, :boolean, :default => true
  end
end
