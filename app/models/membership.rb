class Membership < ActiveRecord::Base
  attr_accessible :provider_id, :user_id
end
