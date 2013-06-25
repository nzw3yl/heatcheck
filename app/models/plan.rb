class Plan < ActiveRecord::Base
  belongs_to :issue
  attr_accessible :complete, :contact_id, :content
end
