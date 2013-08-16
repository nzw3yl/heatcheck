class AddMembershipsCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :memberships_count, :integer, :null => false, :default => 0
  end
end
