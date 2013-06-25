class Measure < ActiveRecord::Base
  belongs_to :provider
  has_many :issues
  attr_accessible :content, :display_order, :weight
  
  default_scope {where(provider_id: Provider.current_id)}
  
  def to_label
    "#{content}"
  end
end
