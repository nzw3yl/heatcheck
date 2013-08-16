class Membership < ActiveRecord::Base
  attr_accessible :provider_id, :user_id
  belongs_to :user
  belongs_to :provider
  counter_culture :user
end
