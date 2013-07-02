class CreateHeatHistories < ActiveRecord::Migration
  def change
    create_table :heat_histories do |t|
      t.integer :year
      t.integer :week
      t.hstore :temperature
      t.integer :entity_id
      t.string :entity_type

      t.timestamps
    end
  end
end
