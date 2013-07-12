class Contract < ActiveRecord::Base
  attr_accessible :customer_id, :expiry_date, :notes, :partner_id, :start_date
  belongs_to :customer
  belongs_to :partner
  belongs_to :provider
  counter_culture :provider, :column_name => Proc.new {|model| model.expiry_date.past? ? nil: 'contracts_count' }
  scope :finder, lambda { |q| where("name like :q", q: "%#{q}%") }
   
  default_scope {where(provider_id: Provider.current_id)}
  
end
