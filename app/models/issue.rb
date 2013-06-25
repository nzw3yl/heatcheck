class Issue < ActiveRecord::Base
  attr_accessible :content, :temperature, :measure_id
  belongs_to :issuable, polymorphic: true
  belongs_to :measure
  has_many :plans
end
