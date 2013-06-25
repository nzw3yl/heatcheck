class AddStatusToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :temperature, :integer, :default => 0
    add_column :customers, :auto_temp, :boolean, :default => true
  end
end
