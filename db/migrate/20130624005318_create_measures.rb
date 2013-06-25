class CreateMeasures < ActiveRecord::Migration
  def change
    create_table :measures do |t|
      t.string :content
      t.integer :display_order
      t.integer :weight
      t.belongs_to :provider

      t.timestamps
    end
    add_index :measures, :provider_id
  end
end
