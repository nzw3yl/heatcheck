 class Invite < ActiveRecord::Base
  attr_accessible :accepted, :access_code, :invitee_email, :provider_id, :user_id, :valid_thru
  belongs_to  :provider
end
