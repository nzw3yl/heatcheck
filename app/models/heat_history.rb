class HeatHistory < ActiveRecord::Base
   serialize :temperature, ActiveRecord::Coders::Hstore
  attr_accessible :entity_id, :entity_type, :temperature, :week, :year
  
  %w[product stability account_response].each do |key|
     attr_accessible key
     scope "has_#{key}", lambda { |value| where("temperature @> (? => ?)", key, value) }

     define_method(key) do
       temperature && temperature[key]
     end

     define_method("#{key}=") do |value|
       self.temperature = (temperature || {}).merge(key => value)
     end
   end
end
