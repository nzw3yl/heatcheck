class AddCreatorIdToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :creator_id, :integer
  end
end
