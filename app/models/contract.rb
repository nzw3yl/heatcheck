class Contract < ActiveRecord::Base
  attr_accessible :customer_id, :expiry_date, :notes, :partner_id, :start_date
  belongs_to :customer
  belongs_to :partner
  scope :finder, lambda { |q| where("name like :q", q: "%#{q}%") }
   
  default_scope {where(provider_id: Provider.current_id)}
  
end
