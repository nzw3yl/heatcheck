class Customer < ActiveRecord::Base
  serialize :current_heatmap, ActiveRecord::Coders::Hstore
  attr_accessible :description, :name, :parent_id, :temperature, :auto_temp, :partner_ids
  
  has_ancestry
  belongs_to :provider
  has_many :issues, as: :issueable
  has_many :contacts, as: :contactable
  has_many :contracts #watch the 'r'!
  has_many :partners, through: :contracts 
  counter_culture :provider
 
  
  default_scope {where(provider_id: Provider.current_id)}

    #Measure.pluck(:content).map(&:downcase).each do |key|
     %w[product stability account_response].each do |key|
        attr_accessible key
        scope "has_#{key}", lambda { |value| where("current_heatmap @> (? => ?)", key, value) }

        define_method(key) do
          current_heatmap && current_heatmap[key]
        end

        define_method("#{key}=") do |value|
          self.current_heatmap = (current_heatmap || {}).merge(key => value)
        end
      end

end
