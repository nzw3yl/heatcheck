class AddInviteCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :invites_count, :integer, :null => false, :default => 0
  end
end
