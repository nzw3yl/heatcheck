class Customer < ActiveRecord::Base
  serialize :current_heatmap, ActiveRecord::Coders::Hstore
  include Measureable
  attr_accessible :description, :name, :parent_id, :temperature, :auto_temp, :partner_ids, :short_name
  
  before_create :set_short_name
  
  has_ancestry
  belongs_to :provider
  has_many :issues, as: :issueable
  has_many :contacts, as: :contactable
  has_many :contracts #watch the 'r'!
  has_many :partners, through: :contracts 
  counter_culture :provider
  
  validates :short_name, length: { in: 2..4 }, on: :update
  validates_length_of :name, minimum: 2 , allow_blank: false
  
  default_scope {where(provider_id: Provider.current_id)}

  def set_short_name
    if name.match(" ")
      self.short_name = name.gsub(/(\w)\w+\W*/, '\1').gsub(/\s+/, "")[0..3].upcase
    else
      self.short_name = name[0..3].upcase
    end
  end
end
