class Measure < ActiveRecord::Base
  belongs_to :provider
  has_many :issues
  attr_accessible :content, :display_order, :weight
  before_validation :add_content_mask
  
  validates_presence_of :content
  counter_culture :provider
  
  default_scope {where(provider_id: Provider.current_id)}
  
  def to_label
     measure_mask = "measure_by_"
      if content.start_with?(measure_mask)
       content.sub(/^#{measure_mask}/,'').tr("_"," ").titleize
      else
        content.tr("_"," ").titleize
      end
  end
  
  protected
  def add_content_mask
    if attribute_present?(:content) && !content.start_with?("measure_by_")
      self.content = "measure_by_" + content.downcase.tr(" ","_") 
    end
  end

end
