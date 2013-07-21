class HeatHistory < ActiveRecord::Base
  serialize :temperature, ActiveRecord::Coders::Hstore
  include Measureable
  attr_accessible :entity_id, :entity_type, :temperature, :week, :year
  

end
