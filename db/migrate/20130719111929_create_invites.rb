class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.integer :user_id
      t.integer :provider_id
      t.string :invitee_email
      t.string :access_code
      t.boolean :accepted
      t.date :valid_thru

      t.timestamps
    end
  end
end
