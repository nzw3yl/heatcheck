class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :provider_id      
      t.integer  :user_id

      t.timestamps
    end
  end
end
