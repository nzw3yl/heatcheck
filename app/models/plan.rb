class Plan < ActiveRecord::Base
  belongs_to :issue
  belongs_to :contact
  attr_accessible :complete, :contact_id, :content, :contact_name
  
  def contact_name
    contact.try(:name)
  end
  
  def contact_name=(name)
    self.contact = Contact.where("name ILIKE ?", name).first if name.present?
  end
end
