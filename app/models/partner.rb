class Partner < ActiveRecord::Base
  serialize :current_heatmap, ActiveRecord::Coders::Hstore
  include Measureable
  attr_accessible :description, :name, :parent_id, :temperature, :auto_temp, :customer_ids
  has_ancestry
  belongs_to :provider
  has_many :issues, as: :issueable
  has_many :contacts, as: :contactable
  has_many :contracts #watch the 'r'!
  has_many :customers, through: :contracts
  counter_culture :provider
  
  default_scope {where(provider_id: Provider.current_id)}
  
  

  
end
