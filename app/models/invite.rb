 class Invite < ActiveRecord::Base
  attr_accessible :accepted, :access_code, :invitee_email, :provider_id, :user_id, :valid_thru
  belongs_to  :provider
  belongs_to  :user
  before_create :set_valid_period
 # counter_culture :user, :column_name => Proc.new {|model| (model.email == self.invitee_email) ? 'invites_count' : nil }

  
  def accept!
    self.accepted = true
    self.save
  end
  
  private
   def set_valid_period
     self.valid_thru = DateTime.now + 3.days
   end
end
