class Provider < ActiveRecord::Base
  attr_accessible :description, :name
  has_many :users
  has_many :customers
  has_many :partners
  has_many :measures
  has_many :issues
  cattr_accessor :current_id
  has_many :contacts, as: :contactable
  
  
end
