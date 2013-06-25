class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.text :content
      t.integer :issueable_id
      t.string :issueable_type

      t.timestamps
    end
    add_index :issues, [:issueable_id, :issueable_type]
  end
end
