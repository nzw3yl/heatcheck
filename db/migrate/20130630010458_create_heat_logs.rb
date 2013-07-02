class CreateHeatLogs < ActiveRecord::Migration
  def change
    create_table :heat_logs do |t|
      t.date :transaction_date
      t.string :entity_type
      t.integer :entity_id
      t.integer :temperature
      t.belongs_to :measure
      t.integer :provider_id

      t.timestamps
    end
    add_index :heat_logs, :measure_id
    add_index :heat_logs, [:entity_id, :entity_type]
    add_index :heat_logs, :transaction_date
  end
end
