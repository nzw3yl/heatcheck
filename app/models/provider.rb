class Provider < ActiveRecord::Base
  attr_accessible :description, :name, :creator_id
  has_one :user
  has_many :memberships
  has_many :users,  through: :memberships
  has_many :customers
  has_many :partners
  has_many :measures
  has_many :issues
  cattr_accessor :current_id
  has_many :contacts, as: :contactable
  has_many :invites
  
  after_create :attach_to_creator
  
  
  private
    def attach_to_creator
      User.find_by_id(creator_id).update_column(:provider_id, self.id)
      Membership.where(:provider_id => self.id, :user_id => creator_id).first_or_create
    end
end
