class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :content
      t.boolean :complete, :default => false
      t.integer :contact_id
      t.belongs_to :issue

      t.timestamps
    end
    add_index :plans, :issue_id
  end
end
