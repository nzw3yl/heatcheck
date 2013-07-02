class CreateIssueHistories < ActiveRecord::Migration
  def change
    create_table :issue_histories do |t|
      t.date :close_date
      t.string :issue_id
      t.string :content
      t.string :measure
      t.integer :temperature
      t.integer :issueable_id
      t.string :issueable_type

      t.timestamps
    end
  end
end
