class Customer < ActiveRecord::Base
  attr_accessible :description, :name, :parent_id, :temperature, :auto_temp
  has_ancestry
  belongs_to :provider
  has_many :issues, as: :issueable
  
  default_scope {where(provider_id: Provider.current_id)}
end
