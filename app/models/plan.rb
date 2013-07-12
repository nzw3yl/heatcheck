class Plan < ActiveRecord::Base
  belongs_to :issue
  belongs_to :contact
  belongs_to :provider
  attr_accessible :complete, :contact_id, :content, :contact_name
  default_scope {where(provider_id: Provider.current_id)}
  
  counter_culture :provider, :column_name => Proc.new {|model| model.complete? ? nil: 'plans_count' }
  def contact_name
    read_attribute('contact_name') || contact.try(:name)
  end
  
  def contact_name=(name)
    self.contact = Contact.where("name ILIKE ?", name).first if name.present?
  end
end
