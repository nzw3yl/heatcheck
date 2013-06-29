class Contact < ActiveRecord::Base
  attr_accessible :ancestry, :name, :team, :title, :parent_id
  belongs_to :contactable, polymorphic: true
  has_many :plans
  has_ancestry
  
  default_scope {where(provider_id: Provider.current_id)}
  
end
