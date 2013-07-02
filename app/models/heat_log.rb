class HeatLog < ActiveRecord::Base
  belongs_to :measure
  attr_accessible :entity_id, :entity_type, :provider_id, :temperature, :transaction_date, :measure_id
  default_scope {where(provider_id: Provider.current_id)}
end
