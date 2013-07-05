class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.integer :partner_id
      t.integer :customer_id
      t.date :expiry_date
      t.date :start_date
      t.text :notes

      t.timestamps
    end
    add_index :contracts, :partner_id
    add_index :contracts, :customer_id
  end
end
