class AddStatusToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :temperature, :integer, :default => 0
    add_column :partners, :auto_temp, :boolean, :default => true
  end
end
