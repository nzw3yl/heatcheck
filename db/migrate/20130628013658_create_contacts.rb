class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :title
      t.string :team
      t.string :ancestry
      t.integer :contactable_id
      t.string :contactable_type

      t.timestamps
    end
    add_index :contacts, [:contactable_id, :contactable_type]
    add_index :contacts, :ancestry
  end
end
