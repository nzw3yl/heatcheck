class AddAncestryToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :ancestry, :string
    add_index  :partners, :ancestry
  end
end
