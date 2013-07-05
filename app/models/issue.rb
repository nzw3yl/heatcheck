class Issue < ActiveRecord::Base
  attr_accessible :content, :temperature, :measure_id
  belongs_to :issuable, polymorphic: true
  belongs_to :measure
  belongs_to :provider
  has_many :plans
  before_destroy :add_history
  default_scope {where(provider_id: Provider.current_id)}
  counter_culture :provider
  
  include Logging
  

  
  def add_history
     new_issue_histories_entry = IssueHistory.new do |ih|
        ih.close_date = Time.now()
        ih.content = self.content
        ih.issue_id = self.id
        ih.temperature = self.temperature
        ih.issueable_id = self.issueable_id
        ih.issueable_type = self.issueable_type
        ih.provider_id = self.provider_id
        ih.measure = Measure.find_by_id(self.measure_id).try(:content)
      end
      new_issue_histories_entry.save!
  end
end
