class IssueHistory < ActiveRecord::Base
  attr_accessible :close_date, :content, :issue_id, :issueable_id, :issueable_type, :measure, :temperature
  default_scope {where(provider_id: Provider.current_id)}
end
